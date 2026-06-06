import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/roadmap/roadmap_screen.dart';
import '../../presentation/screens/onboarding/budget_setup_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/insights/insights_screen.dart';
import '../../presentation/screens/ledger/ledger_screen.dart';
import '../../presentation/screens/budget_manager/budget_manager_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/transaction_form/transaction_form_screen.dart';
import '../../presentation/widgets/common/app_shell.dart';

// ── Route name constants ──────────────────────────────────────────────────

abstract class AppRoutes {
  static const String auth = '/auth';
  static const String onboarding = '/onboarding';
  static const String budgetSetup = '/budget-setup';
  static const String shell = '/';
  static const String dashboard = '/dashboard';
  static const String insights = '/insights';
  static const String roadmap = '/roadmap';
  static const String ledger = '/ledger';
  static const String budgetManager = '/caps';
  static const String settings = '/settings';
  static const String transactionForm = '/transaction';
}

// ── Router factory ────────────────────────────────────────────────────────

@singleton
class AppRouter {
  final AuthBloc _authBloc;

  AppRouter(this._authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.dashboard,
    refreshListenable: _GoRouterRefreshBloc(_authBloc.stream),
    redirect: (context, state) {
      final authState = _authBloc.state;
      final isAuthRoute = state.matchedLocation == AppRoutes.auth;
      final isOnboardingRoute =
          state.matchedLocation == AppRoutes.onboarding;
      final isBudgetSetupRoute =
          state.matchedLocation == AppRoutes.budgetSetup;

      return authState.maybeWhen(
        unauthenticated: () => isAuthRoute ? null : AppRoutes.auth,
        initial: () => isAuthRoute ? null : AppRoutes.auth,
        authenticated: (user) {
          if (isAuthRoute) {
            if (!user.onboardingComplete) return AppRoutes.onboarding;
            if (!user.budgetSetupComplete) return AppRoutes.budgetSetup;
            return AppRoutes.dashboard;
          }
          if (!user.onboardingComplete && !isOnboardingRoute) {
            return AppRoutes.onboarding;
          }
          if (user.onboardingComplete &&
              !user.budgetSetupComplete &&
              !isBudgetSetupRoute) {
            return AppRoutes.budgetSetup;
          }
          if (user.onboardingComplete &&
              user.budgetSetupComplete &&
              (isAuthRoute || isOnboardingRoute || isBudgetSetupRoute)) {
            return AppRoutes.dashboard;
          }
          return null;
        },
        orElse: () => null,
      );
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (_, __) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.budgetSetup,
        builder: (_, __) => const BudgetSetupScreen(),
      ),
      GoRoute(
        path: AppRoutes.transactionForm,
        builder: (_, state) => TransactionFormScreen(
          editId: state.uri.queryParameters['editId'],
        ),
      ),
      ShellRoute(
        builder: (_, __, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            builder: (_, __) => const DashboardScreen(),
          ),
          GoRoute(
            path: AppRoutes.insights,
            builder: (_, __) => const InsightsScreen(),
          ),
          GoRoute(
            path: AppRoutes.roadmap,
            builder: (_, __) => const RoadmapScreen(),
          ),
          GoRoute(
            path: AppRoutes.ledger,
            builder: (_, __) => const LedgerScreen(),
          ),
          GoRoute(
            path: AppRoutes.budgetManager,
            builder: (_, __) => const BudgetManagerScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}

// ── Listenable adapter to bridge BLoC stream → GoRouter refresh ───────────

class _GoRouterRefreshBloc extends ChangeNotifier {
  _GoRouterRefreshBloc(Stream stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  late final dynamic _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}


