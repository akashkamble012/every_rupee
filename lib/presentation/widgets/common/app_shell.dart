import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_design.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _tabs = [
    AppRoutes.dashboard,
    AppRoutes.ledger,
    AppRoutes.budgetManager,
    AppRoutes.settings,
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _tabs.indexWhere((t) => location.startsWith(t));
    final safeIndex = currentIndex < 0 ? 0 : currentIndex;

    return Scaffold(
      body: child,
      floatingActionButton: _shouldShowFAB(location)
          ? FloatingActionButton(
              heroTag: 'add_tx_fab',
              onPressed: () => context.push(AppRoutes.transactionForm),
              child: const Icon(Icons.add_rounded, size: 28),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _AppBottomNav(
        currentIndex: safeIndex,
        onTap: (i) => context.go(_tabs[i]),
      ),
    );
  }

  bool _shouldShowFAB(String location) =>
      location == AppRoutes.dashboard || location == AppRoutes.ledger;
}

class _AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _AppBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppDesign.surface,
        border: const Border(
            top: BorderSide(color: AppDesign.divider, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          labelBehavior:
              NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: AppDesign.primary.withOpacity(0.15),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon:
                  Icon(Icons.dashboard_rounded, color: AppDesign.primary),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long_rounded,
                  color: AppDesign.primary),
              label: 'Ledger',
            ),
            NavigationDestination(
              icon: Icon(Icons.pie_chart_outline_rounded),
              selectedIcon: Icon(Icons.pie_chart_rounded,
                  color: AppDesign.primary),
              label: 'Caps',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings_rounded,
                  color: AppDesign.primary),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
