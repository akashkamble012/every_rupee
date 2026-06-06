import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/di/injection.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../widgets/charts/dashboard_charts.dart';
import '../../widgets/charts/insights_charts.dart';
import '../../widgets/common/month_navigator.dart';
import '../../widgets/tiles/variance_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardBloc>()
        ..add(DashboardEvent.load(
            DateTime(DateTime.now().year, DateTime.now().month, 1))),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final bloc = context.read<DashboardBloc>();

        return Scaffold(
          backgroundColor: AppDesign.background,
          body: SafeArea(
            child: state.when(
              initial: () => const Center(
                  child: CircularProgressIndicator(color: AppDesign.primary)),
              loading: () => const Center(
                  child: CircularProgressIndicator(color: AppDesign.primary)),
              failure: (message) => Center(
                  child: Text(message,
                      style: AppDesign.bodyMedium
                          .copyWith(color: AppDesign.error))),
              loaded: (month, surplus, variances, recentTransactions, pendingTransactions,
                      wealthHistory, historicalVariances, sortPreference, txSortPref, visibleCharts) =>
                  _LoadedBody(
                month: month,
                surplus: surplus,
                variances: variances,
                recentTransactions: recentTransactions,
                pendingTransactions: pendingTransactions,
                wealthHistory: wealthHistory,
                historicalVariances: historicalVariances,
                sortPreference: sortPreference,
                txSortPref: txSortPref,
                visibleCharts: visibleCharts,
                onPrev: () => bloc.add(const DashboardEvent.previousMonth()),
                onNext: () => bloc.add(const DashboardEvent.nextMonth()),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final DateTime month;
  final MonthlySurplusEntity surplus;
  final List<CategoryVarianceEntity> variances;
  final List<TransactionEntity> recentTransactions;
  final List<TransactionEntity> pendingTransactions;
  final List<MonthlySurplusEntity> wealthHistory;
  final List<List<CategoryVarianceEntity>> historicalVariances;
  final String sortPreference;
  final String txSortPref;
  final List<String> visibleCharts;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _LoadedBody({
    required this.month,
    required this.surplus,
    required this.variances,
    required this.recentTransactions,
    required this.pendingTransactions,
    required this.wealthHistory,
    required this.historicalVariances,
    required this.sortPreference,
    required this.txSortPref,
    required this.visibleCharts,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // ── Month navigator ─────────────────────────────────────────
        SliverToBoxAdapter(
          child: MonthNavigator(
            month: month,
            onPrevious: onPrev,
            onNext: onNext,
          ),
        ),

        if (pendingTransactions.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppDesign.s16, AppDesign.s8, AppDesign.s16, AppDesign.s16),
              child: _PendingReviewBanner(pendingTransactions: pendingTransactions),
            ),
          ),

        // ── Macro numbers card ──────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(AppDesign.s16, 0, AppDesign.s16, 0),
            child: _MacroCard(surplus: surplus),
          ),
        ),

        // ── Quick Stats ─────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
            child: QuickStatsCard(
              transactions: recentTransactions,
              variances: variances,
            ),
          ),
        ),

        // ── Action Plan ─────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
            child: _ActionPlanSection(month: month),
          ),
        ),

        // ── Customize Dashboard ──────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppDesign.s16, AppDesign.s24, AppDesign.s16, AppDesign.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Charts Overview', style: AppDesign.titleMedium),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.dashboard_customize_rounded, color: AppDesign.subtle, size: 20),
                  color: AppDesign.surfaceHigh,
                  tooltip: 'Customize Charts',
                  itemBuilder: (context) => [
                    _buildChartToggleMenuItem(context, 'wealth_trend', 'Wealth Trend'),
                    _buildChartToggleMenuItem(context, 'allocation_donut', 'Allocation Donut'),
                    _buildChartToggleMenuItem(context, 'daily_spend', 'Daily Spend Velocity'),
                    _buildChartToggleMenuItem(context, 'income_expense', 'Income vs Expenses'),
                    _buildChartToggleMenuItem(context, 'category_breakdown', 'Category Breakdown'),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ── Wealth Trend Chart ──────────────────────────────────────
        if (wealthHistory.isNotEmpty && visibleCharts.contains('wealth_trend'))
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
              child: Container(
                padding: const EdgeInsets.all(AppDesign.s16),
                decoration: BoxDecoration(
                  color: AppDesign.surface,
                  borderRadius: AppDesign.roundLarge,
                  border: Border.all(color: AppDesign.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wealth Trend', style: AppDesign.titleMedium),
                    const SizedBox(height: AppDesign.s16),
                    WealthTrendChart(wealthHistory: wealthHistory),
                  ],
                ),
              ),
            ),
          ),

        // ── Income vs Expenses ──────────────────────────────────────
        if (wealthHistory.isNotEmpty && visibleCharts.contains('income_expense'))
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
              child: Container(
                padding: const EdgeInsets.all(AppDesign.s16),
                decoration: BoxDecoration(
                  color: AppDesign.surface,
                  borderRadius: AppDesign.roundLarge,
                  border: Border.all(color: AppDesign.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Income vs. Expenses', style: AppDesign.titleMedium),
                    const SizedBox(height: AppDesign.s16),
                    IncomeExpenseChart(wealthHistory: wealthHistory),
                  ],
                ),
              ),
            ),
          ),

        // ── Donut chart ─────────────────────────────────────────────
        if (variances.isNotEmpty && visibleCharts.contains('allocation_donut'))
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
              child: _AllocationDonut(variances: variances),
            ),
          ),
          
        // ── Category Spending ───────────────────────────────────────
        if (historicalVariances.isNotEmpty && visibleCharts.contains('category_breakdown'))
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
              child: Container(
                padding: const EdgeInsets.all(AppDesign.s16),
                decoration: BoxDecoration(
                  color: AppDesign.surface,
                  borderRadius: AppDesign.roundLarge,
                  border: Border.all(color: AppDesign.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category Spending Trend', style: AppDesign.titleMedium),
                    const SizedBox(height: AppDesign.s16),
                    CategorySpendingChart(
                      historicalVariances: historicalVariances,
                      wealthHistory: wealthHistory,
                    ),
                  ],
                ),
              ),
            ),
          ),

        // ── Daily Spend Chart ───────────────────────────────────────
        if (recentTransactions.isNotEmpty && visibleCharts.contains('daily_spend'))
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
              child: Container(
                padding: const EdgeInsets.all(AppDesign.s16),
                decoration: BoxDecoration(
                  color: AppDesign.surface,
                  borderRadius: AppDesign.roundLarge,
                  border: Border.all(color: AppDesign.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily Spend Velocity', style: AppDesign.titleMedium),
                    const SizedBox(height: AppDesign.s16),
                    DailySpendChart(transactions: recentTransactions, month: month),
                  ],
                ),
              ),
            ),
          ),

        // ── Category Variance tiles ─────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                AppDesign.s16, AppDesign.s24, AppDesign.s16, AppDesign.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category Variance', style: AppDesign.titleMedium),
                PopupMenuButton<String>(
                  initialValue: sortPreference,
                  icon: const Icon(Icons.sort_rounded, color: AppDesign.subtle),
                  color: AppDesign.surfaceHigh,
                  onSelected: (value) {
                    context.read<DashboardBloc>().add(
                        DashboardEvent.changeSortPreference(value));
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'highestSpent',
                      child: Text('Highest Spent'),
                    ),
                    const PopupMenuItem(
                      value: 'lowestSpent',
                      child: Text('Lowest Spent'),
                    ),
                    const PopupMenuItem(
                      value: 'highestVariance',
                      child: Text('Highest Variance'),
                    ),
                    const PopupMenuItem(
                      value: 'lowestVariance',
                      child: Text('Lowest Variance'),
                    ),
                    const PopupMenuItem(
                      value: 'nameAsc',
                      child: Text('Name A-Z'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverList.builder(
          itemCount: variances.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDesign.s16, vertical: AppDesign.s4),
            child: VarianceTile(variance: variances[i]),
          ),
        ),

        // ── Recent Transactions ────────────────────────────────────
        if (recentTransactions.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDesign.s16, AppDesign.s24, AppDesign.s16, AppDesign.s8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: AppDesign.titleMedium),
                  PopupMenuButton<String>(
                    initialValue: txSortPref,
                    onSelected: (val) {
                      context.read<DashboardBloc>().add(
                          DashboardEvent.changeTransactionSortPreference(val));
                    },
                    icon: const Icon(Icons.sort_rounded, color: AppDesign.subtle, size: 20),
                    color: AppDesign.surfaceHigh,
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'dateDesc',
                        child: Text('Newest First'),
                      ),
                      const PopupMenuItem(
                        value: 'dateAsc',
                        child: Text('Oldest First'),
                      ),
                      const PopupMenuItem(
                        value: 'amountDesc',
                        child: Text('Highest Amount'),
                      ),
                      const PopupMenuItem(
                        value: 'amountAsc',
                        child: Text('Lowest Amount'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: recentTransactions.length > 10 ? 10 : recentTransactions.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDesign.s16, vertical: AppDesign.s4),
              child: _RecentTxTile(tx: recentTransactions[i]),
            ),
          ),
          if (recentTransactions.length > 10)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDesign.s16, vertical: AppDesign.s8),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.ledger),
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppDesign.roundMedium,
                      ),
                      padding:
                          const EdgeInsets.symmetric(vertical: AppDesign.s16),
                      backgroundColor: AppDesign.surface,
                    ),
                    child: Text('Show All',
                        style: AppDesign.labelLarge
                            .copyWith(color: AppDesign.primary)),
                  ),
                ),
              ),
            ),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: AppDesign.s64)),
      ],
    );
  }

  PopupMenuItem<String> _buildChartToggleMenuItem(BuildContext context, String chartId, String title) {
    final isVisible = visibleCharts.contains(chartId);
    return PopupMenuItem<String>(
      value: chartId,
      onTap: () {
        context.read<DashboardBloc>().add(DashboardEvent.toggleDashboardChart(chartId));
      },
      child: Row(
        children: [
          Icon(
            isVisible ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
            color: isVisible ? AppDesign.primary : AppDesign.subtle,
            size: 20,
          ),
          const SizedBox(width: AppDesign.s12),
          Text(title, style: AppDesign.bodyMedium.copyWith(color: isVisible ? AppDesign.onBackground : AppDesign.subtle)),
        ],
      ),
    );
  }
}

// ── Action Plan Section ───────────────────────────────────────────────────

class _ActionPlanSection extends StatefulWidget {
  final DateTime month;
  const _ActionPlanSection({required this.month});

  @override
  State<_ActionPlanSection> createState() => _ActionPlanSectionState();
}

class _ActionPlanSectionState extends State<_ActionPlanSection> {
  String? _plan;

  String get _key => 'action_plan_${widget.month.year}_${widget.month.month}';

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  @override
  void didUpdateWidget(_ActionPlanSection old) {
    super.didUpdateWidget(old);
    if (old.month != widget.month) _loadPlan();
  }

  Future<void> _loadPlan() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) setState(() => _plan = prefs.getString(_key));
  }

  Future<void> _savePlan(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, value);
    if (mounted) setState(() => _plan = value);
  }

  @override
  Widget build(BuildContext context) {
    return MonthlyActionPlanCard(
      actionPlan: _plan,
      onSave: _savePlan,
    );
  }
}

// ── Macro card ────────────────────────────────────────────────────────────

class _MacroCard extends StatelessWidget {
  final MonthlySurplusEntity surplus;
  const _MacroCard({required this.surplus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDesign.s20),
      decoration: BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
        boxShadow: AppDesign.shadowCard,
      ),
      child: Column(
        children: [
          _MacroRow(
            label: 'Net Income',
            value: formatINR(surplus.totalIncome),
            color: AppDesign.credit,
          ),
          const SizedBox(height: AppDesign.s12),
          _MacroRow(
            label: 'Total Allocated',
            value: formatINR(surplus.totalAllocated),
            color: AppDesign.onBackground,
          ),
          const Divider(height: AppDesign.s24, color: AppDesign.divider),
          _MacroRow(
            label: 'Spent This Month',
            value: formatINR(surplus.totalSpent),
            color: AppDesign.debit,
          ),
          const SizedBox(height: AppDesign.s12),
          _MacroRow(
            label: 'Balance Remaining',
            value: formatINR(surplus.balance),
            color: surplus.balance >= 0 ? AppDesign.success : AppDesign.error,
            isBold: true,
          ),
          if (surplus.surplus != 0) ...[
            const SizedBox(height: AppDesign.s8),
            _MacroRow(
              label: 'Saving / Special Fund',
              value: formatINR(surplus.surplus.abs()),
              color: surplus.surplus > 0 ? AppDesign.warning : AppDesign.error,
            ),
          ],
        ],
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isBold;

  const _MacroRow({
    required this.label,
    required this.value,
    required this.color,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold ? AppDesign.amountMedium : AppDesign.amountSmall;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isBold ? AppDesign.titleMedium : AppDesign.bodySmall),
        Text(value, style: style.copyWith(color: color)),
      ],
    );
  }
}

// ── Allocation donut ──────────────────────────────────────────────────────

class _AllocationDonut extends StatelessWidget {
  final List<CategoryVarianceEntity> variances;
  const _AllocationDonut({required this.variances});

  static const List<Color> _chartColors = [
    AppDesign.primary,
    AppDesign.credit,
    AppDesign.warning,
    AppDesign.debit,
    AppDesign.success,
    AppDesign.primaryLight,
  ];

  @override
  Widget build(BuildContext context) {
    final sections = variances.take(6).toList().asMap().entries.map((entry) {
      final index = entry.key;
      final v = entry.value;
      final color = _chartColors[index % _chartColors.length];
      return PieChartSectionData(
        value: v.spent > 0 ? v.spent : v.category.cap * 0.01,
        color: color.withOpacity(0.85),
        radius: 40,
        title: '',
      );
    }).toList();

    return Container(
      height: 160,
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: const BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: PieChart(PieChartData(
              sections: sections,
              centerSpaceRadius: 32,
              sectionsSpace: 2,
            )),
          ),
          const SizedBox(width: AppDesign.s16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: variances.take(4).toList().asMap().entries.map((entry) {
                final index = entry.key;
                final v = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _chartColors[index % _chartColors.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          v.category.name,
                          style: AppDesign.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recent transaction tile ───────────────────────────────────────────────

class _RecentTxTile extends StatelessWidget {
  final TransactionEntity tx;
  const _RecentTxTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isDebit = tx.type == TransactionType.debit;
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppDesign.s16, vertical: AppDesign.s4),
      padding: const EdgeInsets.symmetric(
          horizontal: AppDesign.s16, vertical: AppDesign.s12),
      decoration: const BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundMedium,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (isDebit ? AppDesign.debit : AppDesign.credit)
                  .withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDebit
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: isDebit ? AppDesign.debit : AppDesign.credit,
              size: 18,
            ),
          ),
          const SizedBox(width: AppDesign.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.merchant ?? 'Transaction',
                  style: AppDesign.bodyMedium
                      .copyWith(color: AppDesign.onBackground),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(formatShortDate(tx.date), style: AppDesign.bodySmall),
              ],
            ),
          ),
          Text(
            '${isDebit ? '-' : '+'}${formatINR(tx.amount)}',
            style: AppDesign.amountSmall
                .copyWith(color: isDebit ? AppDesign.debit : AppDesign.credit),
          ),
        ],
      ),
    );
  }
  }


// ── Pending Review Banner ───────────────────────────────────────────────────

class _PendingReviewBanner extends StatelessWidget {
  final List<TransactionEntity> pendingTransactions;

  const _PendingReviewBanner({required this.pendingTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.s16, vertical: AppDesign.s12),
      decoration: BoxDecoration(
        color: AppDesign.warning.withOpacity(0.1),
        borderRadius: AppDesign.roundMedium,
        border: Border.all(color: AppDesign.warning.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppDesign.warning),
          const SizedBox(width: AppDesign.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pendingTransactions.length} Pending Review',
                  style: AppDesign.titleMedium.copyWith(color: AppDesign.onBackground),
                ),
                Text(
                  'Auto-captured from SMS. Tap to categorize.',
                  style: AppDesign.bodySmall.copyWith(color: AppDesign.subtle),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Simply navigate to ledger with a custom filter maybe?
              // Or open a dialog. Since we don't have a dedicated review screen yet,
              // we can just push to ledger. But ledger doesn't have a needsReview filter yet in UI.
              // For now, let's show a snackbar or push to a simple review modal if we create one.
              // We can push to the add transaction screen for the first one for simplicity.
              if (pendingTransactions.isNotEmpty) {
                context.push('${AppRoutes.transactionForm}?editId=${pendingTransactions.first.id}');
              }
            },
            child: const Text('Review', style: TextStyle(color: AppDesign.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
