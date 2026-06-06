import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/app_error.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/budget/calculate_monthly_surplus.dart';
import '../../../domain/usecases/budget/get_category_variances.dart';
import '../../../domain/usecases/budget/get_wealth_history.dart';

part 'dashboard_bloc.freezed.dart';

// ── Events ────────────────────────────────────────────────────────────────

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.load(DateTime month) = _Load;
  const factory DashboardEvent.previousMonth() = _PreviousMonth;
  const factory DashboardEvent.nextMonth() = _NextMonth;
  const factory DashboardEvent.changeSortPreference(String preference) = _ChangeSortPreference;
  const factory DashboardEvent.changeTransactionSortPreference(String preference) = _ChangeTransactionSortPreference;
  const factory DashboardEvent.toggleDashboardChart(String chartId) = _ToggleDashboardChart;
}

// ── State ────────────────────────────────────────────────────────────────

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.loaded({
    required DateTime month,
    required MonthlySurplusEntity surplus,
    required List<CategoryVarianceEntity> variances,
    required List<TransactionEntity> recentTransactions,
    required List<TransactionEntity> pendingTransactions,
    required List<MonthlySurplusEntity> wealthHistory,
    required List<List<CategoryVarianceEntity>> historicalVariances,
    required String sortPreference,
    @Default('dateDesc') String txSortPref,
    @Default([]) List<String> visibleCharts,
  }) = _Loaded;
  const factory DashboardState.failure(String message) = _Failure;
}

// ── BLoC ──────────────────────────────────────────────────────────────────

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final CalculateMonthlySurplusUseCase _surplusUseCase;
  final GetCategoryVariancesUseCase _variancesUseCase;
  final TransactionRepository _txRepo;
  final GetWealthHistoryUseCase _wealthHistoryUseCase;
  final AuthRepository _authRepo;

  DateTime _currentMonth = DateTime(
      DateTime.now().year, DateTime.now().month, 1);

  StreamSubscription<List<TransactionEntity>>? _txSub;

  DashboardBloc(
    this._surplusUseCase,
    this._variancesUseCase,
    this._txRepo,
    this._wealthHistoryUseCase,
    this._authRepo,
  ) : super(const DashboardState.initial()) {
    on<_Load>(_onLoad);
    on<_PreviousMonth>(_onPrev);
    on<_NextMonth>(_onNext);
    on<_ChangeSortPreference>(_onChangeSortPreference);
    on<_ChangeTransactionSortPreference>(_onChangeTransactionSortPreference);
    on<_ToggleDashboardChart>(_onToggleDashboardChart);
  }

  Future<void> _onLoad(_Load event, Emitter<DashboardState> emit) async {
    final isNewMonth = _currentMonth != event.month || _txSub == null;
    _currentMonth = event.month;
    
    if (isNewMonth) {
      emit(const DashboardState.loading());
    }
    
    await _loadData(emit);
    
    // Watch for live transaction updates
    if (isNewMonth) {
      _txSub?.cancel();
      _txSub = _txRepo.watchTransactionsByMonth(_currentMonth).listen(
        (_) => add(DashboardEvent.load(_currentMonth)),
      );
    }
  }

  Future<void> _onPrev(
      _PreviousMonth event, Emitter<DashboardState> emit) async {
    final prev = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    add(DashboardEvent.load(prev));
  }

  Future<void> _onNext(
      _NextMonth event, Emitter<DashboardState> emit) async {
    final next = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    add(DashboardEvent.load(next));
  }

  Future<void> _onChangeSortPreference(
      _ChangeSortPreference event, Emitter<DashboardState> emit) async {
    final user = _authRepo.currentUser;
    if (user != null) {
      await _authRepo.updateVarianceSortPreference(user.uid, event.preference);
    }
    await _loadData(emit);
  }

  Future<void> _onChangeTransactionSortPreference(
      _ChangeTransactionSortPreference event, Emitter<DashboardState> emit) async {
    // Keep it local for now, but we need to pass it into _loadData
    // We can extract current txSortPref from state if loaded
    String currentTxSort = event.preference;
    await _loadData(emit, txSortPref: currentTxSort);
  }

  Future<void> _onToggleDashboardChart(
      _ToggleDashboardChart event, Emitter<DashboardState> emit) async {
    final user = _authRepo.currentUser;
    if (user != null) {
      final currentCharts = List<String>.from(user.dashboardVisibleCharts ?? ['wealth_trend', 'allocation_donut', 'daily_spend', 'income_expense', 'category_breakdown']);
      if (currentCharts.contains(event.chartId)) {
        currentCharts.remove(event.chartId);
      } else {
        currentCharts.add(event.chartId);
      }
      await _authRepo.updateDashboardVisibleCharts(user.uid, currentCharts);
    }
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<DashboardState> emit, {String? txSortPref}) async {
    final surplusResult = await _surplusUseCase(_currentMonth);
    if (surplusResult.isErr) {
      emit(DashboardState.failure(surplusResult.error.displayMessage));
      return;
    }

    final varianceResult = await _variancesUseCase(_currentMonth);
    if (varianceResult.isErr) {
      emit(DashboardState.failure(varianceResult.error.displayMessage));
      return;
    }

    final txResult = await _txRepo.getTransactionsPaged(
        offset: 0,
        limit: 10000,
        fromDate: DateTime(_currentMonth.year, _currentMonth.month, 1),
        toDate:
            DateTime(_currentMonth.year, _currentMonth.month + 1, 1)
                .subtract(const Duration(milliseconds: 1)));

    final pendingTxResult = await _txRepo.getTransactionsPaged(
        offset: 0,
        limit: 100, // Load up to 100 pending transactions
        needsReview: true);

    final wealthHistoryResult = await _wealthHistoryUseCase(_currentMonth);
    if (wealthHistoryResult.isErr) {
      emit(DashboardState.failure(wealthHistoryResult.error.displayMessage));
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

    // Fallback to current state's txSortPref if not provided
    String currentTxSort = txSortPref ?? 'dateDesc';
    if (txSortPref == null) {
      state.maybeWhen(
        loaded: (m, s, v, rt, pt, wh, hv, sp, ts, vC) {
          currentTxSort = ts;
        },
        orElse: () {},
      );
    }

    List<TransactionEntity> sortedTxs = txResult.isOk ? List.from(txResult.value) : [];
    if (currentTxSort == 'dateDesc') {
      sortedTxs.sort((a, b) => b.date.compareTo(a.date));
    } else if (currentTxSort == 'dateAsc') {
      sortedTxs.sort((a, b) => a.date.compareTo(b.date));
    } else if (currentTxSort == 'amountDesc') {
      sortedTxs.sort((a, b) => b.amount.compareTo(a.amount));
    } else if (currentTxSort == 'amountAsc') {
      sortedTxs.sort((a, b) => a.amount.compareTo(b.amount));
    }

    emit(DashboardState.loaded(
      month: _currentMonth,
      surplus: surplusResult.value,
      variances: _sortVariances(varianceResult.value, _authRepo.currentUser?.varianceSortPreference ?? 'highestSpent'),
      recentTransactions: sortedTxs,
      pendingTransactions: pendingTxResult.isOk ? List.from(pendingTxResult.value) : [],
      wealthHistory: wealthHistoryResult.value,
      historicalVariances: historicalVariances,
      sortPreference: _authRepo.currentUser?.varianceSortPreference ?? 'highestSpent',
      txSortPref: currentTxSort,
      visibleCharts: _authRepo.currentUser?.dashboardVisibleCharts ?? ['wealth_trend', 'allocation_donut', 'daily_spend', 'income_expense', 'category_breakdown'],
    ));
  }

  List<CategoryVarianceEntity> _sortVariances(List<CategoryVarianceEntity> list, String pref) {
    final copy = List<CategoryVarianceEntity>.from(list);
    switch (pref) {
      case 'highestSpent':
        copy.sort((a, b) => b.spent.compareTo(a.spent));
        break;
      case 'lowestSpent':
        copy.sort((a, b) => a.spent.compareTo(b.spent));
        break;
      case 'highestVariance':
        copy.sort((a, b) => b.remaining.compareTo(a.remaining));
        break;
      case 'lowestVariance':
        copy.sort((a, b) => a.remaining.compareTo(b.remaining));
        break;
      case 'nameAsc':
        copy.sort((a, b) => a.category.name.compareTo(b.category.name));
        break;
      default:
        copy.sort((a, b) => b.spent.compareTo(a.spent));
    }
    return copy;
  }

  @override
  Future<void> close() {
    _txSub?.cancel();
    return super.close();
  }
}
