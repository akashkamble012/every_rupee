import 'package:flutter/material.dart';

import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';

/// The core tracker card: Category Name, Amount Left, Green/Amber/Red bar.
class VarianceTile extends StatelessWidget {
  final CategoryVarianceEntity variance;

  const VarianceTile({super.key, required this.variance});

  @override
  Widget build(BuildContext context) {
    final cat = variance.category;
    final color = spendColor(variance.ratio);
    final percent = (variance.ratio * 100).clamp(0.0, 100.0);

    return Container(
      padding: const EdgeInsets.all(AppDesign.s16),
      decoration: const BoxDecoration(
        color: AppDesign.surface,
        borderRadius: AppDesign.roundMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row ─────────────────────────────────────────────
          Row(
            children: [
              // Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: AppDesign.roundSmall,
                ),
                child: Icon(
                  cat.iconCode != null
                      ? IconData(int.parse(cat.iconCode!),
                          fontFamily: 'MaterialIcons')
                      : Icons.category_rounded,
                  size: 17,
                  color: color,
                ),
              ),
              const SizedBox(width: AppDesign.s12),

              // Name + remaining
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cat.name, style: AppDesign.titleMedium),
                    const SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: formatINR(variance.remaining),
                            style: AppDesign.amountSmall.copyWith(color: color),
                          ),
                          TextSpan(
                            text: ' left of ${formatINR(cat.cap)}',
                            style: AppDesign.bodySmall,
                          ),
                          TextSpan(
                            text: ' • ${formatINR(variance.spent)} spent',
                            style: AppDesign.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Percentage badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${percent.toStringAsFixed(0)}%',
                  style: AppDesign.labelLarge.copyWith(color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesign.s12),

          // ── Progress bar ─────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: variance.ratio.clamp(0.0, 1.0),
              backgroundColor: AppDesign.surfaceHigh,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}
