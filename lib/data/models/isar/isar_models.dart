import 'package:isar/isar.dart';

// export 'budget_category_isar.dart';
// export 'income_source_isar.dart';
// export 'roadmap_month_isar.dart';
// export 'temporary_outflow_isar.dart';
// export 'isar_pending_write.dart';

part 'isar_models.g.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Transaction
// ═══════════════════════════════════════════════════════════════════════════

@collection
class IsarTransaction {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  late String id;

  late double amount;

  @Index()
  late int typeIndex; // 0=debit, 1=credit

  @Index()
  late DateTime date;

  @Index()
  late String categoryId;

  String? merchant;
  int? paymentModeIndex;
  String? note;
  String? smsSource;
  
  @Index()
  bool needsReview = false;

  @Index()
  bool isRecurring = false;

  List<String> tags = [];

  @Index()
  late bool isDeleted;

  late DateTime createdAt;
  late DateTime lastModifiedAt;
}

// ═══════════════════════════════════════════════════════════════════════════
// Budget Category
// ═══════════════════════════════════════════════════════════════════════════

@collection
class IsarBudgetCategory {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  late String id;

  late String name;
  late double cap;
  late DateTime effectiveFrom;
  DateTime? activeUntil;
  String? iconCode;
  late bool isDeleted;
  late DateTime lastModifiedAt;
}

// ═══════════════════════════════════════════════════════════════════════════
// Income Source
// ═══════════════════════════════════════════════════════════════════════════

@collection
class IsarIncomeSource {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  late String id;

  late String name;
  late double amount;
  late DateTime effectiveFrom;
  DateTime? effectiveUntil;
  late bool isDeleted;
  late DateTime lastModifiedAt;
}

// ═══════════════════════════════════════════════════════════════════════════
// Pending Sync Queue — tracks writes that haven't reached Firestore yet
// ═══════════════════════════════════════════════════════════════════════════

@collection
class IsarPendingWrite {
  Id id = Isar.autoIncrement;

  late String collectionName; // "transactions" | "categories" | "incomeSources"
  late String documentId;     // the entity UUID
  late String operation;      // "upsert" | "delete"
  late DateTime queuedAt;
}

// ═══════════════════════════════════════════════════════════════════════════
// Financial Roadmap
// ═══════════════════════════════════════════════════════════════════════════

@collection
class IsarTemporaryOutflow {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  late String id;

  late String name;
  late double amount;
  late DateTime startMonth;
  late DateTime endMonth;
  late bool isDeleted;
  late DateTime lastModifiedAt;
}

@collection
class IsarRoadmapMonth {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  late String id; // Format: YYYY-MM

  @Index()
  late DateTime month;

  double? netIncomeOverride;
  double? coreFixedExpensesOverride;
  String? actionPlan;
  
  late bool isDeleted;
  late DateTime lastModifiedAt;
}

// ── FNV-1a 64-bit hash for deterministic Isar integer IDs ─────────────────
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;
  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }
  return hash;
}
