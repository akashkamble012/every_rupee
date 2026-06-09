import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../core/di/injection.dart';
import '../core/utils/app_logger.dart';
import '../data/datasources/local/isar_provider.dart';
import '../data/models/isar/isar_models.dart';
import '../domain/entities/entities.dart';

Future<void> importMockData() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('hasImportedMockDataV4') == true) return;

  final db = getIt<IsarProvider>().db;

  // Clear previous transactions so we can do a clean import
  await db.writeTxn(() async {
    await db.isarTransactions.clear();
    await db.isarPendingWrites.clear();
  });

  const rawData = '''
01-06-2026	Fan EMI Foreclosure	Savings / Special Fund	UPI	₹3,774
01-06-2026	IDFC Card EMI 2/6	IDFC Card EMI	UPI	₹10,902
01-06-2026	HDFC Card Bill Payment	Living & Food (Groceries/Fuel)	UPI	₹9,722
01-06-2026	Badlapur Electricity Bill	Badlapur Electricity Bill	UPI	₹3,220
01-06-2026	Wedding Photography Bill	Savings / Special Fund	UPI	₹7,000
01-06-2026	Sancks	Living & Food (Groceries/Fuel)	UPI	₹38
01-06-2026	Ice Cream	Living & Food (Groceries/Fuel)	UPI	₹505
02-06-2026	Tea and Water	Living & Food (Groceries/Fuel)	UPI	₹22
02-06-2026	Jio Recharge	Utilities & Wi-Fi	UPI	₹349
02-06-2026	Office breakfast	Living & Food (Groceries/Fuel)	UPI	₹45
02-06-2026	Pizza 	Living & Food (Groceries/Fuel)	UPI	₹169
02-06-2026	Lenskart Gold Membership	Utilities & Wi-Fi	UPI	₹49
02-06-2026	Salon	Living & Food (Groceries/Fuel)	UPI	₹150
03-06-2026	Office breakfast	Living & Food (Groceries/Fuel)	UPI	₹40
03-06-2026	Airoli Snacks	Living & Food (Groceries/Fuel)	UPI	₹80
03-06-2026	Vegetables	Living & Food (Groceries/Fuel)	UPI	₹105
03-06-2026	Fruits	Living & Food (Groceries/Fuel)	UPI	₹100
03-06-2026	Vegetables	Living & Food (Groceries/Fuel)	UPI	₹35
03-06-2026	Coconut Water	Living & Food (Groceries/Fuel)	UPI	₹80
03-06-2026	Curd	Living & Food (Groceries/Fuel)	UPI	₹50
03-06-2026	Chicken and Rice	Living & Food (Groceries/Fuel)	UPI	₹247
03-06-2026	Water Can	Living & Food (Groceries/Fuel)	UPI	₹50
04-06-2026	Snack (McD)	Living & Food (Groceries/Fuel)	UPI	₹336
04-06-2026	Oil and milk	Living & Food (Groceries/Fuel)	UPI	₹385
04-06-2026	ponds	Living & Food (Groceries/Fuel)	UPI	₹10
05-06-2026	Office breakfast 	Living & Food (Groceries/Fuel)	UPI	₹40
05-06-2026	Biscuit 	Living & Food (Groceries/Fuel)	UPI	₹10
05-06-2026	Fuel	Living & Food (Groceries/Fuel)	UPI	₹200
05-06-2026	Clothes 	Living & Food (Groceries/Fuel)	UPI	₹750
05-06-2026	Clothes 	Living & Food (Groceries/Fuel)	UPI	₹350
05-06-2026	Dinner 	Living & Food (Groceries/Fuel)	UPI	₹544
05-06-2026	Eggs	Living & Food (Groceries/Fuel)	UPI	₹39
06-06-2026	Bike repair 	Living & Food (Groceries/Fuel)	UPI	₹10
06-06-2026	Vegetable (pudeena)	Living & Food (Groceries/Fuel)	UPI	₹300
06-06-2026	Chicken	Living & Food (Groceries/Fuel)	UPI	₹20
06-06-2026	Chicken 	Living & Food (Groceries/Fuel)	UPI	₹120
06-06-2026	Sprite	Living & Food (Groceries/Fuel)	UPI	₹20
06-06-2026	Snacks 	Living & Food (Groceries/Fuel)	UPI	₹25
06-06-2026	Snacks zepto 	Living & Food (Groceries/Fuel)	UPI	₹112
06-06-2026	Vegetable (neembu)	Living & Food (Groceries/Fuel)	UPI	₹20
07-06-2026	Bike Repair (front guard cardboard)	Living & Food (Groceries/Fuel)	UPI	₹50
07-06-2026	Rent	Rent	UPI	₹12,300
07-06-2026	Electricity  Bill	Utilities & Wi-Fi	UPI	₹1,460
''';

  final lines = rawData.trim().split('\n');
  const uuid = Uuid();
  final dateFormatter = DateFormat('dd-MM-yyyy');

  final existingCats =
      await db.isarBudgetCategorys.filter().isDeletedEqualTo(false).findAll();
  final fallbackCatId =
      existingCats.isNotEmpty ? existingCats.first.id : 'uncategorized';

  final txsToInsert = <IsarTransaction>[];
  final pendingWrites = <IsarPendingWrite>[];

  for (final line in lines) {
    if (line.trim().isEmpty) continue;
    final parts = line.split('\t');
    if (parts.length < 5) continue;

    final dateStr = parts[0].trim();
    final merchant = parts[1].trim();
    final catName = parts[2].trim();
    final sourceStr = parts[3].trim().toLowerCase();
    final amountStr = parts[4].replaceAll('₹', '').replaceAll(',', '').trim();
    final amount = double.tryParse(amountStr) ?? 0.0;

    int? paymentModeIndex;
    if (sourceStr.contains('upi')) {
      paymentModeIndex = PaymentMode.upi.index;
    } else if (sourceStr.contains('card')) {
      paymentModeIndex = PaymentMode.card.index;
    } else if (sourceStr.contains('cash')) {
      paymentModeIndex = PaymentMode.cash.index;
    } else if (sourceStr.contains('net')) {
      paymentModeIndex = PaymentMode.netBanking.index;
    } else {
      paymentModeIndex = PaymentMode.other.index;
    }

    DateTime date;
    try {
      date = dateFormatter.parse(dateStr);
    } catch (e) {
      date = DateTime.now();
    }

    String matchedCatId = fallbackCatId;
    if (catName.toLowerCase().contains('saving')) {
      matchedCatId = systemSavingsCategoryId;
    } else {
      for (final cat in existingCats) {
        if (cat.name.toLowerCase() == catName.toLowerCase()) {
          matchedCatId = cat.id;
          break;
        }
      }
    }

    final txId = uuid.v4();
    final now = DateTime.now();
    final tx = IsarTransaction()
      ..id = txId
      ..amount = amount
      ..typeIndex = TransactionType.debit.index
      ..date = date
      ..categoryId = matchedCatId
      ..merchant = merchant
      ..paymentModeIndex = paymentModeIndex
      ..isDeleted = false
      ..needsReview = false
      ..createdAt = now
      ..lastModifiedAt = now;

    txsToInsert.add(tx);

    pendingWrites.add(IsarPendingWrite()
      ..collectionName = 'transactions'
      ..documentId = txId
      ..operation = 'upsert'
      ..queuedAt = now);
  }

  await db.writeTxn(() async {
    await db.isarTransactions.putAll(txsToInsert);
    await db.isarPendingWrites.putAll(pendingWrites);
  });

  AppLogger.i('Successfully imported ${txsToInsert.length} mock transactions');
  await prefs.setBool('hasImportedMockDataV4', true);
}
