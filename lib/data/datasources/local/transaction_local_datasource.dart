import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../models/isar/isar_models.dart';
import 'isar_provider.dart';

@injectable
class TransactionLocalDataSource {
  final IsarProvider _db;
  static const _uuid = Uuid();

  const TransactionLocalDataSource(this._db);

  // ── Watch ────────────────────────────────────────────────────────────────

  Stream<List<TransactionEntity>> watchByMonth(DateTime month) {
    final start = startOfMonth(month);
    final end = endOfMonth(month);
    return _db.db.isarTransactions
        .filter()
        .isDeletedEqualTo(false)
        .dateBetween(start, end)
        .sortByDateDesc()
        .watch(fireImmediately: true)
        .map((list) => list.map(_toEntity).toList());
  }

  Stream<void> watchAll() {
    return _db.db.isarTransactions.watchLazy(fireImmediately: true);
  }

  // ── Paginated fetch ───────────────────────────────────────────────────────

  Future<Result<List<TransactionEntity>>> getPaged({
    required int offset,
    required int limit,
    DateTime? fromDate,
    DateTime? toDate,
    String? categoryId,
    TransactionType? type,
    String? searchText,
    bool? needsReview,
  }) async {
    try {
      var query = _db.db.isarTransactions.filter().isDeletedEqualTo(false);

      if (fromDate != null && toDate != null) {
        query = query.dateBetween(fromDate, toDate);
      }
      if (categoryId != null) {
        query = query.categoryIdEqualTo(categoryId);
      }
      if (type != null) {
        query = query.typeIndexEqualTo(type.index);
      }
      if (needsReview != null) {
        query = query.needsReviewEqualTo(needsReview);
      }

      final results = await query
          .sortByDateDesc()
          .offset(offset)
          .limit(limit)
          .findAll();

      var entities = results.map(_toEntity).toList();

      // Text search (Isar v3 doesn't support full-text; filter in-memory)
      if (searchText != null && searchText.isNotEmpty) {
        final q = searchText.toLowerCase();
        entities = entities
            .where((t) =>
                (t.merchant?.toLowerCase().contains(q) ?? false) ||
                (t.note?.toLowerCase().contains(q) ?? false))
            .toList();
      }

      return Ok(entities);
    } catch (e, st) {
      return Err(AppError.database(
          message: 'Failed to fetch transactions', original: e));
    }
  }

  Future<Result<TransactionEntity?>> getById(String id) async {
    try {
      final model = await _db.db.isarTransactions.getByIndex('id', [id]);
      if (model == null || model.isDeleted) return const Ok(null);
      return Ok(_toEntity(model));
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to fetch transaction by id', original: e));
    }
  }

  // ── Save ─────────────────────────────────────────────────────────────────

  Future<Result<TransactionEntity>> save(TransactionEntity tx) async {
    try {
      final model = _toModel(tx);
      await _db.db.writeTxn(() => _db.db.isarTransactions.put(model));
      await _queueWrite(tx.id, 'transactions', 'upsert');
      return Ok(tx);
    } catch (e) {
      return Err(
          AppError.database(message: 'Failed to save transaction', original: e));
    }
  }

  // ── Soft delete ───────────────────────────────────────────────────────────

  Future<Result<void>> softDelete(String id) async {
    try {
      await _db.db.writeTxn(() async {
        final record = await _db.db.isarTransactions.getByIndex('id', [id]);
        if (record != null) {
          record.isDeleted = true;
          record.lastModifiedAt = DateTime.now();
          await _db.db.isarTransactions.put(record);
        }
      });
      await _queueWrite(id, 'transactions', 'delete');
      return const Ok(null);
    } catch (e) {
      return Err(
          AppError.database(message: 'Failed to delete transaction', original: e));
    }
  }

  // ── Aggregate ────────────────────────────────────────────────────────────

  Future<Result<double>> getTotalSpent({
    required String categoryId,
    required DateTime month,
  }) async {
    try {
      final start = startOfMonth(month);
      final end = endOfMonth(month);
      final results = await _db.db.isarTransactions
          .filter()
          .isDeletedEqualTo(false)
          .categoryIdEqualTo(categoryId)
          .typeIndexEqualTo(TransactionType.debit.index)
          .dateBetween(start, end)
          .amountProperty()
          .findAll();
      final total = results.fold(0.0, (sum, a) => sum + a);
      return Ok(total);
    } catch (e) {
      return Err(AppError.database(
          message: 'Failed to aggregate spend', original: e));
    }
  }

  // ── Mappers ───────────────────────────────────────────────────────────────

  TransactionEntity _toEntity(IsarTransaction m) => TransactionEntity(
        id: m.id,
        amount: m.amount,
        type: TransactionType.values[m.typeIndex],
        date: m.date,
        categoryId: m.categoryId,
        merchant: m.merchant,
        paymentMode: m.paymentModeIndex != null
            ? PaymentMode.values[m.paymentModeIndex!]
            : null,
        note: m.note,
        smsSource: m.smsSource,
        needsReview: m.needsReview,
        isRecurring: m.isRecurring,
        tags: m.tags,
        isDeleted: m.isDeleted,
        createdAt: m.createdAt,
        lastModifiedAt: m.lastModifiedAt,
      );

  IsarTransaction _toModel(TransactionEntity e) => IsarTransaction()
    ..id = e.id.isEmpty ? _uuid.v4() : e.id
    ..amount = e.amount
    ..typeIndex = e.type.index
    ..date = e.date
    ..categoryId = e.categoryId
    ..merchant = e.merchant
    ..paymentModeIndex = e.paymentMode?.index
    ..note = e.note
    ..smsSource = e.smsSource
    ..needsReview = e.needsReview
    ..isRecurring = e.isRecurring
    ..tags = e.tags
    ..isDeleted = e.isDeleted
    ..createdAt = e.createdAt
    ..lastModifiedAt = DateTime.now();

  // ── Sync queue helper ─────────────────────────────────────────────────────

  Future<void> _queueWrite(
      String docId, String collection, String op) async {
    final pending = IsarPendingWrite()
      ..collectionName = collection
      ..documentId = docId
      ..operation = op
      ..queuedAt = DateTime.now();
    await _db.db.writeTxn(
        () => _db.db.isarPendingWrites.put(pending));
  }
}
