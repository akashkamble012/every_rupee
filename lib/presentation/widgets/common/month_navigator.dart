import 'package:flutter/material.dart';

import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';

class MonthNavigator extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const MonthNavigator({
    super.key,
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth = _isCurrentMonth(month);

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -300) {
          // Swipe left → next month
          onNext();
        } else if (details.primaryVelocity! > 300) {
          // Swipe right → previous month
          onPrevious();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDesign.s16, vertical: AppDesign.s12),
        color: AppDesign.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Every Rupee', style: AppDesign.headlineMedium),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded,
                      color: AppDesign.subtle),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onPrevious,
                ),
                const SizedBox(width: AppDesign.s4),
                GestureDetector(
                  onTap: () {
                    // Jump to current month
                    if (!isCurrentMonth) {
                      onNext(); // simplified; real impl would navigate directly
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDesign.s12,
                        vertical: AppDesign.s4),
                    decoration: BoxDecoration(
                      color: isCurrentMonth
                          ? AppDesign.primary.withValues(alpha: 0.12)
                          : AppDesign.surfaceHigh,
                      borderRadius: BorderRadius.circular(20),
                      border: isCurrentMonth
                          ? Border.all(
                              color: AppDesign.primary.withValues(alpha: 0.3),
                              width: 1)
                          : null,
                    ),
                    child: Text(
                      formatMonthYear(month),
                      style: AppDesign.labelLarge.copyWith(
                        color: isCurrentMonth
                            ? AppDesign.primary
                            : AppDesign.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDesign.s4),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded,
                      color: AppDesign.subtle),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _isCurrentMonth(DateTime month) {
    final now = DateTime.now();
    return month.year == now.year && month.month == now.month;
  }
}
