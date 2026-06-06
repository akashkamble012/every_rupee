import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_design.dart';
import '../../../domain/entities/entities.dart';

// ── Wealth & Savings Trend (Line Chart) ───────────────────────────────────

class WealthTrendChart extends StatelessWidget {
  final List<MonthlySurplusEntity> wealthHistory;
  
  const WealthTrendChart({super.key, required this.wealthHistory});

  @override
  Widget build(BuildContext context) {
    if (wealthHistory.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    // Sort history chronologically
    final sortedHistory = List<MonthlySurplusEntity>.from(wealthHistory)
      ..sort((a, b) => a.month.compareTo(b.month));

    final spots = sortedHistory.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.surplus);
    }).toList();

    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppDesign.surfaceHigh,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final month = sortedHistory[spot.x.toInt()].month;
                  final formattedMonth = DateFormat('MMM yy').format(month);
                  return LineTooltipItem(
                    '$formattedMonth\n₹${spot.y.toStringAsFixed(0)}',
                    const TextStyle(color: AppDesign.primary, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < sortedHistory.length) {
                    final date = sortedHistory[value.toInt()].month;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(DateFormat('MMM').format(date), style: const TextStyle(fontSize: 10, color: AppDesign.subtle)),
                    );
                  }
                  return const SizedBox();
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _formatCompact(value),
                    style: const TextStyle(fontSize: 10, color: AppDesign.subtle),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppDesign.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppDesign.primary.withOpacity(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCompact(double value) {
    if (value >= 10000000) return '${(value / 10000000).toStringAsFixed(1)}Cr';
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(1)}L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  }
}

// ── Income vs Expense (Grouped Bar Chart) ─────────────────────────────────

class IncomeExpenseChart extends StatelessWidget {
  final List<MonthlySurplusEntity> wealthHistory;

  const IncomeExpenseChart({super.key, required this.wealthHistory});

  @override
  Widget build(BuildContext context) {
    if (wealthHistory.isEmpty) return const SizedBox();

    final sortedHistory = List<MonthlySurplusEntity>.from(wealthHistory)
      ..sort((a, b) => a.month.compareTo(b.month));

    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => AppDesign.surfaceHigh,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedHistory.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat('MMM').format(sortedHistory[index].month),
                        style: const TextStyle(fontSize: 10, color: AppDesign.subtle),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _formatCompact(value),
                    style: const TextStyle(fontSize: 10, color: AppDesign.subtle),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => const FlLine(color: AppDesign.divider, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barGroups: sortedHistory.asMap().entries.map((e) {
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value.totalIncome,
                  color: AppDesign.success,
                  width: 8,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
                BarChartRodData(
                  toY: e.value.totalSpent,
                  color: AppDesign.error,
                  width: 8,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatCompact(double value) {
    if (value >= 10000000) return '${(value / 10000000).toStringAsFixed(1)}Cr';
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(1)}L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  }
}

// ── Daily Spend Velocity (Bar Chart) ──────────────────────────────────────

class DailySpendChart extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final DateTime month;

  const DailySpendChart({super.key, required this.transactions, required this.month});

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final dailyTotals = List<double>.filled(daysInMonth, 0.0);

    for (final tx in transactions) {
      if (tx.type == TransactionType.debit && tx.date.month == month.month && tx.date.year == month.year) {
        dailyTotals[tx.date.day - 1] += tx.amount;
      }
    }

    final maxY = dailyTotals.isEmpty ? 100.0 : (dailyTotals.reduce((a, b) => a > b ? a : b) * 1.2).clamp(100.0, double.infinity);

    return AspectRatio(
      aspectRatio: 2.0,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => AppDesign.surfaceHigh,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'Day ${group.x + 1}\n₹${rod.toY.toStringAsFixed(0)}',
                  const TextStyle(color: AppDesign.primary, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final day = value.toInt() + 1;
                  if (day % 5 == 0 || day == 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(day.toString(), style: const TextStyle(fontSize: 10, color: AppDesign.subtle)),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(daysInMonth, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: dailyTotals[index],
                  color: AppDesign.primary.withOpacity(0.8),
                  width: 4,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Payment Method Breakdown (Donut) ──────────────────────────────────────

class PaymentMethodChart extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const PaymentMethodChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final debits = transactions.where((tx) => tx.type == TransactionType.debit).toList();
    if (debits.isEmpty) return const SizedBox();

    final modeTotals = <PaymentMode, double>{};
    for (final tx in debits) {
      final mode = tx.paymentMode ?? PaymentMode.other;
      modeTotals[mode] = (modeTotals[mode] ?? 0) + tx.amount;
    }

    final total = modeTotals.values.fold(0.0, (a, b) => a + b);
    final sortedModes = modeTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    
    final colors = [
      AppDesign.primary,
      const Color(0xFFE91E63),
      const Color(0xFFFFC107),
      const Color(0xFF00BCD4),
      const Color(0xFF8BC34A),
    ];

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: sortedModes.asMap().entries.map((e) {
                  final color = colors[e.key % colors.length];
                  return PieChartSectionData(
                    color: color,
                    value: e.value.value,
                    title: '',
                    radius: 20,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sortedModes.asMap().entries.map((e) {
              final color = colors[e.key % colors.length];
              final percent = (e.value.value / total) * 100;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(width: 12, height: 12, color: color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _capitalize(e.value.key.name),
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text('${percent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}

// ── Category Spending Over Time (Stacked Bar) ─────────────────────────────

class CategorySpendingChart extends StatelessWidget {
  final List<List<CategoryVarianceEntity>> historicalVariances;
  final List<MonthlySurplusEntity> wealthHistory;

  const CategorySpendingChart({super.key, required this.historicalVariances, required this.wealthHistory});

  @override
  Widget build(BuildContext context) {
    if (historicalVariances.isEmpty || wealthHistory.isEmpty) return const SizedBox();
    if (historicalVariances.length != wealthHistory.length) return const SizedBox(); // Ensure alignment
    
    // Reverse historical arrays so oldest is first
    final sortedVariances = historicalVariances.reversed.toList();
    final sortedHistory = wealthHistory.reversed.toList();

    // Find top 4 categories across all months
    final categoryTotals = <String, double>{};
    for (final monthVars in sortedVariances) {
      for (final v in monthVars) {
        categoryTotals[v.category.name] = (categoryTotals[v.category.name] ?? 0) + v.spent;
      }
    }
    
    final sortedCategories = categoryTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topCategories = sortedCategories.take(4).map((e) => e.key).toList();
    
    final colors = [
      AppDesign.primary,
      const Color(0xFFE91E63),
      const Color(0xFFFFC107),
      const Color(0xFF00BCD4),
    ];
    final othersColor = AppDesign.subtle.withOpacity(0.3);

    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => AppDesign.surfaceHigh,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedHistory.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat('MMM').format(sortedHistory[index].month),
                        style: const TextStyle(fontSize: 10, color: AppDesign.subtle),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _formatCompact(value),
                    style: const TextStyle(fontSize: 10, color: AppDesign.subtle),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: sortedVariances.asMap().entries.map((e) {
            final monthVars = e.value;
            final rods = <BarChartRodStackItem>[];
            double currentY = 0;

            for (int i = 0; i < topCategories.length; i++) {
              final catName = topCategories[i];
              final variance = monthVars.where((v) => v.category.name == catName).firstOrNull;
              final spent = variance?.spent ?? 0;
              if (spent > 0) {
                rods.add(BarChartRodStackItem(currentY, currentY + spent, colors[i]));
                currentY += spent;
              }
            }
            
            // Others
            final othersSpent = monthVars.where((v) => !topCategories.contains(v.category.name)).fold(0.0, (a, v) => a + v.spent);
            if (othersSpent > 0) {
              rods.add(BarChartRodStackItem(currentY, currentY + othersSpent, othersColor));
              currentY += othersSpent;
            }

            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: currentY,
                  width: 16,
                  borderRadius: BorderRadius.zero,
                  rodStackItems: rods,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatCompact(double value) {
    if (value >= 10000000) return '${(value / 10000000).toStringAsFixed(1)}Cr';
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(1)}L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  }
}
