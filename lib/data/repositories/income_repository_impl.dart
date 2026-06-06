import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/app_error.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../datasources/local/isar_provider.dart';
import '../models/isar/isar_models.dart';

@injectable
class IncomeLocalDataSource {
  final IsarProvider _db;
  static const _uuid = Uuid();

  IncomeLocalDataSource(this._db);

  Stream<List<IncomeSourceEntity>> watchActive(DateTime month) {
    return _db.db.isarIncomeSources
        .filter()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true)
        .map((list) => list
            .map(_toEntity)
            .where((s) => _isActiveInMonth(s.effectiveFrom, s.effectiveUntil, month))
            .toList());
  }

  Stream<void> watchAll() {
    return _db.db.isarIncomeSources.watchLazy(fireImmediately: true);
  }

  Future<Result<List<IncomeSourceEntity>>> getAll() async {
    try {
      final all = await _db.db.isarIncomeSources
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
      return Ok(all.map(_toEntity).toList());
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to fetch income sources', original: e));
    }
  }

  Future<Result<IncomeSourceEntity>> save(IncomeSourceEntity src) async {
    try {
      final model = _toModel(src);
      await _db.db.writeTxn(() => _db.db.isarIncomeSources.put(model));
      await _queueWrite(src.id, 'incomeSources', 'upsert');
      return Ok(src);
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to save income source', original: e));
    }
  }

  Future<Result<void>> softDelete(String id) async {
    try {
      await _db.db.writeTxn(() async {
        final record =
            await _db.db.isarIncomeSources.getByIndex('id', [id]);
        if (record != null) {
          record.isDeleted = true;
          record.lastModifiedAt = DateTime.now();
          await _db.db.isarIncomeSources.put(record);
        }
      });
      await _queueWrite(id, 'incomeSources', 'delete');
      return const Ok(null);
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to delete income source', original: e));
    }
  }

  bool _isActiveInMonth(DateTime from, DateTime? until, DateTime month) {
    final monthEnd =
        DateTime(month.year, month.month + 1, 1).subtract(const Duration(days: 1));
    if (from.isAfter(monthEnd)) return false;
    if (until != null && until.isBefore(DateTime(month.year, month.month, 1))) {
      return false;
    }
    return true;
  }

  IncomeSourceEntity _toEntity(IsarIncomeSource m) => IncomeSourceEntity(
        id: m.id,
        name: m.name,
        amount: m.amount,
        effectiveFrom: m.effectiveFrom,
        effectiveUntil: m.effectiveUntil,
        isDeleted: m.isDeleted,
        lastModifiedAt: m.lastModifiedAt,
      );

  IsarIncomeSource _toModel(IncomeSourceEntity e) => IsarIncomeSource()
    ..id = e.id.isEmpty ? _uuid.v4() : e.id
    ..name = e.name
    ..amount = e.amount
    ..effectiveFrom = e.effectiveFrom
    ..effectiveUntil = e.effectiveUntil
    ..isDeleted = e.isDeleted
    ..lastModifiedAt = DateTime.now();

  Future<void> _queueWrite(String docId, String col, String op) async {
    final pending = IsarPendingWrite()
      ..collectionName = col
      ..documentId = docId
      ..operation = op
      ..queuedAt = DateTime.now();
    await _db.db
        .writeTxn(() => _db.db.isarPendingWrites.put(pending));
  }
}

// ── Repository Impl ───────────────────────────────────────────────────────

@Injectable(as: IncomeRepository)
class IncomeRepositoryImpl implements IncomeRepository {
  final IncomeLocalDataSource _local;
  IncomeRepositoryImpl(this._local);

  @override
  Stream<List<IncomeSourceEntity>> watchActiveSources(DateTime month) =>
      _local.watchActive(month);

  @override
  Stream<void> watchAllSources() => _local.watchAll();

  @override
  Future<Result<List<IncomeSourceEntity>>> getAllSources() => _local.getAll();

  @override
  Future<Result<IncomeSourceEntity>> saveIncomeSource(
          IncomeSourceEntity src) =>
      _local.save(src);

  @override
  Future<Result<void>> softDeleteIncomeSource(String id) =>
      _local.softDelete(id);
}
