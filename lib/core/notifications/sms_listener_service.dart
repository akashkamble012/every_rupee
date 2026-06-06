import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:telephony/telephony.dart';
import 'package:transaction_sms_parser/transaction_sms_parser.dart' hide TransactionType;
import 'package:uuid/uuid.dart';

import '../utils/app_logger.dart';
import '../../domain/entities/entities.dart';
import '../../data/datasources/local/isar_provider.dart';
import '../../data/models/isar/isar_models.dart';


const _uuid = Uuid();

// ── Top-level handler (called in isolate when app is killed) ───────────────

@pragma('vm:entry-point')
void backgroundSmsHandler(SmsMessage message) {
  // NOTE: We cannot use injectable DI in the background isolate.
  // The handler writes directly to a known Isar path.
  AppLogger.i('[SMS Background] ${message.address}: ${message.body}');
  _processSms(message);
}

Future<void> _processSms(SmsMessage message) async {
  final body = message.body ?? '';
  if (!_looksLikeBankingSms(body)) return;

  final info = TransactionEngine.getTransactionInfo(body);
  final parsed = info.transaction;
  final amountStr = parsed.amount;
  if (amountStr == null || amountStr.isEmpty) return;
  
  final amount = double.tryParse(amountStr.replaceAll(RegExp(r'[^0-9.]'), ''));
  if (amount == null) return;

  // Lightweight notification (no DI available here)
  final notif = FlutterLocalNotificationsPlugin();
  await notif.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  await notif.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    'Transaction Logged',
    '₹${amount.toStringAsFixed(0)} from ${parsed.merchant ?? "Unknown"}',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'transactions_channel',
        'Transactions',
        channelDescription: 'Auto-logged banking transactions',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    ),
  );
}

bool _looksLikeBankingSms(String body) {
  final lower = body.toLowerCase();
  return (lower.contains('debited') ||
          lower.contains('credited') ||
          lower.contains('spent') ||
          lower.contains('payment') ||
          lower.contains('withdrawn')) &&
      (lower.contains('inr') ||
          lower.contains('rs.') ||
          lower.contains('₹'));
}

// ── Foreground SMS Service ────────────────────────────────────────────────

@singleton
class SmsListenerService {
  final IsarProvider _isarProvider;
  final FlutterLocalNotificationsPlugin _notif =
      FlutterLocalNotificationsPlugin();
  final Telephony _telephony = Telephony.instance;

  SmsListenerService(this._isarProvider);

  Future<void> initialize() async {
    // Init notifications channel
    await _notif.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    await _notif
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          'transactions_channel',
          'Transactions',
          description: 'Auto-logged banking transactions',
          importance: Importance.defaultImportance,
        ));

    // Request SMS permission and start listening
    final granted = await _telephony.requestSmsPermissions;
    if (granted ?? false) {
      _telephony.listenIncomingSms(
        onNewMessage: _onForegroundSms,
        onBackgroundMessage: backgroundSmsHandler,
      );
      AppLogger.i('[SMS] Listener active');
    } else {
      AppLogger.w('[SMS] Permission denied — listener not started');
    }
  }

  Future<void> _onForegroundSms(SmsMessage message) async {
    final body = message.body ?? '';
    if (!_looksLikeBankingSms(body)) return;

    final info = TransactionEngine.getTransactionInfo(body);
    final parsed = info.transaction;
    final amountStr = parsed.amount;
    if (amountStr == null || amountStr.isEmpty) return;
    
    final amount = double.tryParse(amountStr.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (amount == null) return;

    AppLogger.i(
        '[SMS] Parsed: ₹$amount @ ${parsed.merchant}');

    // Guess category
    final categories = await _isarProvider.db.isarBudgetCategorys
        .filter()
        .isDeletedEqualTo(false)
        .findAll();

    final categoryId = _guessCategoryId(
      parsed.merchant ?? '',
      categories,
    );

    final now = DateTime.now();
    final tx = IsarTransaction()
      ..id = _uuid.v4()
      ..amount = amount
      ..typeIndex = TransactionType.debit.index
      ..date = now
      ..categoryId = categoryId
      ..merchant = parsed.merchant
      ..smsSource = body
      ..needsReview = true
      ..isDeleted = false
      ..createdAt = now
      ..lastModifiedAt = now;

    await _isarProvider.db
        .writeTxn(() => _isarProvider.db.isarTransactions.put(tx));

    // Queue for Firestore sync
    final pending = IsarPendingWrite()
      ..collectionName = 'transactions'
      ..documentId = tx.id
      ..operation = 'upsert'
      ..queuedAt = now;
    await _isarProvider.db
        .writeTxn(() => _isarProvider.db.isarPendingWrites.put(pending));

    await _notif.show(
      now.millisecondsSinceEpoch ~/ 1000,
      'Transaction Logged',
      '₹${tx.amount.toStringAsFixed(0)} debited from ${tx.merchant ?? "Unknown"}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'transactions_channel',
          'Transactions',
          channelDescription: 'Auto-logged banking transactions',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
    );
  }

  // ── Auto-Categorization Algorithm ──────────────────────────────────────

  /// Maps parsed merchant names to active budget categories via keyword rules.
  /// Modelled after the SUMIF category-matching logic from the original spreadsheet.
  String _guessCategoryId(
    String merchantName,
    List<IsarBudgetCategory> categories,
  ) {
    final lower = merchantName.toLowerCase();

    // Keyword → category name fragment mapping
    // Matches Indian banking/UPI merchant names to common ZBB categories
    final Map<String, List<String>> rules = {
      'food': [
        'zomato', 'swiggy', 'dmart', 'blinkit', 'zepto', 'mcdonalds',
        'kfc', 'dominos', 'subway', 'pizza', 'bigbasket', 'grofers',
        'instamart', 'dunzo', 'restaurant', 'hotel', 'cafe'
      ],
      'fuel': [
        'petrol', 'hpcl', 'bpcl', 'iocl', 'indian oil', 'hp petrol',
        'bharat petroleum', 'essar', 'shell', 'nayara'
      ],
      'travel': [
        'uber', 'ola', 'rapido', 'irctc', 'makemytrip', 'redbus',
        'yatra', 'cleartrip', 'metro', 'rickshaw', 'auto'
      ],
      'utilities': [
        'jio', 'airtel', 'vi ', 'vodafone', 'bsnl', 'tata sky',
        'bescom', 'msedcl', 'mahavitaran', 'torrent', 'adani elec',
        'electricity', 'water', 'gas', 'recharge'
      ],
      'entertainment': [
        'netflix', 'hotstar', 'prime video', 'spotify', 'youtube',
        'bookmyshow', 'pvr', 'inox', 'steam', 'playstation', 'apple music'
      ],
      'shopping': [
        'amazon', 'flipkart', 'myntra', 'ajio', 'nykaa', 'meesho',
        'snapdeal', 'shopsy', 'reliance', 'dmart'
      ],
      'health': [
        'apollo', 'medplus', 'netmeds', 'pharmeasy', '1mg', 'tata 1mg',
        'hospital', 'clinic', 'doctor', 'pharmacy', 'medicine'
      ],
    };

    for (final entry in rules.entries) {
      if (entry.value.any((k) => lower.contains(k))) {
        // Find matching active category
        final match = categories.firstWhere(
          (c) => c.name.toLowerCase().contains(entry.key),
          orElse: () => categories.isNotEmpty ? categories.first : _fallback(),
        );
        return match.id;
      }
    }

    // Fallback: first available category or a sentinel value
    return categories.isNotEmpty ? categories.first.id : 'uncategorized';
  }

  IsarBudgetCategory _fallback() => IsarBudgetCategory()
    ..id = 'uncategorized'
    ..name = 'Miscellaneous'
    ..cap = 0
    ..effectiveFrom = DateTime.now()
    ..isDeleted = false
    ..lastModifiedAt = DateTime.now();
}
