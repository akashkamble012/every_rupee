import 'package:injectable/injectable.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/local/transaction_local_datasource.dart';
import '../../core/services/home_widget_service.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource _local;

  const TransactionRepositoryImpl(this._local);

  @override
  Stream<List<TransactionEntity>> watchTransactionsByMonth(DateTime month) =>
      _local.watchByMonth(month);

  @override
  Stream<void> watchAllTransactions() => _local.watchAll();

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
  Future<Result<TransactionEntity>> saveTransaction(TransactionEntity tx) async {
    final result = await _local.save(tx);
    if (result.isOk) {
      _updateWidgetData();
    }
    return result;
  }

  @override
  Future<Result<void>> softDeleteTransaction(String id) async {
    final result = await _local.softDelete(id);
    if (result.isOk) {
      _updateWidgetData();
    }
    return result;
  }

  Future<void> _updateWidgetData() async {
    final result = await getTransactionsPaged(offset: 0, limit: 5);
    if (result.isOk) {
      final transactions = List<TransactionEntity>.from(result.value);
      transactions.sort((a, b) => b.date.compareTo(a.date));
      await HomeWidgetService.updateRecentTransactions(transactions.take(5).toList());
    }
  }

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
