import 'package:injectable/injectable.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../core/error/app_error.dart';
import '../datasources/local/roadmap_local_datasource.dart';
import '../models/isar/isar_models.dart';

@LazySingleton(as: RoadmapRepository)
class RoadmapRepositoryImpl implements RoadmapRepository {
  final RoadmapLocalDataSource _local;

  RoadmapRepositoryImpl(this._local);

  @override
  Stream<List<TemporaryOutflowEntity>> watchTemporaryOutflows() {
    return _local.watchTemporaryOutflows().map((list) {
      return list.map((isar) => TemporaryOutflowEntity(
        id: isar.id,
        name: isar.name,
        amount: isar.amount,
        startMonth: isar.startMonth,
        endMonth: isar.endMonth,
        isDeleted: isar.isDeleted,
        lastModifiedAt: isar.lastModifiedAt,
      )).toList();
    });
  }

  @override
  Stream<RoadmapMonthEntity?> watchRoadmapMonth(String id) {
    return _local.watchRoadmapMonth(id).map((isar) {
      if (isar == null) return null;
      return RoadmapMonthEntity(
        id: isar.id,
        month: isar.month,
        netIncomeOverride: isar.netIncomeOverride,
        coreFixedExpensesOverride: isar.coreFixedExpensesOverride,
        actionPlan: isar.actionPlan,
        isDeleted: isar.isDeleted,
        lastModifiedAt: isar.lastModifiedAt,
      );
    });
  }

  @override
  Stream<void> watchAllRoadmapData() => _local.watchAll();

  @override
  Future<Result<TemporaryOutflowEntity>> saveTemporaryOutflow(TemporaryOutflowEntity outflow) async {
    try {
      final isarOutflow = IsarTemporaryOutflow()
        ..id = outflow.id
        ..name = outflow.name
        ..amount = outflow.amount
        ..startMonth = outflow.startMonth
        ..endMonth = outflow.endMonth
        ..isDeleted = outflow.isDeleted
        ..lastModifiedAt = outflow.lastModifiedAt;

      await _local.saveTemporaryOutflow(isarOutflow);
      
      return Ok(outflow);
    } catch (e) {
      return Err(AppError.database(message: 'Failed to save temporary outflow: $e'));
    }
  }

  @override
  Future<Result<void>> softDeleteTemporaryOutflow(String id) async {
    try {
      await _local.softDeleteTemporaryOutflow(id);
      return const Ok(null);
    } catch (e) {
      return Err(AppError.database(message: 'Failed to delete temporary outflow: $e'));
    }
  }

  @override
  Future<Result<RoadmapMonthEntity>> saveRoadmapMonth(RoadmapMonthEntity month) async {
    try {
      final isarMonth = IsarRoadmapMonth()
        ..id = month.id
        ..month = month.month
        ..netIncomeOverride = month.netIncomeOverride
        ..coreFixedExpensesOverride = month.coreFixedExpensesOverride
        ..actionPlan = month.actionPlan
        ..isDeleted = month.isDeleted
        ..lastModifiedAt = month.lastModifiedAt;

      await _local.saveRoadmapMonth(isarMonth);
      
      return Ok(month);
    } catch (e) {
      return Err(AppError.database(message: 'Failed to save roadmap month: $e'));
    }
  }
}
