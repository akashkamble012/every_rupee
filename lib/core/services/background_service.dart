import 'package:workmanager/workmanager.dart';
import 'package:zb_budget/core/services/home_widget_service.dart';
import 'package:zb_budget/core/di/injection.dart';
import 'package:zb_budget/domain/repositories/repositories.dart';

import '../../domain/entities/entities.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'updateHomeWidget') {
      try {
        await configureDependencies(); // Might need a lighter initialization for background
        final transactionRepo = getIt<TransactionRepository>();
        // Note: For background tasks we might need to initialize Isar first
        // In a real app we'd handle background Isar initialization carefully.

        final result =
            await transactionRepo.getTransactionsPaged(offset: 0, limit: 5);

        if (result.isOk) {
          final transactions = List<TransactionEntity>.from(result.value);
          transactions.sort((a, b) => b.date.compareTo(a.date));

          await HomeWidgetService.initialize(null);
          await HomeWidgetService.updateRecentTransactions(
              transactions.take(5).toList());
        }
      } catch (e) {
        print('Background task error: $e');
      }
    }
    return Future.value(true);
  });
}

class BackgroundService {
  static Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
    );

    await Workmanager().registerPeriodicTask(
      'widget-update',
      'updateHomeWidget',
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.notRequired,
      ),
    );
  }
}
