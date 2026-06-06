import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_design.dart';
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
        _ChartCard(
          title: 'Payment Method Breakdown',
          child: PaymentMethodChart(transactions: List.from(transactions)),
        ),
        const SizedBox(height: 100), // padding for bottom nav
      ],
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
