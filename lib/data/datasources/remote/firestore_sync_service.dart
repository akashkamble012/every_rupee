import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../../../core/error/app_error.dart';
import '../../../core/utils/app_logger.dart';
import '../../../domain/repositories/repositories.dart';
import '../../models/isar/isar_models.dart';
import '../local/isar_provider.dart';

@singleton
class FirestoreSyncService {
  final IsarProvider _isarProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();

  final _statusController =
      StreamController<SyncStatus>.broadcast();
  StreamSubscription? _connectivitySub;

  FirestoreSyncService(this._isarProvider);

  Stream<SyncStatus> get statusStream => _statusController.stream;

  /// Call once after Isar is initialized to start background sync on connectivity
  void startListening(String userId) {
    _connectivitySub?.cancel();
    _connectivitySub =
        _connectivity.onConnectivityChanged.listen((results) {
      if (results.any((r) => r != ConnectivityResult.none)) {
        AppLogger.i('[Sync] Connection detected — initiating sync');
        syncAll(userId);
      }
    });
  }

  void stopListening() {
    _connectivitySub?.cancel();
    _statusController.close();
  }

  Future<void> syncAll(String userId) async {
    _statusController.add(SyncStatus.syncing);
    try {
      await pushPendingWrites(userId);
      await pullRemoteChanges(userId);
      _statusController.add(SyncStatus.success);
    } catch (e, st) {
      AppLogger.e('[Sync] Failed', error: e, stackTrace: st);
      _statusController.add(SyncStatus.failure);
    }
  }

  // ── PUSH: local pending → Firestore ──────────────────────────────────────

  Future<void> pushPendingWrites(String userId) async {
    final db = _isarProvider.db;
    final pending = await db.isarPendingWrites.where().findAll();
    if (pending.isEmpty) return;

    AppLogger.i('[Sync] Pushing ${pending.length} pending writes');
    final batch = _firestore.batch();

    for (final p in pending) {
      final colRef = _firestore
          .collection('users')
          .doc(userId)
          .collection(p.collectionName);

      if (p.operation == 'delete') {
        batch.update(colRef.doc(p.documentId), {'isDeleted': true});
      } else {
        // upsert: fetch local record and write to Firestore
        final data = await _getLocalDocument(p.collectionName, p.documentId);
        if (data != null) {
          batch.set(colRef.doc(p.documentId), data, SetOptions(merge: true));
        }
      }
    }

    await batch.commit();

    // Clear the queue
    await db.writeTxn(() => db.isarPendingWrites.clear());
    AppLogger.i('[Sync] Push complete');
  }

  // ── PULL: Firestore → Isar (Last Write Wins on lastModifiedAt) ────────────

  Future<void> pullRemoteChanges(String userId) async {
    final db = _isarProvider.db;
    final userDoc = _firestore.collection('users').doc(userId);

    // ── Transactions ───────────────────────────────────────────────────────
    final txSnap = await userDoc.collection('transactions').get();
    for (final doc in txSnap.docs) {
      final d = doc.data();
      final remoteModified =
          (d['lastModifiedAt'] as Timestamp?)?.toDate() ?? DateTime(2000);
      final existing =
          await db.isarTransactions.filter().idEqualTo(doc.id).findFirst();
      if (existing == null ||
          remoteModified.isAfter(existing.lastModifiedAt)) {
        final model = IsarTransaction()
          ..id = doc.id
          ..amount = (d['amount'] as num).toDouble()
          ..typeIndex = d['typeIndex'] as int
          ..date = (d['date'] as Timestamp).toDate()
          ..categoryId = d['categoryId'] as String
          ..merchant = d['merchant'] as String?
          ..paymentModeIndex = d['paymentModeIndex'] as int?
          ..note = d['note'] as String?
          ..isDeleted = d['isDeleted'] as bool? ?? false
          ..createdAt = (d['createdAt'] as Timestamp?)?.toDate() ??
              DateTime.now()
          ..lastModifiedAt = remoteModified;
        await db.writeTxn(() => db.isarTransactions.put(model));
      }
    }

    // ── Categories ─────────────────────────────────────────────────────────
    final catSnap = await userDoc.collection('categories').get();
    for (final doc in catSnap.docs) {
      final d = doc.data();
      final remoteModified =
          (d['lastModifiedAt'] as Timestamp?)?.toDate() ?? DateTime(2000);
      final existing =
          await db.isarBudgetCategorys.filter().idEqualTo(doc.id).findFirst();
      if (existing == null ||
          remoteModified.isAfter(existing.lastModifiedAt)) {
        final model = IsarBudgetCategory()
          ..id = doc.id
          ..name = d['name'] as String
          ..cap = (d['cap'] as num).toDouble()
          ..effectiveFrom =
              (d['effectiveFrom'] as Timestamp).toDate()
          ..activeUntil = (d['activeUntil'] as Timestamp?)?.toDate()
          ..iconCode = d['iconCode'] as String?
          ..isDeleted = d['isDeleted'] as bool? ?? false
          ..lastModifiedAt = remoteModified;
        await db
            .writeTxn(() => db.isarBudgetCategorys.put(model));
      }
    }

    // ── Income sources ─────────────────────────────────────────────────────
    final incSnap = await userDoc.collection('incomeSources').get();
    for (final doc in incSnap.docs) {
      final d = doc.data();
      final remoteModified =
          (d['lastModifiedAt'] as Timestamp?)?.toDate() ?? DateTime(2000);
      final existing =
          await db.isarIncomeSources.filter().idEqualTo(doc.id).findFirst();
      if (existing == null ||
          remoteModified.isAfter(existing.lastModifiedAt)) {
        final model = IsarIncomeSource()
          ..id = doc.id
          ..name = d['name'] as String
          ..amount = (d['amount'] as num).toDouble()
          ..effectiveFrom =
              (d['effectiveFrom'] as Timestamp).toDate()
          ..effectiveUntil =
              (d['effectiveUntil'] as Timestamp?)?.toDate()
          ..isDeleted = d['isDeleted'] as bool? ?? false
          ..lastModifiedAt = remoteModified;
        await db.writeTxn(() => db.isarIncomeSources.put(model));
      }
    }

    // ── Temporary Outflows ─────────────────────────────────────────────────
    final outSnap = await userDoc.collection('temporaryOutflows').get();
    for (final doc in outSnap.docs) {
      final d = doc.data();
      final remoteModified =
          (d['lastModifiedAt'] as Timestamp?)?.toDate() ?? DateTime(2000);
      final existing =
          await db.isarTemporaryOutflows.filter().idEqualTo(doc.id).findFirst();
      if (existing == null ||
          remoteModified.isAfter(existing.lastModifiedAt)) {
        final model = IsarTemporaryOutflow()
          ..id = doc.id
          ..name = d['name'] as String
          ..amount = (d['amount'] as num).toDouble()
          ..startMonth = (d['startMonth'] as Timestamp).toDate()
          ..endMonth = (d['endMonth'] as Timestamp).toDate()
          ..isDeleted = d['isDeleted'] as bool? ?? false
          ..lastModifiedAt = remoteModified;
        await db.writeTxn(() => db.isarTemporaryOutflows.put(model));
      }
    }

    // ── Roadmap Months ─────────────────────────────────────────────────────
    final rmSnap = await userDoc.collection('roadmapMonths').get();
    for (final doc in rmSnap.docs) {
      final d = doc.data();
      final remoteModified =
          (d['lastModifiedAt'] as Timestamp?)?.toDate() ?? DateTime(2000);
      final existing =
          await db.isarRoadmapMonths.filter().idEqualTo(doc.id).findFirst();
      if (existing == null ||
          remoteModified.isAfter(existing.lastModifiedAt)) {
        final model = IsarRoadmapMonth()
          ..id = doc.id
          ..month = (d['month'] as Timestamp).toDate()
          ..netIncomeOverride = (d['netIncomeOverride'] as num?)?.toDouble()
          ..coreFixedExpensesOverride = (d['coreFixedExpensesOverride'] as num?)?.toDouble()
          ..actionPlan = d['actionPlan'] as String?
          ..isDeleted = d['isDeleted'] as bool? ?? false
          ..lastModifiedAt = remoteModified;
        await db.writeTxn(() => db.isarRoadmapMonths.put(model));
      }
    }

    AppLogger.i('[Sync] Pull complete');
  }

  // ── Local document serializer ─────────────────────────────────────────────

  Future<Map<String, dynamic>?> _getLocalDocument(
      String collection, String id) async {
    final db = _isarProvider.db;
    switch (collection) {
      case 'transactions':
        final t = await db.isarTransactions.filter().idEqualTo(id).findFirst();
        if (t == null) return null;
        return {
          'id': t.id,
          'amount': t.amount,
          'typeIndex': t.typeIndex,
          'date': Timestamp.fromDate(t.date),
          'categoryId': t.categoryId,
          'merchant': t.merchant,
          'paymentModeIndex': t.paymentModeIndex,
          'note': t.note,
          'isDeleted': t.isDeleted,
          'createdAt': Timestamp.fromDate(t.createdAt),
          'lastModifiedAt': Timestamp.fromDate(t.lastModifiedAt),
        };
      case 'categories':
        final c = await db.isarBudgetCategorys.filter().idEqualTo(id).findFirst();
        if (c == null) return null;
        return {
          'id': c.id,
          'name': c.name,
          'cap': c.cap,
          'effectiveFrom': Timestamp.fromDate(c.effectiveFrom),
          'activeUntil':
              c.activeUntil != null ? Timestamp.fromDate(c.activeUntil!) : null,
          'iconCode': c.iconCode,
          'isDeleted': c.isDeleted,
          'lastModifiedAt': Timestamp.fromDate(c.lastModifiedAt),
        };
      case 'incomeSources':
        final s = await db.isarIncomeSources.filter().idEqualTo(id).findFirst();
        if (s == null) return null;
        return {
          'id': s.id,
          'name': s.name,
          'amount': s.amount,
          'effectiveFrom': Timestamp.fromDate(s.effectiveFrom),
          'effectiveUntil': s.effectiveUntil != null
              ? Timestamp.fromDate(s.effectiveUntil!)
              : null,
          'isDeleted': s.isDeleted,
          'lastModifiedAt': Timestamp.fromDate(s.lastModifiedAt),
        };
      case 'temporaryOutflows':
        final o = await db.isarTemporaryOutflows.filter().idEqualTo(id).findFirst();
        if (o == null) return null;
        return {
          'id': o.id,
          'name': o.name,
          'amount': o.amount,
          'startMonth': Timestamp.fromDate(o.startMonth),
          'endMonth': Timestamp.fromDate(o.endMonth),
          'isDeleted': o.isDeleted,
          'lastModifiedAt': Timestamp.fromDate(o.lastModifiedAt),
        };
      case 'roadmapMonths':
        final r = await db.isarRoadmapMonths.filter().idEqualTo(id).findFirst();
        if (r == null) return null;
        return {
          'id': r.id,
          'month': Timestamp.fromDate(r.month),
          'netIncomeOverride': r.netIncomeOverride,
          'coreFixedExpensesOverride': r.coreFixedExpensesOverride,
          'actionPlan': r.actionPlan,
          'isDeleted': r.isDeleted,
          'lastModifiedAt': Timestamp.fromDate(r.lastModifiedAt),
        };
      default:
        return null;
    }
  }
}

// ── Repository Impl ───────────────────────────────────────────────────────

@Injectable(as: SyncRepository)
class SyncRepositoryImpl implements SyncRepository {
  final FirestoreSyncService _service;
  final AuthRepository _authRepo;

  SyncRepositoryImpl(this._service, this._authRepo);

  @override
  Stream<SyncStatus> get syncStatusStream => _service.statusStream;

  @override
  Future<Result<void>> pushPendingWrites() async {
    final uid = _authRepo.currentUser?.uid;
    if (uid == null) return const Err(AppError.auth(message: 'Not authenticated'));
    try {
      await _service.pushPendingWrites(uid);
      return const Ok(null);
    } catch (e) {
      return Err(AppError.sync(message: 'Push failed', original: e));
    }
  }

  @override
  Future<Result<void>> pullRemoteChanges() async {
    final uid = _authRepo.currentUser?.uid;
    if (uid == null) return const Err(AppError.auth(message: 'Not authenticated'));
    try {
      await _service.pullRemoteChanges(uid);
      return const Ok(null);
    } catch (e) {
      return Err(AppError.sync(message: 'Pull failed', original: e));
    }
  }
}
