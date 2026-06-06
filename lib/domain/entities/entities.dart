import 'package:freezed_annotation/freezed_annotation.dart';


part 'entities.freezed.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Transaction
// ═══════════════════════════════════════════════════════════════════════════

enum TransactionType { debit, credit }

enum PaymentMode { upi, card, cash, netBanking, other }

@freezed
class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,
    required double amount,
    required TransactionType type,
    required DateTime date,
    required String categoryId,
    String? merchant,
    PaymentMode? paymentMode,
    String? note,
    String? smsSource,          // populated when parsed from SMS
    @Default(false) bool needsReview, // true if auto-captured and unverified
    @Default(false) bool isDeleted,
    required DateTime createdAt,
    required DateTime lastModifiedAt,
  }) = _TransactionEntity;
}

// ═══════════════════════════════════════════════════════════════════════════
// Budget Category Cap
// ═══════════════════════════════════════════════════════════════════════════

@freezed
class BudgetCategoryEntity with _$BudgetCategoryEntity {
  const factory BudgetCategoryEntity({
    required String id,
    required String name,
    required double cap,            // monthly allocation
    required DateTime effectiveFrom,
    DateTime? activeUntil,          // null = open-ended (no expiry)
    String? iconCode,               // Material icon codePoint as string
    @Default(false) bool isDeleted,
    required DateTime lastModifiedAt,
  }) = _BudgetCategoryEntity;
}

// System category constants
const String systemSavingsCategoryId = 'system_savings_fund';
const String systemSavingsCategoryName = 'Saving / Special Fund';

// ═══════════════════════════════════════════════════════════════════════════
// Income Source
// ═══════════════════════════════════════════════════════════════════════════

@freezed
class IncomeSourceEntity with _$IncomeSourceEntity {
  const factory IncomeSourceEntity({
    required String id,
    required String name,           // "Primary Salary", "Freelance", etc.
    required double amount,
    required DateTime effectiveFrom,
    DateTime? effectiveUntil,       // null = currently active
    @Default(false) bool isDeleted,
    required DateTime lastModifiedAt,
  }) = _IncomeSourceEntity;
}

// ═══════════════════════════════════════════════════════════════════════════
// Monthly Surplus (computed — never persisted directly)
// ═══════════════════════════════════════════════════════════════════════════

@freezed
class MonthlySurplusEntity with _$MonthlySurplusEntity {
  const factory MonthlySurplusEntity({
    required DateTime month,
    required double totalIncome,
    required double totalAllocated,  // sum of all active caps
    required double totalSpent,      // sum of debit transactions
    required double surplus,         // income - allocated (unassigned)
    required double balance,         // allocated - spent (remaining to spend)
  }) = _MonthlySurplusEntity;
}

// ═══════════════════════════════════════════════════════════════════════════
// Category Variance (per-category spend vs cap — for dashboard tiles)
// ═══════════════════════════════════════════════════════════════════════════

@freezed
class CategoryVarianceEntity with _$CategoryVarianceEntity {
  const factory CategoryVarianceEntity({
    required BudgetCategoryEntity category,
    required double spent,
    required double remaining,
    required double ratio,           // spent / cap  (0.0 – n.0)
  }) = _CategoryVarianceEntity;
}

// ═══════════════════════════════════════════════════════════════════════════
// User Profile
// ═══════════════════════════════════════════════════════════════════════════

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool onboardingComplete,
    @Default(false) bool budgetSetupComplete,
    String? varianceSortPreference,
    List<String>? dashboardVisibleCharts,
  }) = _UserEntity;
}

// ═══════════════════════════════════════════════════════════════════════════
// Financial Roadmap (Projection)
// ═══════════════════════════════════════════════════════════════════════════

@freezed
class TemporaryOutflowEntity with _$TemporaryOutflowEntity {
  const factory TemporaryOutflowEntity({
    required String id,
    required String name,
    required double amount,
    required DateTime startMonth,
    required DateTime endMonth,
    @Default(false) bool isDeleted,
    required DateTime lastModifiedAt,
  }) = _TemporaryOutflowEntity;
}

@freezed
class RoadmapMonthEntity with _$RoadmapMonthEntity {
  const factory RoadmapMonthEntity({
    required String id, // Format: YYYY-MM
    required DateTime month,
    double? netIncomeOverride,
    double? coreFixedExpensesOverride,
    String? actionPlan,
    @Default(false) bool isDeleted,
    required DateTime lastModifiedAt,
  }) = _RoadmapMonthEntity;
}

@freezed
class RoadmapDisplayEntity with _$RoadmapDisplayEntity {
  const factory RoadmapDisplayEntity({
    required String id,
    required DateTime month,
    
    // The derived/effective values used for projection
    required double effectiveIncome,
    required double effectiveFixedExpenses,
    required double temporaryOutflows,
    required double totalOutflow,
    required double surplus,
    required double accumulatedWealth,
    
    // Overrides and user data
    double? netIncomeOverride,
    double? coreFixedExpensesOverride,
    String? actionPlan,
  }) = _RoadmapDisplayEntity;
}
