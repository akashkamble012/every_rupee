import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_design.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/dashboard/dashboard_bloc.dart';
import '../../../widgets/common/month_navigator.dart';
import '../../../widgets/tiles/variance_tile.dart';


class DashboardOverviewTab extends StatelessWidget {
  final DateTime month;
  final MonthlySurplusEntity surplus;
  final List<CategoryVarianceEntity> variances;
  final List<TransactionEntity> recentTransactions;
  final List<TransactionEntity> pendingTransactions;
  final String sortPreference;
  final String txSortPref;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const DashboardOverviewTab({
    super.key,
    required this.month,
    required this.surplus,
    required this.variances,
    required this.recentTransactions,
    required this.pendingTransactions,
    required this.sortPreference,
    required this.txSortPref,
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
              child: OverviewPendingReviewBanner(pendingTransactions: pendingTransactions),
            ),
          ),

        // ── Macro numbers card ──────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppDesign.s16, 0, AppDesign.s16, 0),
            child: OverviewMacroCard(surplus: surplus),
          ),
        ),

        // ── Quick Stats ─────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
            child: QuickStatsCard(
              transactions: recentTransactions,
              variances: variances,
            ),
          ),
        ),

        // ── Action Plan ─────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppDesign.s16, AppDesign.s12, AppDesign.s16, 0),
            child: OverviewActionPlanSection(month: month),
          ),
        ),

        // ── Category Variance tiles ─────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppDesign.s16, AppDesign.s24, AppDesign.s16, AppDesign.s8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category Variance', style: AppDesign.titleMedium),
                PopupMenuButton<String>(
                  initialValue: sortPreference,
                  icon: const Icon(Icons.sort_rounded, color: AppDesign.subtle),
                  color: AppDesign.surfaceHigh,
                  onSelected: (value) {
                    context.read<DashboardBloc>().add(DashboardEvent.changeSortPreference(value));
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'highestSpent', child: Text('Highest Spent')),
                    const PopupMenuItem(value: 'lowestSpent', child: Text('Lowest Spent')),
                    const PopupMenuItem(value: 'highestVariance', child: Text('Highest Variance')),
                    const PopupMenuItem(value: 'lowestVariance', child: Text('Lowest Variance')),
                    const PopupMenuItem(value: 'nameAsc', child: Text('Name A-Z')),
                  ],
                ),
              ],
            ),
          ),
        ),

        SliverList.builder(
          itemCount: variances.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDesign.s16, vertical: AppDesign.s4),
            child: VarianceTile(variance: variances[i]),
          ),
        ),

        // ── Recent Transactions ────────────────────────────────────
        if (recentTransactions.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppDesign.s16, AppDesign.s24, AppDesign.s16, AppDesign.s8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: AppDesign.titleMedium),
                  PopupMenuButton<String>(
                    initialValue: txSortPref,
                    onSelected: (val) {
                      context.read<DashboardBloc>().add(DashboardEvent.changeTransactionSortPreference(val));
                    },
                    icon: const Icon(Icons.sort_rounded, color: AppDesign.subtle, size: 20),
                    color: AppDesign.surfaceHigh,
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'dateDesc', child: Text('Newest First')),
                      const PopupMenuItem(value: 'dateAsc', child: Text('Oldest First')),
                      const PopupMenuItem(value: 'amountDesc', child: Text('Highest Amount')),
                      const PopupMenuItem(value: 'amountAsc', child: Text('Lowest Amount')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: recentTransactions.length > 10 ? 10 : recentTransactions.length,
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDesign.s16, vertical: AppDesign.s4),
              child: OverviewRecentTxTile(tx: recentTransactions[i]),
            ),
          ),
          if (recentTransactions.length > 10)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDesign.s16, vertical: AppDesign.s8),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => context.go(AppRoutes.ledger),
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: AppDesign.roundMedium),
                      padding: const EdgeInsets.symmetric(vertical: AppDesign.s16),
                      backgroundColor: AppDesign.surface,
                    ),
                    child: Text('Show All', style: AppDesign.labelLarge.copyWith(color: AppDesign.primary)),
                  ),
                ),
              ),
            ),
        ],

        const SliverToBoxAdapter(child: SizedBox(height: AppDesign.s64)),
      ],
    );
  }
}

// ── Action Plan Section ───────────────────────────────────────────────────
class OverviewActionPlanSection extends StatefulWidget {
  final DateTime month;
  const OverviewActionPlanSection({super.key, required this.month});

  @override
  State<OverviewActionPlanSection> createState() => _OverviewActionPlanSectionState();
}

class _OverviewActionPlanSectionState extends State<OverviewActionPlanSection> {
  String? _plan;
  String get _key => 'action_plan_${widget.month.year}_${widget.month.month}';

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  @override
  void didUpdateWidget(OverviewActionPlanSection old) {
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
class OverviewMacroCard extends StatelessWidget {
  final MonthlySurplusEntity surplus;
  const OverviewMacroCard({super.key, required this.surplus});

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
          OverviewMacroRow(
            label: 'Net Income',
            value: formatINR(surplus.totalIncome),
            color: AppDesign.credit,
          ),
          const SizedBox(height: AppDesign.s12),
          OverviewMacroRow(
            label: 'Total Allocated',
            value: formatINR(surplus.totalAllocated),
            color: AppDesign.onBackground,
          ),
          const Divider(height: AppDesign.s24, color: AppDesign.divider),
          OverviewMacroRow(
            label: 'Spent This Month',
            value: formatINR(surplus.totalSpent),
            color: AppDesign.debit,
          ),
          const SizedBox(height: AppDesign.s12),
          OverviewMacroRow(
            label: 'Balance Remaining',
            value: formatINR(surplus.balance),
            color: surplus.balance >= 0 ? AppDesign.success : AppDesign.error,
            isBold: true,
          ),
          if (surplus.surplus != 0) ...[
            const SizedBox(height: AppDesign.s8),
            OverviewMacroRow(
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

class OverviewMacroRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isBold;

  const OverviewMacroRow({
    super.key,
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
        Text(label, style: isBold ? AppDesign.titleMedium : AppDesign.bodySmall),
        Text(value, style: style.copyWith(color: color)),
      ],
    );
  }
}

// ── Recent transaction tile ───────────────────────────────────────────────
class OverviewRecentTxTile extends StatelessWidget {
  final TransactionEntity tx;
  const OverviewRecentTxTile({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isDebit = tx.type == TransactionType.debit;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDesign.s16, vertical: AppDesign.s4),
      padding: const EdgeInsets.symmetric(horizontal: AppDesign.s16, vertical: AppDesign.s12),
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
              color: (isDebit ? AppDesign.debit : AppDesign.credit).withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDebit ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
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
                  style: AppDesign.bodyMedium.copyWith(color: AppDesign.onBackground),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(formatShortDate(tx.date), style: AppDesign.bodySmall),
              ],
            ),
          ),
          Text(
            '${isDebit ? '-' : '+'}${formatINR(tx.amount)}',
            style: AppDesign.amountSmall.copyWith(color: isDebit ? AppDesign.debit : AppDesign.credit),
          ),
        ],
      ),
    );
  }
}

// ── Pending Review Banner ───────────────────────────────────────────────────
class OverviewPendingReviewBanner extends StatelessWidget {
  final List<TransactionEntity> pendingTransactions;

  const OverviewPendingReviewBanner({super.key, required this.pendingTransactions});

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

class QuickStatsCard extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final List<CategoryVarianceEntity> variances;

  const QuickStatsCard({
    super.key,
    required this.transactions,
    required this.variances,
  });

  @override
  Widget build(BuildContext context) {
    final largestTx = transactions.isEmpty
        ? null
        : transactions.reduce((a, b) => a.amount > b.amount ? a : b);
        
    final activeVariances = variances.where((v) => v.spent > 0).toList();
    final mostSpentCat = activeVariances.isEmpty
        ? null
        : activeVariances.reduce((a, b) => a.spent > b.spent ? a : b);

    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
        border: Border.all(color: AppDesign.divider),
      ),
      child: Row(
        children: [
          Expanded(
            child: _QuickStat(
              icon: Icons.local_fire_department_rounded,
              color: AppDesign.warning,
              label: 'Largest Spent',
              value: largestTx != null ? formatINR(largestTx.amount) : '---',
              subValue: largestTx?.merchant ?? 'No transactions',
            ),
          ),
          Container(width: 1, height: 40, color: AppDesign.divider),
          Expanded(
            child: _QuickStat(
              icon: Icons.trending_up_rounded,
              color: AppDesign.error,
              label: 'Top Category',
              value: mostSpentCat != null ? formatINR(mostSpentCat.spent) : '---',
              subValue: mostSpentCat?.category.name ?? 'No data',
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String subValue;

  const _QuickStat({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.subValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: AppDesign.s8),
        Text(label, style: AppDesign.bodySmall.copyWith(color: AppDesign.subtle)),
        const SizedBox(height: AppDesign.s4),
        Text(value, style: AppDesign.titleMedium),
        Text(subValue, style: AppDesign.bodySmall.copyWith(color: AppDesign.subtle), overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

class MonthlyActionPlanCard extends StatelessWidget {
  final String? actionPlan;
  final ValueChanged<String> onSave;

  const MonthlyActionPlanCard({
    super.key,
    required this.actionPlan,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surfaceHigh,
        borderRadius: AppDesign.roundLarge,
        border: Border.all(color: AppDesign.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag_rounded, color: AppDesign.primary, size: 20),
              const SizedBox(width: AppDesign.s8),
              Text('Monthly Action Plan', style: AppDesign.titleMedium),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: AppDesign.subtle, size: 18),
                onPressed: () => _showEditDialog(context),
              ),
            ],
          ),
          const SizedBox(height: AppDesign.s8),
          Text(
            (actionPlan == null || actionPlan!.isEmpty)
                ? 'No action plan set for this month. Tap edit to set goals or notes.'
                : actionPlan!,
            style: AppDesign.bodyMedium.copyWith(
              color: (actionPlan == null || actionPlan!.isEmpty) ? AppDesign.subtle : AppDesign.onBackground,
              fontStyle: (actionPlan == null || actionPlan!.isEmpty) ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: actionPlan);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppDesign.surface,
        title: Text('Edit Action Plan', style: AppDesign.displayLarge),
        content: TextField(
          controller: controller,
          maxLines: 4,
          style: AppDesign.bodyMedium,
          decoration: InputDecoration(
            hintText: 'E.g., Save for vacation, cut down on dining out...',
            hintStyle: AppDesign.bodyMedium.copyWith(color: AppDesign.subtle),
            filled: true,
            fillColor: AppDesign.background,
            border: OutlineInputBorder(
              borderRadius: AppDesign.roundMedium,
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppDesign.labelLarge.copyWith(color: AppDesign.subtle)),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppDesign.primary,
              shape: RoundedRectangleBorder(borderRadius: AppDesign.roundMedium),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
