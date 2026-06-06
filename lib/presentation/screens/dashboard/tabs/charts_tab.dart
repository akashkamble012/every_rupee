import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../blocs/insights/insights_bloc.dart';
import '../../../widgets/charts/insights_charts.dart';

class DashboardChartsTab extends StatelessWidget {
  const DashboardChartsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsightsBloc, InsightsState>(
      builder: (context, insightsState) {
        return BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, dashboardState) {
            
            // Extract Dashboard data for current month charts
            DateTime? currentMonth;
            List<CategoryVarianceEntity> currentVariances = [];
            List<TransactionEntity> recentTx = [];
            
            dashboardState.maybeWhen(
              loaded: (month, _, vars, txs, __, ___, ____, _____, ______, _______) {
                currentMonth = month;
                currentVariances = vars;
                recentTx = txs;
              },
              orElse: () {},
            );

            return insightsState.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (msg) => Center(child: Text(msg, style: const TextStyle(color: AppDesign.error))),
              loaded: (month, txs, wealth, variances) => _ChartsTabBody(
                currentMonth: currentMonth ?? month,
                historicalWealth: wealth,
                historicalVariances: variances,
                historicalTxs: txs,
                currentVariances: currentVariances,
                recentTxs: recentTx,
              ),
            );
          },
        );
      },
    );
  }
}

class _ChartsTabBody extends StatelessWidget {
  final DateTime currentMonth;
  final List<dynamic> historicalWealth;
  final List<dynamic> historicalVariances;
  final List<dynamic> historicalTxs;
  
  final List<CategoryVarianceEntity> currentVariances;
  final List<TransactionEntity> recentTxs;

  const _ChartsTabBody({
    required this.currentMonth,
    required this.historicalWealth,
    required this.historicalVariances,
    required this.historicalTxs,
    required this.currentVariances,
    required this.recentTxs,
  });

  List<Map<String, dynamic>> _calculateMoM() {
    if (historicalVariances.length < 2) return [];
    
    final currentVars = historicalVariances.last as List<CategoryVarianceEntity>;
    final prevVars = historicalVariances[historicalVariances.length - 2] as List<CategoryVarianceEntity>;
    
    final List<Map<String, dynamic>> momChanges = [];
    
    for (var cv in currentVars) {
      final pv = prevVars.where((v) => v.category.id == cv.category.id).firstOrNull;
      if (pv != null) {
        final diff = cv.spent - pv.spent;
        if (diff.abs() > 0) {
          final percent = pv.spent == 0 ? 100.0 : (diff / pv.spent) * 100;
          momChanges.add({
            'category': cv.category.name,
            'iconCode': cv.category.iconCode,
            'diff': diff,
            'percent': percent,
            'currentSpent': cv.spent,
            'prevSpent': pv.spent,
          });
        }
      }
    }
    
    momChanges.sort((a, b) => (b['diff'] as double).abs().compareTo((a['diff'] as double).abs()));
    return momChanges.take(5).toList(); 
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDesign.s16),
      children: [
        // ── Dashboard Current Month Charts ───────────────────────
        if (currentVariances.isNotEmpty)
          _ChartCard(
            title: 'Current Month Allocation',
            child: _AllocationDonut(variances: currentVariances),
          ),
        if (currentVariances.isNotEmpty) const SizedBox(height: AppDesign.s16),

        if (recentTxs.isNotEmpty)
          _ChartCard(
            title: 'Daily Spend Velocity (Current Month)',
            child: DailySpendChart(transactions: recentTxs, month: currentMonth),
          ),
        if (recentTxs.isNotEmpty) const SizedBox(height: AppDesign.s16),

        // ── Insights Historical Charts ───────────────────────────
        if (historicalWealth.isNotEmpty)
          _ChartCard(
            title: 'Wealth & Savings Trend (Last 6 Months)',
            child: WealthTrendChart(wealthHistory: List.from(historicalWealth)),
          ),
        if (historicalWealth.isNotEmpty) const SizedBox(height: AppDesign.s16),
        
        if (historicalWealth.isNotEmpty)
          _ChartCard(
            title: 'Income vs. Expenses (Last 6 Months)',
            child: IncomeExpenseChart(wealthHistory: List.from(historicalWealth)),
          ),
        if (historicalWealth.isNotEmpty) const SizedBox(height: AppDesign.s16),
        
        if (historicalVariances.isNotEmpty)
          _ChartCard(
            title: 'Top Categories Spent (Last 6 Months)',
            child: CategorySpendingChart(
              historicalVariances: List.from(historicalVariances),
              wealthHistory: List.from(historicalWealth),
            ),
          ),
        if (historicalVariances.isNotEmpty) const SizedBox(height: AppDesign.s16),

        if (historicalTxs.isNotEmpty)
          _ChartCard(
            title: 'Payment Method Breakdown',
            child: PaymentMethodChart(transactions: List.from(historicalTxs)),
          ),
        if (historicalTxs.isNotEmpty) const SizedBox(height: AppDesign.s16),

        _buildMoMSection(),
        
        const SizedBox(height: 100), // padding for bottom nav
      ],
    );
  }

  Widget _buildMoMSection() {
    final momChanges = _calculateMoM();
    if (momChanges.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
        border: Border.all(color: AppDesign.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Month-over-Month Movers', style: AppDesign.titleMedium),
          const SizedBox(height: AppDesign.s16),
          ...momChanges.map((change) {
            final isIncrease = change['diff'] > 0;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDesign.s8),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppDesign.surfaceHigh,
                      borderRadius: AppDesign.roundSmall,
                    ),
                    child: Center(
                      child: Text(change['iconCode'], style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: AppDesign.s12),
                  Expanded(
                    child: Text(change['category'], style: AppDesign.bodyMedium),
                  ),
                  Row(
                    children: [
                      Icon(
                        isIncrease ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        color: isIncrease ? AppDesign.debit : AppDesign.success,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${change['percent'].toStringAsFixed(1)}%',
                        style: AppDesign.amountSmall.copyWith(
                          color: isIncrease ? AppDesign.debit : AppDesign.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
        border: Border.all(color: AppDesign.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppDesign.titleMedium),
          const SizedBox(height: AppDesign.s16),
          child,
        ],
      ),
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
