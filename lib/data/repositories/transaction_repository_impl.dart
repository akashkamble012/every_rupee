import 'package:injectable/injectable.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/local/transaction_local_datasource.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource _local;

  const TransactionRepositoryImpl(this._local);

  @override
  Stream<List<TransactionEntity>> watchTransactionsByMonth(DateTime month) =>
      _local.watchByMonth(month);

  @override
  Future<Result<List<TransactionEntity>>> getTransactionsPaged({
    required int offset,
    required int limit,
    DateTime? fromDate,
    DateTime? toDate,
    String? categoryId,
    TransactionType? type,
    String? searchText,
    bool? needsReview,
  }) =>
      _local.getPaged(
        offset: offset,
        limit: limit,
        fromDate: fromDate,
        toDate: toDate,
        categoryId: categoryId,
        type: type,
        searchText: searchText,
        needsReview: needsReview,
      );

  @override
  Future<Result<TransactionEntity>> saveTransaction(TransactionEntity tx) =>
      _local.save(tx);

  @override
  Future<Result<void>> softDeleteTransaction(String id) =>
      _local.softDelete(id);

  @override
  Future<Result<TransactionEntity?>> getTransactionById(String id) =>
      _local.getById(id);

  @override
  Future<Result<double>> getTotalSpentForCategory({
    required String categoryId,
    required DateTime month,
  }) =>
      _local.getTotalSpent(categoryId: categoryId, month: month);
}
