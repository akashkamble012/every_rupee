import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../../domain/usecases/roadmap/generate_roadmap_usecase.dart';

part 'roadmap_bloc.freezed.dart';

@freezed
class RoadmapEvent with _$RoadmapEvent {
  const factory RoadmapEvent.load({@Default(12) int monthsToProject}) = _Load;
  const factory RoadmapEvent.saveOverride({
    required DateTime month,
    double? netIncomeOverride,
    double? coreFixedExpensesOverride,
    String? actionPlan,
  }) = _SaveOverride;
  const factory RoadmapEvent.saveTemporaryOutflow({
    required TemporaryOutflowEntity outflow,
  }) = _SaveTemporaryOutflow;
  const factory RoadmapEvent.deleteTemporaryOutflow({
    required String id,
  }) = _DeleteTemporaryOutflow;
}

@freezed
class RoadmapState with _$RoadmapState {
  const factory RoadmapState.initial() = _Initial;
  const factory RoadmapState.loading() = _Loading;
  const factory RoadmapState.loaded({
    required List<RoadmapDisplayEntity> projectedMonths,
    required List<TemporaryOutflowEntity> temporaryOutflows,
  }) = _Loaded;
  const factory RoadmapState.failure(String message) = _Failure;
}

@injectable
class RoadmapBloc extends Bloc<RoadmapEvent, RoadmapState> {
  final GenerateRoadmapUseCase _generateRoadmapUseCase;
  final RoadmapRepository _roadmapRepo;

  RoadmapBloc(this._generateRoadmapUseCase, this._roadmapRepo) : super(const RoadmapState.initial()) {
    on<_Load>(_onLoad);
    on<_SaveOverride>(_onSaveOverride);
    on<_SaveTemporaryOutflow>(_onSaveTemporaryOutflow);
    on<_DeleteTemporaryOutflow>(_onDeleteTemporaryOutflow);
  }

  Future<void> _onLoad(_Load event, Emitter<RoadmapState> emit) async {
    emit(const RoadmapState.loading());
    
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    
    await emit.forEach(
      _generateRoadmapUseCase.execute(startMonth: currentMonth, monthsToProject: event.monthsToProject),
      onData: (List<RoadmapDisplayEntity> projections) {
        // We also want to listen to temporary outflows to show them in the manage UI.
        // But for simplicity, we'll just let the UI use a stream builder for outflows,
        // or we can load them here by awaiting or listening to them.
        // Instead of managing two streams in emit.forEach, we'll just load the current outflows state.
        
        return RoadmapState.loaded(
          projectedMonths: projections,
          temporaryOutflows: [], // This is populated via StreamBuilder in the UI to keep bloc simple
        );
      },
      onError: (e, st) {
        return RoadmapState.failure('Failed to generate roadmap: $e');
      },
    );
  }

  Future<void> _onSaveOverride(_SaveOverride event, Emitter<RoadmapState> emit) async {
    final id = '${event.month.year}-${event.month.month.toString().padLeft(2, '0')}';
    
    final entity = RoadmapMonthEntity(
      id: id,
      month: event.month,
      netIncomeOverride: event.netIncomeOverride,
      coreFixedExpensesOverride: event.coreFixedExpensesOverride,
      actionPlan: event.actionPlan,
      lastModifiedAt: DateTime.now().toUtc(),
    );
    
    final result = await _roadmapRepo.saveRoadmapMonth(entity);
    if (result.isErr) {
      // Handle error (maybe emit failure and revert to loaded, or show snackbar)
    }
  }

  Future<void> _onSaveTemporaryOutflow(_SaveTemporaryOutflow event, Emitter<RoadmapState> emit) async {
    await _roadmapRepo.saveTemporaryOutflow(event.outflow);
  }

  Future<void> _onDeleteTemporaryOutflow(_DeleteTemporaryOutflow event, Emitter<RoadmapState> emit) async {
    await _roadmapRepo.softDeleteTemporaryOutflow(event.id);
  }
}
