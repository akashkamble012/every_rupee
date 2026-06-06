import 'package:isar/isar.dart';
import 'package:injectable/injectable.dart';

import 'isar_provider.dart';
import '../../models/isar/isar_models.dart';

@lazySingleton
class RoadmapLocalDataSource {
  final IsarProvider _isarProvider;

  RoadmapLocalDataSource(this._isarProvider);

  Isar get _db => _isarProvider.db;

  Stream<List<IsarTemporaryOutflow>> watchTemporaryOutflows() {
    return _db.isarTemporaryOutflows
        .filter()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true);
  }

  Stream<IsarRoadmapMonth?> watchRoadmapMonth(String id) {
    return _db.isarRoadmapMonths
        .filter()
        .idEqualTo(id)
        .watch(fireImmediately: true)
        .map((list) => list.firstOrNull);
  }

  Stream<void> watchAll() {
    return _db.isarTemporaryOutflows.watchLazy(fireImmediately: true);
  }

  Future<void> saveTemporaryOutflow(IsarTemporaryOutflow outflow) async {
    await _db.writeTxn(() async {
      await _db.isarTemporaryOutflows.put(outflow);
      await _queueWrite(outflow.id, 'temporaryOutflows', 'upsert');
    });
  }

  Future<void> softDeleteTemporaryOutflow(String id) async {
    await _db.writeTxn(() async {
      final outflow = await _db.isarTemporaryOutflows.filter().idEqualTo(id).findFirst();
      if (outflow != null) {
        outflow.isDeleted = true;
        outflow.lastModifiedAt = DateTime.now().toUtc();
        await _db.isarTemporaryOutflows.put(outflow);
        await _queueWrite(id, 'temporaryOutflows', 'delete');
      }
    });
  }

  Future<void> saveRoadmapMonth(IsarRoadmapMonth month) async {
    await _db.writeTxn(() async {
      await _db.isarRoadmapMonths.put(month);
      await _queueWrite(month.id, 'roadmapMonths', 'upsert');
    });
  }

  Future<void> _queueWrite(String docId, String collection, String op) async {
    final pending = IsarPendingWrite()
      ..collectionName = collection
      ..documentId = docId
      ..operation = op
      ..queuedAt = DateTime.now();
    await _db.isarPendingWrites.put(pending);
  }
}
