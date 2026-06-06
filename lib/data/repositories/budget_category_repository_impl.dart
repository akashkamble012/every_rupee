import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/app_error.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../datasources/local/isar_provider.dart';
import '../models/isar/isar_models.dart';


@injectable
class BudgetCategoryLocalDataSource {
  final IsarProvider _db;
  static const _uuid = Uuid();

  BudgetCategoryLocalDataSource(this._db);

  Stream<List<BudgetCategoryEntity>> watchActive(DateTime month) {
    return _db.db.isarBudgetCategorys
        .filter()
        .isDeletedEqualTo(false)
        .watch(fireImmediately: true)
        .map((list) => list
            .map(_toEntity)
            .where((c) => _isActiveInMonth(c.effectiveFrom, c.activeUntil, month))
            .toList());
  }

  Stream<void> watchAll() {
    return _db.db.isarBudgetCategorys.watchLazy(fireImmediately: true);
  }

  Future<Result<List<BudgetCategoryEntity>>> getAll() async {
    try {
      final all = await _db.db.isarBudgetCategorys
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
      return Ok(all.map(_toEntity).toList());
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to fetch categories', original: e));
    }
  }

  Future<Result<BudgetCategoryEntity>> save(BudgetCategoryEntity cat) async {
    try {
      final model = _toModel(cat);
      await _db.db.writeTxn(() => _db.db.isarBudgetCategorys.put(model));
      await _queueWrite(cat.id, 'categories', 'upsert');
      return Ok(cat);
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to save category', original: e));
    }
  }

  Future<Result<void>> softDelete(String id) async {
    try {
      await _db.db.writeTxn(() async {
        final record =
            await _db.db.isarBudgetCategorys.getByIndex('id', [id]);
        if (record != null) {
          record.isDeleted = true;
          record.lastModifiedAt = DateTime.now();
          await _db.db.isarBudgetCategorys.put(record);
        }
      });
      await _queueWrite(id, 'categories', 'delete');
      return const Ok(null);
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to delete category', original: e));
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  bool _isActiveInMonth(DateTime from, DateTime? until, DateTime month) {
    final monthEnd =
        DateTime(month.year, month.month + 1, 1).subtract(const Duration(days: 1));
    if (from.isAfter(monthEnd)) return false;
    if (until != null && until.isBefore(DateTime(month.year, month.month, 1))) {
      return false;
    }
    return true;
  }

  BudgetCategoryEntity _toEntity(IsarBudgetCategory m) =>
      BudgetCategoryEntity(
        id: m.id,
        name: m.name,
        cap: m.cap,
        effectiveFrom: m.effectiveFrom,
        activeUntil: m.activeUntil,
        iconCode: m.iconCode,
        isDeleted: m.isDeleted,
        lastModifiedAt: m.lastModifiedAt,
      );

  IsarBudgetCategory _toModel(BudgetCategoryEntity e) =>
      IsarBudgetCategory()
        ..id = e.id.isEmpty ? _uuid.v4() : e.id
        ..name = e.name
        ..cap = e.cap
        ..effectiveFrom = e.effectiveFrom
        ..activeUntil = e.activeUntil
        ..iconCode = e.iconCode
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

@Injectable(as: BudgetCategoryRepository)
class BudgetCategoryRepositoryImpl implements BudgetCategoryRepository {
  final BudgetCategoryLocalDataSource _local;
  BudgetCategoryRepositoryImpl(this._local);

  @override
  Stream<List<BudgetCategoryEntity>> watchActiveCategories(DateTime month) =>
      _local.watchActive(month);

  @override
  Stream<void> watchAllCategories() => _local.watchAll();

  @override
  Future<Result<List<BudgetCategoryEntity>>> getAllCategories() =>
      _local.getAll();

  @override
  Future<Result<BudgetCategoryEntity>> saveCategory(
          BudgetCategoryEntity cat) =>
      _local.save(cat);

  @override
  Future<Result<void>> softDeleteCategory(String id) =>
      _local.softDelete(id);
}
