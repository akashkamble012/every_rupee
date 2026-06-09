import 'dart:convert';
import 'package:home_widget/home_widget.dart';
import 'package:zb_budget/domain/entities/entities.dart';

class HomeWidgetService {
  static const String _appGroupId = 'group.com.example.zb_budget'; // For iOS if ever needed, but for Android it uses default SharedPreferences
  static const String _widgetName = 'BudgetWidgetProvider';

  static Future<void> initialize(void Function(Uri uri, bool isColdStart)? onWidgetClicked) async {
    await HomeWidget.setAppGroupId(_appGroupId);
    
    // Check if app was launched from a widget (Cold Start)
    final uri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (uri != null && onWidgetClicked != null) {
      onWidgetClicked(uri, true);
    }
    
    // Listen for widget clicks while app is open (Warm Start)
    HomeWidget.widgetClicked.listen((uri) {
      if (uri != null && onWidgetClicked != null) {
        onWidgetClicked(uri, false);
      }
    });
  }

  static Future<void> updateRecentTransactions(List<TransactionEntity> transactions) async {
    try {
      final List<Map<String, dynamic>> transactionsJson = transactions.take(5).map((t) => {
        'id': t.id,
        'amount': t.amount,
        'type': t.type.name,
        'merchant': t.merchant ?? 'Unknown',
        'date': t.date.toIso8601String(),
      }).toList();

      final String jsonString = jsonEncode(transactionsJson);

      await HomeWidget.saveWidgetData<String>('recent_transactions', jsonString);
      await HomeWidget.updateWidget(
        androidName: _widgetName,
      );
    } catch (e) {
      print('Error updating widget data: $e');
    }
  }
}
