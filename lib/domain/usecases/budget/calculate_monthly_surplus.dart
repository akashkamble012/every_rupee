import 'package:injectable/injectable.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

/// Computes the live [MonthlySurplusEntity] for a given [month].
///
/// Formula:
///   totalIncome     = sum of all active IncomeSourceEntity.amount
///   totalAllocated  = sum of all active BudgetCategoryEntity.cap
///   totalSpent      = sum of all debit TransactionEntity.amount
///   surplus         = totalIncome - totalAllocated   (unassigned money)
///   balance         = totalAllocated - totalSpent    (remaining to spend)
@injectable
class CalculateMonthlySurplusUseCase {
  final IncomeRepository _incomeRepo;
  final BudgetCategoryRepository _categoryRepo;
  final TransactionRepository _txRepo;

  const CalculateMonthlySurplusUseCase(
    this._incomeRepo,
    this._categoryRepo,
    this._txRepo,
  );

  Future<Result<MonthlySurplusEntity>> call(DateTime month) async {
    // ── Income ───────────────────────────────────────────────────────────
    final sourcesResult = await _incomeRepo.getAllSources();
    if (sourcesResult.isErr) return Err(sourcesResult.error);

    final activeSources = sourcesResult.value.where((s) =>
        !s.isDeleted &&
        _isActiveInMonth(s.effectiveFrom, s.effectiveUntil, month));
    final totalIncome =
        activeSources.fold(0.0, (sum, s) => sum + s.amount);

    // ── Allocated caps ───────────────────────────────────────────────────
    final catsResult = await _categoryRepo.getAllCategories();
    if (catsResult.isErr) return Err(catsResult.error);

    final activeCats = catsResult.value.where((c) =>
        !c.isDeleted &&
        _isActiveInMonth(c.effectiveFrom, c.activeUntil, month));
    final totalAllocated =
        activeCats.fold(0.0, (sum, c) => sum + c.cap);

    // ── Spent ────────────────────────────────────────────────────────────
    double totalSpent = 0.0;
    for (final cat in activeCats) {
      final spentResult = await _txRepo.getTotalSpentForCategory(
        categoryId: cat.id,
        month: month,
      );
      if (spentResult.isErr) return Err(spentResult.error);
      totalSpent += spentResult.value;
    }

    // Also include transactions made against the virtual savings fund
    final savingsSpentResult = await _txRepo.getTotalSpentForCategory(
      categoryId: systemSavingsCategoryId,
      month: month,
    );
    if (savingsSpentResult.isOk) {
      totalSpent += savingsSpentResult.value;
    }

    return Ok(MonthlySurplusEntity(
      month: month,
      totalIncome: totalIncome,
      totalAllocated: totalAllocated,
      totalSpent: totalSpent,
      surplus: totalIncome - totalAllocated,
      balance: totalAllocated - totalSpent,
    ));
  }

  bool _isActiveInMonth(
    DateTime from,
    DateTime? until,
    DateTime month,
  ) {
    final monthEnd =
        DateTime(month.year, month.month + 1, 1).subtract(const Duration(days: 1));
    if (from.isAfter(monthEnd)) return false;
    if (until != null && until.isBefore(DateTime(month.year, month.month, 1))) {
      return false;
    }
    return true;
  }
}
