import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zb_budget/core/utils/app_logger.dart';

import 'core/di/injection.dart';
import 'core/notifications/sms_listener_service.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_design.dart';
import 'data/datasources/local/isar_provider.dart';
import 'data/datasources/remote/firestore_sync_service.dart';
import 'domain/repositories/repositories.dart';
import 'core/providers/app_providers.dart';
import 'presentation/widgets/auth/app_lock_guard.dart';
import 'core/services/home_widget_service.dart';
import 'core/services/background_service.dart';
import 'package:go_router/go_router.dart';

/// Called from main(). Initialises Firebase, Isar, DI, SMS listener, and
/// then mounts the root Flutter widget.
Future<void> bootstrap() async {
  // 1. Firebase
  await Firebase.initializeApp();

  // 2. Dependency Injection
  await configureDependencies();

  // 3. Isar database
  await getIt<IsarProvider>().init();

  // 3.1 Initialize Widget services
  await BackgroundService.initialize();

  // 4. SMS listener (Android only; safe no-op on iOS)
  await getIt<SmsListenerService>().initialize();

  // 5. Start background sync when connectivity returns
  final auth = getIt<AuthRepository>();
  final user = auth.currentUser;
  if (user != null) {
    getIt<FirestoreSyncService>().startListening(user.uid);
  }
  auth.authStateChanges.listen((u) {
    if (u != null) {
      getIt<FirestoreSyncService>().startListening(u.uid);
    }
  });

  runApp(const EveryRupeeApp());
}

class EveryRupeeApp extends StatefulWidget {
  const EveryRupeeApp({super.key});

  @override
  State<EveryRupeeApp> createState() => _EveryRupeeAppState();
}

class _EveryRupeeAppState extends State<EveryRupeeApp> {
  @override
  void initState() {
    super.initState();
    HomeWidgetService.initialize((uri, isColdStart) {
      AppLogger.w('Deep Link URL RECEIVED : ${uri.toString()} | Cold Start: $isColdStart');
      if (uri.host == 'add_transaction' ||
          uri.path.contains('add_transaction')) {
        if (isColdStart) {
          // Cold start: Store it for the Dashboard to push AFTER shell is ready.
          AppRouter.pendingDeepLink = AppRoutes.transactionForm;
        } else {
          // Warm start: GoRouter is already ready on some page. Push directly.
          getIt<AppRouter>().router.push(AppRoutes.transactionForm);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Builder(
        builder: (context) {
          final router = getIt<AppRouter>().router;
          return MaterialApp.router(
            title: 'Every Rupee',
            debugShowCheckedModeBanner: false,
            theme: AppDesign.darkTheme,
            routerConfig: router,
            builder: (context, child) {
              return AppLockGuard(
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
