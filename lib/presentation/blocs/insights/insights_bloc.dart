import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/app_error.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/budget/get_category_variances.dart';
import '../../../domain/usecases/budget/get_wealth_history.dart';

part 'insights_bloc.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

@freezed
class InsightsEvent with _$InsightsEvent {
  const factory InsightsEvent.load(DateTime month) = _Load;
  const factory InsightsEvent.previousMonth() = _PreviousMonth;
  const factory InsightsEvent.nextMonth() = _NextMonth;
}

// ── State ────────────────────────────────────────────────────────────────

@freezed
class InsightsState with _$InsightsState {
  const factory InsightsState.initial() = _Initial;
  const factory InsightsState.loading() = _Loading;
  const factory InsightsState.loaded({
    required DateTime month,
    required List<TransactionEntity> currentMonthTransactions,
    required List<MonthlySurplusEntity> wealthHistory,
    required List<List<CategoryVarianceEntity>> historicalVariances,
  }) = _Loaded;
  const factory InsightsState.failure(String message) = _Failure;
}

// ── BLoC ──────────────────────────────────────────────────────────────────

@injectable
class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  final GetCategoryVariancesUseCase _variancesUseCase;
  final TransactionRepository _txRepo;
  final GetWealthHistoryUseCase _wealthHistoryUseCase;

  DateTime _currentMonth = DateTime(
      DateTime.now().year, DateTime.now().month, 1);

  StreamSubscription<List<TransactionEntity>>? _txSub;

  InsightsBloc(
    this._variancesUseCase,
    this._txRepo,
    this._wealthHistoryUseCase,
  ) : super(const InsightsState.initial()) {
    on<_Load>(_onLoad);
    on<_PreviousMonth>(_onPrev);
    on<_NextMonth>(_onNext);

    _listenToTransactions();
  }

  Future<void> _onLoad(_Load event, Emitter<InsightsState> emit) async {
    final isNewMonth = _currentMonth != event.month || _txSub == null;
    _currentMonth = event.month;
    
    if (isNewMonth) {
      emit(const InsightsState.loading());
    }

    await _loadData(emit);
    
    if (isNewMonth) {
      _listenToTransactions();
    }
  }

  void _listenToTransactions() {
    _txSub?.cancel();
    _txSub = _txRepo.watchTransactionsByMonth(_currentMonth).listen(
      (_) => add(InsightsEvent.load(_currentMonth)),
    );
  }

  Future<void> _onPrev(
      _PreviousMonth event, Emitter<InsightsState> emit) async {
    final prev = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    add(InsightsEvent.load(prev));
  }

  Future<void> _onNext(
      _NextMonth event, Emitter<InsightsState> emit) async {
    final next = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    add(InsightsEvent.load(next));
  }

  Future<void> _loadData(Emitter<InsightsState> emit) async {
    // Fetch all transactions for the current month
    final txResult = await _txRepo.getTransactionsPaged(
        offset: 0,
        limit: 10000,
        fromDate: DateTime(_currentMonth.year, _currentMonth.month, 1),
        toDate:
            DateTime(_currentMonth.year, _currentMonth.month + 1, 1)
                .subtract(const Duration(milliseconds: 1)));

    final wealthHistoryResult = await _wealthHistoryUseCase(_currentMonth);
    if (wealthHistoryResult.isErr) {
      emit(InsightsState.failure(wealthHistoryResult.error.displayMessage));
      return;
    }

    // Fetch historical variances for the same months as wealth history
    final List<List<CategoryVarianceEntity>> historicalVariances = [];
    if (wealthHistoryResult.isOk) {
      for (final m in wealthHistoryResult.value) {
        final vRes = await _variancesUseCase(m.month);
        if (vRes.isOk) {
          historicalVariances.add(vRes.value);
        } else {
          historicalVariances.add([]);
        }
      }
    }

    emit(InsightsState.loaded(
      month: _currentMonth,
      currentMonthTransactions: txResult.isOk ? txResult.value : [],
      wealthHistory: wealthHistoryResult.value,
      historicalVariances: historicalVariances,
    ));
  }

  @override
  Future<void> close() {
    _txSub?.cancel();
    return super.close();
  }
}
