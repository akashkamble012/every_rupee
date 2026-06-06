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
import '../../blocs/insights/insights_bloc.dart';
import '../../blocs/roadmap/roadmap_bloc.dart';
import 'tabs/overview_tab.dart';
import 'tabs/charts_tab.dart';
import 'tabs/roadmap_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardBloc _dashboardBloc;
  late final InsightsBloc _insightsBloc;
  late final RoadmapBloc _roadmapBloc;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, 1);
    
    _dashboardBloc = getIt<DashboardBloc>()..add(DashboardEvent.load(currentMonth));
    _insightsBloc = getIt<InsightsBloc>()..add(InsightsEvent.load(currentMonth));
    _roadmapBloc = getIt<RoadmapBloc>()..add(const RoadmapEvent.load());
  }

  @override
  void dispose() {
    _dashboardBloc.close();
    _insightsBloc.close();
    _roadmapBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _dashboardBloc),
        BlocProvider.value(value: _insightsBloc),
        BlocProvider.value(value: _roadmapBloc),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppDesign.background,
          appBar: AppBar(
            title: Text('Dashboard', style: AppDesign.headlineMedium),
            centerTitle: false,
            elevation: 0,
            backgroundColor: AppDesign.background,
            bottom: const TabBar(
              labelColor: AppDesign.primary,
              unselectedLabelColor: AppDesign.subtle,
              indicatorColor: AppDesign.primary,
              dividerColor: AppDesign.divider,
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Charts'),
                Tab(text: 'Roadmap'),
              ],
            ),
          ),
          body: const SafeArea(
            child: TabBarView(
              children: [
                _OverviewBuilder(),
                DashboardChartsTab(),
                DashboardRoadmapTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OverviewBuilder extends StatelessWidget {
  const _OverviewBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final bloc = context.read<DashboardBloc>();

        return state.when(
          initial: () => const Center(child: CircularProgressIndicator(color: AppDesign.primary)),
          loading: () => const Center(child: CircularProgressIndicator(color: AppDesign.primary)),
          failure: (message) => Center(child: Text(message, style: AppDesign.bodyMedium.copyWith(color: AppDesign.error))),
          loaded: (month, surplus, variances, recentTransactions, pendingTransactions,
                  wealthHistory, historicalVariances, sortPreference, txSortPref, visibleCharts) =>
              DashboardOverviewTab(
            month: month,
            surplus: surplus,
            variances: variances,
            recentTransactions: recentTransactions,
            pendingTransactions: pendingTransactions,
            sortPreference: sortPreference,
            txSortPref: txSortPref,
            onPrev: () => bloc.add(const DashboardEvent.previousMonth()),
            onNext: () => bloc.add(const DashboardEvent.nextMonth()),
          ),
        );
      },
    );
  }
}

