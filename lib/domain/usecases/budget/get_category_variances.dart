import 'package:injectable/injectable.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

import 'calculate_monthly_surplus.dart';

/// Returns a [CategoryVarianceEntity] list for all active categories in [month].
/// Each item contains spent, remaining, and the spend ratio for conditional formatting.
@injectable
class GetCategoryVariancesUseCase {
  final BudgetCategoryRepository _categoryRepo;
  final TransactionRepository _txRepo;
  final CalculateMonthlySurplusUseCase _surplusUseCase;

  const GetCategoryVariancesUseCase(
    this._categoryRepo, 
    this._txRepo,
    this._surplusUseCase,
  );

  Future<Result<List<CategoryVarianceEntity>>> call(DateTime month) async {
    final catsResult = await _categoryRepo.getAllCategories();
    if (catsResult.isErr) return Err(catsResult.error);

    final activeCats = catsResult.value.where((c) =>
        !c.isDeleted && _isActiveInMonth(c.effectiveFrom, c.activeUntil, month));

    final variances = <CategoryVarianceEntity>[];

    for (final cat in activeCats) {
      final spentResult = await _txRepo.getTotalSpentForCategory(
        categoryId: cat.id,
        month: month,
      );
      if (spentResult.isErr) return Err(spentResult.error);

      final spent = spentResult.value;
      final remaining = cat.cap - spent;
      final ratio = cat.cap > 0 ? spent / cat.cap : 0.0;

      variances.add(CategoryVarianceEntity(
        category: cat,
        spent: spent,
        remaining: remaining,
        ratio: ratio,
      ));
    }
    // Inject virtual Saving/Special Fund category if there is a surplus
    final surplusResult = await _surplusUseCase.call(month);
    if (surplusResult.isOk && surplusResult.value.surplus > 0) {
      final surplus = surplusResult.value.surplus;
      
      final savingsSpentResult = await _txRepo.getTotalSpentForCategory(
        categoryId: systemSavingsCategoryId,
        month: month,
      );
      final savingsSpent = savingsSpentResult.isOk ? savingsSpentResult.value : 0.0;
      
      variances.add(CategoryVarianceEntity(
        category: BudgetCategoryEntity(
          id: systemSavingsCategoryId,
          name: systemSavingsCategoryName,
          cap: surplus,
          effectiveFrom: DateTime(2000), // Virtual category is always active
          lastModifiedAt: DateTime.now(),
          iconCode: '0xf01ae', // savings icon (approx)
        ),
        spent: savingsSpent,
        remaining: surplus - savingsSpent,
        ratio: surplus > 0 ? savingsSpent / surplus : 0.0,
      ));
    }

    // Sort: highest ratio first (most critical at top)
    variances.sort((a, b) => b.ratio.compareTo(a.ratio));
    return Ok(variances);
  }

  bool _isActiveInMonth(DateTime from, DateTime? until, DateTime month) {
    final monthEnd =
        DateTime(month.year, month.month + 1, 1).subtract(const Duration(days: 1));
    if (from.isAfter(monthEnd)) return false;
    if (until != null &&
        until.isBefore(DateTime(month.year, month.month, 1))) {
      return false;
    }
    return true;
  }
}
