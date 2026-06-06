import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

@injectable
class GenerateRoadmapUseCase {
  final RoadmapRepository _roadmapRepo;
  final IncomeRepository _incomeRepo;
  final BudgetCategoryRepository _categoryRepo;

  GenerateRoadmapUseCase(
    this._roadmapRepo,
    this._incomeRepo,
    this._categoryRepo,
  );

  /// Generates a roadmap starting from [startMonth] for [monthsToProject] months.
  Stream<List<RoadmapDisplayEntity>> execute({
    required DateTime startMonth,
    int monthsToProject = 12,
  }) {
    // We combine the base income, base expenses, all temporary outflows, and user overrides.
    final baseIncomeStream = _incomeRepo.watchActiveSources(startMonth).map((sources) {
      return sources.fold(0.0, (sum, source) => sum + source.amount);
    });

    final baseFixedExpensesStream = _categoryRepo.watchActiveCategories(startMonth).map((categories) {
      return categories.fold(0.0, (sum, cat) => sum + cat.cap);
    });

    final outflowsStream = _roadmapRepo.watchTemporaryOutflows();

    return Rx.combineLatest3(
      baseIncomeStream,
      baseFixedExpensesStream,
      outflowsStream,
      (double baseIncome, double baseFixed, List<TemporaryOutflowEntity> outflows) {
        // Now we need to fetch the RoadmapMonthEntity overrides.
        // Since we need to wait for a variable number of streams (one for each projected month),
        // we return a Stream that uses combineLatest over the month streams.
        return _buildProjectedMonths(
          startMonth,
          monthsToProject,
          baseIncome,
          baseFixed,
          outflows,
        );
      },
    ).switchMap((stream) => stream);
  }

  Stream<List<RoadmapDisplayEntity>> _buildProjectedMonths(
    DateTime startMonth,
    int monthsToProject,
    double baseIncome,
    double baseFixed,
    List<TemporaryOutflowEntity> temporaryOutflows,
  ) {
    final List<Stream<RoadmapDisplayEntity>> monthStreams = [];

    for (int i = 0; i < monthsToProject; i++) {
      final currentMonth = DateTime(startMonth.year, startMonth.month + i, 1);
      final monthId = '${currentMonth.year}-${currentMonth.month.toString().padLeft(2, '0')}';

      // Calculate temporary outflows for this specific month
      double monthTempOutflows = 0;
      for (final outflow in temporaryOutflows) {
        // Check if currentMonth is between startMonth and endMonth inclusive
        final start = DateTime(outflow.startMonth.year, outflow.startMonth.month, 1);
        final end = DateTime(outflow.endMonth.year, outflow.endMonth.month, 1);
        if ((currentMonth.isAfter(start) || currentMonth.isAtSameMomentAs(start)) &&
            (currentMonth.isBefore(end) || currentMonth.isAtSameMomentAs(end))) {
          monthTempOutflows += outflow.amount;
        }
      }

      final monthStream = _roadmapRepo.watchRoadmapMonth(monthId).map((overrideEntity) {
        final effectiveIncome = overrideEntity?.netIncomeOverride ?? baseIncome;
        final effectiveFixed = overrideEntity?.coreFixedExpensesOverride ?? baseFixed;
        final totalOutflow = effectiveFixed + monthTempOutflows;
        final surplus = effectiveIncome - totalOutflow;

        return RoadmapDisplayEntity(
          id: monthId,
          month: currentMonth,
          effectiveIncome: effectiveIncome,
          effectiveFixedExpenses: effectiveFixed,
          temporaryOutflows: monthTempOutflows,
          totalOutflow: totalOutflow,
          surplus: surplus,
          accumulatedWealth: 0, // This will be calculated in the combine phase
          netIncomeOverride: overrideEntity?.netIncomeOverride,
          coreFixedExpensesOverride: overrideEntity?.coreFixedExpensesOverride,
          actionPlan: overrideEntity?.actionPlan,
        );
      });

      monthStreams.add(monthStream);
    }

    if (monthStreams.isEmpty) return Stream.value([]);

    return Rx.combineLatestList(monthStreams).map((List<RoadmapDisplayEntity> unsortedMonths) {
      final sortedMonths = List<RoadmapDisplayEntity>.from(unsortedMonths)
        ..sort((a, b) => a.month.compareTo(b.month));

      double runningWealth = 0;
      final finalMonths = <RoadmapDisplayEntity>[];

      for (final month in sortedMonths) {
        runningWealth += month.surplus;
        finalMonths.add(month.copyWith(accumulatedWealth: runningWealth));
      }

      return finalMonths;
    });
  }
}
