import 'package:flutter/material.dart';

import '../../../core/theme/app_design.dart';
import '../../../domain/entities/entities.dart';



// ═══════════════════════════════════════════════════════════════════════════
// Monthly Action Plan Card
// Replicates Column H "Action Plan" from the Monthly Master Plan spreadsheet
// ═══════════════════════════════════════════════════════════════════════════

class MonthlyActionPlanCard extends StatefulWidget {
  /// The current month's action plan text.
  final String? actionPlan;

  /// Called when the user edits and saves the action plan.
  final ValueChanged<String>? onSave;

  const MonthlyActionPlanCard({
    super.key,
    this.actionPlan,
    this.onSave,
  });

  @override
  State<MonthlyActionPlanCard> createState() =>
      _MonthlyActionPlanCardState();
}

class _MonthlyActionPlanCardState extends State<MonthlyActionPlanCard> {
  bool _editing = false;
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.actionPlan ?? '');
  }

  @override
  void didUpdateWidget(MonthlyActionPlanCard old) {
    super.didUpdateWidget(old);
    if (!_editing && old.actionPlan != widget.actionPlan) {
      _ctrl.text = widget.actionPlan ?? '';
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
        border: Border(
          left: BorderSide(
              color: AppDesign.primary, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.flag_rounded,
                      color: AppDesign.primary, size: 16),
                  const SizedBox(width: 6),
                  Text('Monthly Action Plan',
                      style: AppDesign.labelLarge
                          .copyWith(color: AppDesign.primary)),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (_editing) {
                    widget.onSave?.call(_ctrl.text.trim());
                    setState(() => _editing = false);
                  } else {
                    setState(() => _editing = true);
                  }
                },
                child: Text(
                  _editing ? 'Save' : 'Edit',
                  style: AppDesign.bodySmall
                      .copyWith(color: AppDesign.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesign.s12),
          if (_editing)
            TextField(
              controller: _ctrl,
              autofocus: true,
              maxLines: 3,
              style: AppDesign.bodyMedium
                  .copyWith(color: AppDesign.onBackground),
              decoration: InputDecoration(
                hintText:
                    'e.g. Route freed ₹10,530 EMI into mutual fund...',
                hintStyle:
                    AppDesign.bodySmall.copyWith(color: AppDesign.subtle),
              ),
              onSubmitted: (v) {
                widget.onSave?.call(v.trim());
                setState(() => _editing = false);
              },
            )
          else
            Text(
              widget.actionPlan?.isNotEmpty == true
                  ? widget.actionPlan!
                  : 'Tap Edit to set your financial goal for this month.',
              style: AppDesign.bodyMedium.copyWith(
                color: widget.actionPlan?.isNotEmpty == true
                    ? AppDesign.onSurface
                    : AppDesign.subtle,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Quick Stats Card — Top Payment Mode + Highest Spend Category
// ═══════════════════════════════════════════════════════════════════════════

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
    final topMode = _topPaymentMode(transactions);
    final highestCat = _highestSpendCategory(variances);

    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundLarge,
      ),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.payment_rounded,
              label: 'Top Mode',
              value: topMode,
              color: AppDesign.primary,
            ),
          ),
          Container(
              width: 1, height: 40, color: AppDesign.divider),
          Expanded(
            child: _StatItem(
              icon: Icons.arrow_upward_rounded,
              label: 'Highest Spend',
              value: highestCat,
              color: AppDesign.warning,
            ),
          ),
        ],
      ),
    );
  }

  String _topPaymentMode(List<TransactionEntity> txs) {
    if (txs.isEmpty) return '—';
    final debits = txs.where((t) => t.type == TransactionType.debit);
    if (debits.isEmpty) return '—';
    final counts = <PaymentMode, int>{};
    for (final t in debits) {
      if (t.paymentMode != null) {
        counts[t.paymentMode!] = (counts[t.paymentMode!] ?? 0) + 1;
      }
    }
    if (counts.isEmpty) return 'UPI';
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key.name.toUpperCase();
  }

  String _highestSpendCategory(List<CategoryVarianceEntity> variances) {
    if (variances.isEmpty) return '—';
    final sorted = [...variances]
      ..sort((a, b) => b.spent.compareTo(a.spent));
    return sorted.first.category.name;
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(label, style: AppDesign.bodySmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppDesign.labelLarge.copyWith(color: color),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
