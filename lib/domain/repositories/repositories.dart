import '../entities/entities.dart';
import '../../core/error/app_error.dart';

// ── Simple Either-like result type ─────────────────────────────────────────
// We use a lightweight sealed class instead of pulling in dartz to keep deps
// minimal. You can swap this for dartz Either<L,R> if preferred.

sealed class Result<T> {
  const Result();
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

final class Err<T> extends Result<T> {
  final AppError error;
  const Err(this.error);
}

extension ResultX<T> on Result<T> {
  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;
  T get value => (this as Ok<T>).value;
  AppError get error => (this as Err<T>).error;

  R fold<R>(R Function(T) onOk, R Function(AppError) onErr) =>
      switch (this) {
        Ok<T> ok => onOk(ok.value),
        Err<T> err => onErr(err.error),
      };
}

// ═══════════════════════════════════════════════════════════════════════════
// Auth Repository
// ═══════════════════════════════════════════════════════════════════════════

abstract interface class AuthRepository {
  Stream<UserEntity?> get authStateChanges;

  Future<Result<UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> signInWithGoogle();

  Future<Result<void>> signOut();

  Future<Result<void>> markOnboardingComplete(String uid);

  Future<Result<void>> markBudgetSetupComplete(String uid);

  Future<Result<void>> updateVarianceSortPreference(String uid, String preference);

  Future<Result<void>> updateDashboardVisibleCharts(String uid, List<String> charts);

  Future<Result<void>> updateAppLockStatus(String uid, bool isEnabled);

  UserEntity? get currentUser;
}

// ═══════════════════════════════════════════════════════════════════════════
// Transaction Repository
// ═══════════════════════════════════════════════════════════════════════════

abstract interface class TransactionRepository {
  /// Stream all non-deleted transactions for the given [month].
  Stream<List<TransactionEntity>> watchTransactionsByMonth(DateTime month);

  /// Paginated fetch for the ledger screen.
  Future<Result<List<TransactionEntity>>> getTransactionsPaged({
    required int offset,
    required int limit,
    DateTime? fromDate,
    DateTime? toDate,
    String? categoryId,
    TransactionType? type,
    String? searchText,
    bool? needsReview,
  });

  Future<Result<TransactionEntity>> saveTransaction(TransactionEntity tx);

  Future<Result<void>> softDeleteTransaction(String id);

  Future<Result<TransactionEntity?>> getTransactionById(String id);

  /// Returns total debits for [categoryId] in [month].
  Future<Result<double>> getTotalSpentForCategory({
    required String categoryId,
    required DateTime month,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// Budget Category Repository
// ═══════════════════════════════════════════════════════════════════════════

abstract interface class BudgetCategoryRepository {
  /// Stream active categories for the given [month].
  Stream<List<BudgetCategoryEntity>> watchActiveCategories(DateTime month);

  Future<Result<List<BudgetCategoryEntity>>> getAllCategories();

  Future<Result<BudgetCategoryEntity>> saveCategory(BudgetCategoryEntity cat);

  Future<Result<void>> softDeleteCategory(String id);
}

// ═══════════════════════════════════════════════════════════════════════════
// Income Repository
// ═══════════════════════════════════════════════════════════════════════════

abstract interface class IncomeRepository {
  Stream<List<IncomeSourceEntity>> watchActiveSources(DateTime month);

  Future<Result<List<IncomeSourceEntity>>> getAllSources();

  Future<Result<IncomeSourceEntity>> saveIncomeSource(IncomeSourceEntity src);

  Future<Result<void>> softDeleteIncomeSource(String id);
}

// ═══════════════════════════════════════════════════════════════════════════
// Financial Roadmap Repository
// ═══════════════════════════════════════════════════════════════════════════

abstract interface class RoadmapRepository {
  /// Stream temporary outflows (EMIs, debts, etc)
  Stream<List<TemporaryOutflowEntity>> watchTemporaryOutflows();

  /// Watch specific month overrides and action plan
  Stream<RoadmapMonthEntity?> watchRoadmapMonth(String id);

  /// Save temporary outflow
  Future<Result<TemporaryOutflowEntity>> saveTemporaryOutflow(TemporaryOutflowEntity outflow);

  /// Soft delete temporary outflow
  Future<Result<void>> softDeleteTemporaryOutflow(String id);

  /// Save roadmap month config (overrides/action plan)
  Future<Result<RoadmapMonthEntity>> saveRoadmapMonth(RoadmapMonthEntity month);
}

// ═══════════════════════════════════════════════════════════════════════════
// Sync Repository
// ═══════════════════════════════════════════════════════════════════════════

abstract interface class SyncRepository {
  /// Push all local pending writes to Firestore.
  Future<Result<void>> pushPendingWrites();

  /// Pull latest remote state and merge into Isar.
  Future<Result<void>> pullRemoteChanges();

  Stream<SyncStatus> get syncStatusStream;
}

enum SyncStatus { idle, syncing, success, failure }
