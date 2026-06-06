import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
import '../../../core/utils/formatters.dart';
import '../../../domain/entities/entities.dart';
import '../../blocs/insights/insights_bloc.dart';
import '../../widgets/charts/insights_charts.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  late final InsightsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<InsightsBloc>();
    _bloc.add(InsightsEvent.load(DateTime(DateTime.now().year, DateTime.now().month, 1)));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Insights', style: AppDesign.headlineMedium),
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppDesign.background,
        ),
        body: BlocBuilder<InsightsBloc, InsightsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (msg) => Center(child: Text(msg, style: const TextStyle(color: AppDesign.error))),
              loaded: (month, txs, wealth, variances) => _LoadedBody(
                month: month,
                transactions: txs,
                wealthHistory: wealth,
                historicalVariances: variances,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  final DateTime month;
  final List<dynamic> transactions;
  final List<dynamic> wealthHistory;
  final List<dynamic> historicalVariances;

  const _LoadedBody({
    required this.month,
    required this.transactions,
    required this.wealthHistory,
    required this.historicalVariances,
  });

  List<Map<String, dynamic>> _calculateMoM() {
    if (historicalVariances.length < 2) return [];
    
    final currentVariances = historicalVariances.last as List<CategoryVarianceEntity>;
    final prevVariances = historicalVariances[historicalVariances.length - 2] as List<CategoryVarianceEntity>;
    
    final List<Map<String, dynamic>> momChanges = [];
    
    for (var cv in currentVariances) {
      final pv = prevVariances.where((v) => v.category.id == cv.category.id).firstOrNull;
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
    return momChanges.take(5).toList(); // top 5 changes
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDesign.s16),
      children: [
        _ChartCard(
          title: 'Wealth & Savings Trend (Last 6 Months)',
          child: WealthTrendChart(wealthHistory: List.from(wealthHistory)),
        ),
        const SizedBox(height: AppDesign.s16),
        _ChartCard(
          title: 'Income vs. Expenses (Last 6 Months)',
          child: IncomeExpenseChart(wealthHistory: List.from(wealthHistory)),
        ),
        const SizedBox(height: AppDesign.s16),
        _ChartCard(
          title: 'Top Categories Spent (Last 6 Months)',
          child: CategorySpendingChart(
            historicalVariances: List.from(historicalVariances),
            wealthHistory: List.from(wealthHistory),
          ),
        ),
        const SizedBox(height: AppDesign.s16),
        _ChartCard(
          title: 'Daily Spend Velocity (Current Month)',
          child: DailySpendChart(transactions: List.from(transactions), month: month),
        ),
        const SizedBox(height: AppDesign.s16),
        const SizedBox(height: AppDesign.s16),
        _ChartCard(
          title: 'Payment Method Breakdown',
          child: PaymentMethodChart(transactions: List.from(transactions)),
        ),
        const SizedBox(height: AppDesign.s16),
        _buildMoMSection(),
        const SizedBox(height: 100), // padding for bottom nav
      ],
    );
  }

  Widget _buildMoMSection() {
    final momChanges = _calculateMoM();
    if (momChanges.isEmpty) return const SizedBox.shrink();

    return _ChartCard(
      title: 'Month-over-Month Biggest Changes',
      child: Column(
        children: momChanges.map((change) {
          final isIncrease = (change['diff'] as double) > 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDesign.s8),
            child: Row(
              children: [
                Icon(
                  change['iconCode'] != null 
                    ? IconData(int.parse(change['iconCode']), fontFamily: 'MaterialIcons') 
                    : Icons.category_rounded,
                  color: AppDesign.subtle,
                  size: 20,
                ),
                const SizedBox(width: AppDesign.s12),
                Expanded(
                  child: Text(change['category'], style: AppDesign.bodyMedium),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isIncrease ? '+' : ''}${formatINR(change['diff'])}',
                      style: AppDesign.labelLarge.copyWith(
                        color: isIncrease ? AppDesign.error : AppDesign.success,
                      ),
                    ),
                    Text(
                      '${isIncrease ? '+' : ''}${(change['percent'] as double).toStringAsFixed(1)}%',
                      style: AppDesign.bodySmall.copyWith(color: AppDesign.subtle),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
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
