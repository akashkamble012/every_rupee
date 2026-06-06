// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionEntity {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String? get merchant => throw _privateConstructorUsedError;
  PaymentMode? get paymentMode => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get smsSource =>
      throw _privateConstructorUsedError; // populated when parsed from SMS
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get lastModifiedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionEntityCopyWith<TransactionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionEntityCopyWith<$Res> {
  factory $TransactionEntityCopyWith(
          TransactionEntity value, $Res Function(TransactionEntity) then) =
      _$TransactionEntityCopyWithImpl<$Res, TransactionEntity>;
  @useResult
  $Res call(
      {String id,
      double amount,
      TransactionType type,
      DateTime date,
      String categoryId,
      String? merchant,
      PaymentMode? paymentMode,
      String? note,
      String? smsSource,
      bool isDeleted,
      DateTime createdAt,
      DateTime lastModifiedAt});
}

/// @nodoc
class _$TransactionEntityCopyWithImpl<$Res, $Val extends TransactionEntity>
    implements $TransactionEntityCopyWith<$Res> {
  _$TransactionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? date = null,
    Object? categoryId = null,
    Object? merchant = freezed,
    Object? paymentMode = freezed,
    Object? note = freezed,
    Object? smsSource = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      merchant: freezed == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMode: freezed == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      smsSource: freezed == smsSource
          ? _value.smsSource
          : smsSource // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionEntityImplCopyWith<$Res>
    implements $TransactionEntityCopyWith<$Res> {
  factory _$$TransactionEntityImplCopyWith(_$TransactionEntityImpl value,
          $Res Function(_$TransactionEntityImpl) then) =
      __$$TransactionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      TransactionType type,
      DateTime date,
      String categoryId,
      String? merchant,
      PaymentMode? paymentMode,
      String? note,
      String? smsSource,
      bool isDeleted,
      DateTime createdAt,
      DateTime lastModifiedAt});
}

/// @nodoc
class __$$TransactionEntityImplCopyWithImpl<$Res>
    extends _$TransactionEntityCopyWithImpl<$Res, _$TransactionEntityImpl>
    implements _$$TransactionEntityImplCopyWith<$Res> {
  __$$TransactionEntityImplCopyWithImpl(_$TransactionEntityImpl _value,
      $Res Function(_$TransactionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? date = null,
    Object? categoryId = null,
    Object? merchant = freezed,
    Object? paymentMode = freezed,
    Object? note = freezed,
    Object? smsSource = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_$TransactionEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      merchant: freezed == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMode: freezed == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      smsSource: freezed == smsSource
          ? _value.smsSource
          : smsSource // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TransactionEntityImpl implements _TransactionEntity {
  const _$TransactionEntityImpl(
      {required this.id,
      required this.amount,
      required this.type,
      required this.date,
      required this.categoryId,
      this.merchant,
      this.paymentMode,
      this.note,
      this.smsSource,
      this.isDeleted = false,
      required this.createdAt,
      required this.lastModifiedAt});

  @override
  final String id;
  @override
  final double amount;
  @override
  final TransactionType type;
  @override
  final DateTime date;
  @override
  final String categoryId;
  @override
  final String? merchant;
  @override
  final PaymentMode? paymentMode;
  @override
  final String? note;
  @override
  final String? smsSource;
// populated when parsed from SMS
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastModifiedAt;

  @override
  String toString() {
    return 'TransactionEntity(id: $id, amount: $amount, type: $type, date: $date, categoryId: $categoryId, merchant: $merchant, paymentMode: $paymentMode, note: $note, smsSource: $smsSource, isDeleted: $isDeleted, createdAt: $createdAt, lastModifiedAt: $lastModifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.smsSource, smsSource) ||
                other.smsSource == smsSource) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amount,
      type,
      date,
      categoryId,
      merchant,
      paymentMode,
      note,
      smsSource,
      isDeleted,
      createdAt,
      lastModifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionEntityImplCopyWith<_$TransactionEntityImpl> get copyWith =>
      __$$TransactionEntityImplCopyWithImpl<_$TransactionEntityImpl>(
          this, _$identity);
}

abstract class _TransactionEntity implements TransactionEntity {
  const factory _TransactionEntity(
      {required final String id,
      required final double amount,
      required final TransactionType type,
      required final DateTime date,
      required final String categoryId,
      final String? merchant,
      final PaymentMode? paymentMode,
      final String? note,
      final String? smsSource,
      final bool isDeleted,
      required final DateTime createdAt,
      required final DateTime lastModifiedAt}) = _$TransactionEntityImpl;

  @override
  String get id;
  @override
  double get amount;
  @override
  TransactionType get type;
  @override
  DateTime get date;
  @override
  String get categoryId;
  @override
  String? get merchant;
  @override
  PaymentMode? get paymentMode;
  @override
  String? get note;
  @override
  String? get smsSource;
  @override // populated when parsed from SMS
  bool get isDeleted;
  @override
  DateTime get createdAt;
  @override
  DateTime get lastModifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$TransactionEntityImplCopyWith<_$TransactionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetCategoryEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get cap => throw _privateConstructorUsedError; // monthly allocation
  DateTime get effectiveFrom => throw _privateConstructorUsedError;
  DateTime? get activeUntil =>
      throw _privateConstructorUsedError; // null = open-ended (no expiry)
  String? get iconCode =>
      throw _privateConstructorUsedError; // Material icon codePoint as string
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime get lastModifiedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetCategoryEntityCopyWith<BudgetCategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCategoryEntityCopyWith<$Res> {
  factory $BudgetCategoryEntityCopyWith(BudgetCategoryEntity value,
          $Res Function(BudgetCategoryEntity) then) =
      _$BudgetCategoryEntityCopyWithImpl<$Res, BudgetCategoryEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      double cap,
      DateTime effectiveFrom,
      DateTime? activeUntil,
      String? iconCode,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class _$BudgetCategoryEntityCopyWithImpl<$Res,
        $Val extends BudgetCategoryEntity>
    implements $BudgetCategoryEntityCopyWith<$Res> {
  _$BudgetCategoryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cap = null,
    Object? effectiveFrom = null,
    Object? activeUntil = freezed,
    Object? iconCode = freezed,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cap: null == cap
          ? _value.cap
          : cap // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveFrom: null == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activeUntil: freezed == activeUntil
          ? _value.activeUntil
          : activeUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      iconCode: freezed == iconCode
          ? _value.iconCode
          : iconCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetCategoryEntityImplCopyWith<$Res>
    implements $BudgetCategoryEntityCopyWith<$Res> {
  factory _$$BudgetCategoryEntityImplCopyWith(_$BudgetCategoryEntityImpl value,
          $Res Function(_$BudgetCategoryEntityImpl) then) =
      __$$BudgetCategoryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double cap,
      DateTime effectiveFrom,
      DateTime? activeUntil,
      String? iconCode,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class __$$BudgetCategoryEntityImplCopyWithImpl<$Res>
    extends _$BudgetCategoryEntityCopyWithImpl<$Res, _$BudgetCategoryEntityImpl>
    implements _$$BudgetCategoryEntityImplCopyWith<$Res> {
  __$$BudgetCategoryEntityImplCopyWithImpl(_$BudgetCategoryEntityImpl _value,
      $Res Function(_$BudgetCategoryEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cap = null,
    Object? effectiveFrom = null,
    Object? activeUntil = freezed,
    Object? iconCode = freezed,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_$BudgetCategoryEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cap: null == cap
          ? _value.cap
          : cap // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveFrom: null == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activeUntil: freezed == activeUntil
          ? _value.activeUntil
          : activeUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      iconCode: freezed == iconCode
          ? _value.iconCode
          : iconCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$BudgetCategoryEntityImpl implements _BudgetCategoryEntity {
  const _$BudgetCategoryEntityImpl(
      {required this.id,
      required this.name,
      required this.cap,
      required this.effectiveFrom,
      this.activeUntil,
      this.iconCode,
      this.isDeleted = false,
      required this.lastModifiedAt});

  @override
  final String id;
  @override
  final String name;
  @override
  final double cap;
// monthly allocation
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? activeUntil;
// null = open-ended (no expiry)
  @override
  final String? iconCode;
// Material icon codePoint as string
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime lastModifiedAt;

  @override
  String toString() {
    return 'BudgetCategoryEntity(id: $id, name: $name, cap: $cap, effectiveFrom: $effectiveFrom, activeUntil: $activeUntil, iconCode: $iconCode, isDeleted: $isDeleted, lastModifiedAt: $lastModifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCategoryEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cap, cap) || other.cap == cap) &&
            (identical(other.effectiveFrom, effectiveFrom) ||
                other.effectiveFrom == effectiveFrom) &&
            (identical(other.activeUntil, activeUntil) ||
                other.activeUntil == activeUntil) &&
            (identical(other.iconCode, iconCode) ||
                other.iconCode == iconCode) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, cap, effectiveFrom,
      activeUntil, iconCode, isDeleted, lastModifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCategoryEntityImplCopyWith<_$BudgetCategoryEntityImpl>
      get copyWith =>
          __$$BudgetCategoryEntityImplCopyWithImpl<_$BudgetCategoryEntityImpl>(
              this, _$identity);
}

abstract class _BudgetCategoryEntity implements BudgetCategoryEntity {
  const factory _BudgetCategoryEntity(
      {required final String id,
      required final String name,
      required final double cap,
      required final DateTime effectiveFrom,
      final DateTime? activeUntil,
      final String? iconCode,
      final bool isDeleted,
      required final DateTime lastModifiedAt}) = _$BudgetCategoryEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get cap;
  @override // monthly allocation
  DateTime get effectiveFrom;
  @override
  DateTime? get activeUntil;
  @override // null = open-ended (no expiry)
  String? get iconCode;
  @override // Material icon codePoint as string
  bool get isDeleted;
  @override
  DateTime get lastModifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$BudgetCategoryEntityImplCopyWith<_$BudgetCategoryEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IncomeSourceEntity {
  String get id => throw _privateConstructorUsedError;
  String get name =>
      throw _privateConstructorUsedError; // "Primary Salary", "Freelance", etc.
  double get amount => throw _privateConstructorUsedError;
  DateTime get effectiveFrom => throw _privateConstructorUsedError;
  DateTime? get effectiveUntil =>
      throw _privateConstructorUsedError; // null = currently active
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime get lastModifiedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IncomeSourceEntityCopyWith<IncomeSourceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeSourceEntityCopyWith<$Res> {
  factory $IncomeSourceEntityCopyWith(
          IncomeSourceEntity value, $Res Function(IncomeSourceEntity) then) =
      _$IncomeSourceEntityCopyWithImpl<$Res, IncomeSourceEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      DateTime effectiveFrom,
      DateTime? effectiveUntil,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class _$IncomeSourceEntityCopyWithImpl<$Res, $Val extends IncomeSourceEntity>
    implements $IncomeSourceEntityCopyWith<$Res> {
  _$IncomeSourceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? effectiveFrom = null,
    Object? effectiveUntil = freezed,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveFrom: null == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      effectiveUntil: freezed == effectiveUntil
          ? _value.effectiveUntil
          : effectiveUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncomeSourceEntityImplCopyWith<$Res>
    implements $IncomeSourceEntityCopyWith<$Res> {
  factory _$$IncomeSourceEntityImplCopyWith(_$IncomeSourceEntityImpl value,
          $Res Function(_$IncomeSourceEntityImpl) then) =
      __$$IncomeSourceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      DateTime effectiveFrom,
      DateTime? effectiveUntil,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class __$$IncomeSourceEntityImplCopyWithImpl<$Res>
    extends _$IncomeSourceEntityCopyWithImpl<$Res, _$IncomeSourceEntityImpl>
    implements _$$IncomeSourceEntityImplCopyWith<$Res> {
  __$$IncomeSourceEntityImplCopyWithImpl(_$IncomeSourceEntityImpl _value,
      $Res Function(_$IncomeSourceEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? effectiveFrom = null,
    Object? effectiveUntil = freezed,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_$IncomeSourceEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveFrom: null == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      effectiveUntil: freezed == effectiveUntil
          ? _value.effectiveUntil
          : effectiveUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$IncomeSourceEntityImpl implements _IncomeSourceEntity {
  const _$IncomeSourceEntityImpl(
      {required this.id,
      required this.name,
      required this.amount,
      required this.effectiveFrom,
      this.effectiveUntil,
      this.isDeleted = false,
      required this.lastModifiedAt});

  @override
  final String id;
  @override
  final String name;
// "Primary Salary", "Freelance", etc.
  @override
  final double amount;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveUntil;
// null = currently active
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime lastModifiedAt;

  @override
  String toString() {
    return 'IncomeSourceEntity(id: $id, name: $name, amount: $amount, effectiveFrom: $effectiveFrom, effectiveUntil: $effectiveUntil, isDeleted: $isDeleted, lastModifiedAt: $lastModifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeSourceEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.effectiveFrom, effectiveFrom) ||
                other.effectiveFrom == effectiveFrom) &&
            (identical(other.effectiveUntil, effectiveUntil) ||
                other.effectiveUntil == effectiveUntil) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, amount, effectiveFrom,
      effectiveUntil, isDeleted, lastModifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeSourceEntityImplCopyWith<_$IncomeSourceEntityImpl> get copyWith =>
      __$$IncomeSourceEntityImplCopyWithImpl<_$IncomeSourceEntityImpl>(
          this, _$identity);
}

abstract class _IncomeSourceEntity implements IncomeSourceEntity {
  const factory _IncomeSourceEntity(
      {required final String id,
      required final String name,
      required final double amount,
      required final DateTime effectiveFrom,
      final DateTime? effectiveUntil,
      final bool isDeleted,
      required final DateTime lastModifiedAt}) = _$IncomeSourceEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override // "Primary Salary", "Freelance", etc.
  double get amount;
  @override
  DateTime get effectiveFrom;
  @override
  DateTime? get effectiveUntil;
  @override // null = currently active
  bool get isDeleted;
  @override
  DateTime get lastModifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$IncomeSourceEntityImplCopyWith<_$IncomeSourceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlySurplusEntity {
  DateTime get month => throw _privateConstructorUsedError;
  double get totalIncome => throw _privateConstructorUsedError;
  double get totalAllocated =>
      throw _privateConstructorUsedError; // sum of all active caps
  double get totalSpent =>
      throw _privateConstructorUsedError; // sum of debit transactions
  double get surplus =>
      throw _privateConstructorUsedError; // income - allocated (unassigned)
  double get balance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlySurplusEntityCopyWith<MonthlySurplusEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySurplusEntityCopyWith<$Res> {
  factory $MonthlySurplusEntityCopyWith(MonthlySurplusEntity value,
          $Res Function(MonthlySurplusEntity) then) =
      _$MonthlySurplusEntityCopyWithImpl<$Res, MonthlySurplusEntity>;
  @useResult
  $Res call(
      {DateTime month,
      double totalIncome,
      double totalAllocated,
      double totalSpent,
      double surplus,
      double balance});
}

/// @nodoc
class _$MonthlySurplusEntityCopyWithImpl<$Res,
        $Val extends MonthlySurplusEntity>
    implements $MonthlySurplusEntityCopyWith<$Res> {
  _$MonthlySurplusEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalIncome = null,
    Object? totalAllocated = null,
    Object? totalSpent = null,
    Object? surplus = null,
    Object? balance = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      totalAllocated: null == totalAllocated
          ? _value.totalAllocated
          : totalAllocated // ignore: cast_nullable_to_non_nullable
              as double,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlySurplusEntityImplCopyWith<$Res>
    implements $MonthlySurplusEntityCopyWith<$Res> {
  factory _$$MonthlySurplusEntityImplCopyWith(_$MonthlySurplusEntityImpl value,
          $Res Function(_$MonthlySurplusEntityImpl) then) =
      __$$MonthlySurplusEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime month,
      double totalIncome,
      double totalAllocated,
      double totalSpent,
      double surplus,
      double balance});
}

/// @nodoc
class __$$MonthlySurplusEntityImplCopyWithImpl<$Res>
    extends _$MonthlySurplusEntityCopyWithImpl<$Res, _$MonthlySurplusEntityImpl>
    implements _$$MonthlySurplusEntityImplCopyWith<$Res> {
  __$$MonthlySurplusEntityImplCopyWithImpl(_$MonthlySurplusEntityImpl _value,
      $Res Function(_$MonthlySurplusEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalIncome = null,
    Object? totalAllocated = null,
    Object? totalSpent = null,
    Object? surplus = null,
    Object? balance = null,
  }) {
    return _then(_$MonthlySurplusEntityImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      totalAllocated: null == totalAllocated
          ? _value.totalAllocated
          : totalAllocated // ignore: cast_nullable_to_non_nullable
              as double,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MonthlySurplusEntityImpl implements _MonthlySurplusEntity {
  const _$MonthlySurplusEntityImpl(
      {required this.month,
      required this.totalIncome,
      required this.totalAllocated,
      required this.totalSpent,
      required this.surplus,
      required this.balance});

  @override
  final DateTime month;
  @override
  final double totalIncome;
  @override
  final double totalAllocated;
// sum of all active caps
  @override
  final double totalSpent;
// sum of debit transactions
  @override
  final double surplus;
// income - allocated (unassigned)
  @override
  final double balance;

  @override
  String toString() {
    return 'MonthlySurplusEntity(month: $month, totalIncome: $totalIncome, totalAllocated: $totalAllocated, totalSpent: $totalSpent, surplus: $surplus, balance: $balance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlySurplusEntityImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalAllocated, totalAllocated) ||
                other.totalAllocated == totalAllocated) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.surplus, surplus) || other.surplus == surplus) &&
            (identical(other.balance, balance) || other.balance == balance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, month, totalIncome,
      totalAllocated, totalSpent, surplus, balance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlySurplusEntityImplCopyWith<_$MonthlySurplusEntityImpl>
      get copyWith =>
          __$$MonthlySurplusEntityImplCopyWithImpl<_$MonthlySurplusEntityImpl>(
              this, _$identity);
}

abstract class _MonthlySurplusEntity implements MonthlySurplusEntity {
  const factory _MonthlySurplusEntity(
      {required final DateTime month,
      required final double totalIncome,
      required final double totalAllocated,
      required final double totalSpent,
      required final double surplus,
      required final double balance}) = _$MonthlySurplusEntityImpl;

  @override
  DateTime get month;
  @override
  double get totalIncome;
  @override
  double get totalAllocated;
  @override // sum of all active caps
  double get totalSpent;
  @override // sum of debit transactions
  double get surplus;
  @override // income - allocated (unassigned)
  double get balance;
  @override
  @JsonKey(ignore: true)
  _$$MonthlySurplusEntityImplCopyWith<_$MonthlySurplusEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategoryVarianceEntity {
  BudgetCategoryEntity get category => throw _privateConstructorUsedError;
  double get spent => throw _privateConstructorUsedError;
  double get remaining => throw _privateConstructorUsedError;
  double get ratio => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryVarianceEntityCopyWith<CategoryVarianceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryVarianceEntityCopyWith<$Res> {
  factory $CategoryVarianceEntityCopyWith(CategoryVarianceEntity value,
          $Res Function(CategoryVarianceEntity) then) =
      _$CategoryVarianceEntityCopyWithImpl<$Res, CategoryVarianceEntity>;
  @useResult
  $Res call(
      {BudgetCategoryEntity category,
      double spent,
      double remaining,
      double ratio});

  $BudgetCategoryEntityCopyWith<$Res> get category;
}

/// @nodoc
class _$CategoryVarianceEntityCopyWithImpl<$Res,
        $Val extends CategoryVarianceEntity>
    implements $CategoryVarianceEntityCopyWith<$Res> {
  _$CategoryVarianceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? spent = null,
    Object? remaining = null,
    Object? ratio = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as BudgetCategoryEntity,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCategoryEntityCopyWith<$Res> get category {
    return $BudgetCategoryEntityCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CategoryVarianceEntityImplCopyWith<$Res>
    implements $CategoryVarianceEntityCopyWith<$Res> {
  factory _$$CategoryVarianceEntityImplCopyWith(
          _$CategoryVarianceEntityImpl value,
          $Res Function(_$CategoryVarianceEntityImpl) then) =
      __$$CategoryVarianceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BudgetCategoryEntity category,
      double spent,
      double remaining,
      double ratio});

  @override
  $BudgetCategoryEntityCopyWith<$Res> get category;
}

/// @nodoc
class __$$CategoryVarianceEntityImplCopyWithImpl<$Res>
    extends _$CategoryVarianceEntityCopyWithImpl<$Res,
        _$CategoryVarianceEntityImpl>
    implements _$$CategoryVarianceEntityImplCopyWith<$Res> {
  __$$CategoryVarianceEntityImplCopyWithImpl(
      _$CategoryVarianceEntityImpl _value,
      $Res Function(_$CategoryVarianceEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? spent = null,
    Object? remaining = null,
    Object? ratio = null,
  }) {
    return _then(_$CategoryVarianceEntityImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as BudgetCategoryEntity,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CategoryVarianceEntityImpl implements _CategoryVarianceEntity {
  const _$CategoryVarianceEntityImpl(
      {required this.category,
      required this.spent,
      required this.remaining,
      required this.ratio});

  @override
  final BudgetCategoryEntity category;
  @override
  final double spent;
  @override
  final double remaining;
  @override
  final double ratio;

  @override
  String toString() {
    return 'CategoryVarianceEntity(category: $category, spent: $spent, remaining: $remaining, ratio: $ratio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryVarianceEntityImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.ratio, ratio) || other.ratio == ratio));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, category, spent, remaining, ratio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryVarianceEntityImplCopyWith<_$CategoryVarianceEntityImpl>
      get copyWith => __$$CategoryVarianceEntityImplCopyWithImpl<
          _$CategoryVarianceEntityImpl>(this, _$identity);
}

abstract class _CategoryVarianceEntity implements CategoryVarianceEntity {
  const factory _CategoryVarianceEntity(
      {required final BudgetCategoryEntity category,
      required final double spent,
      required final double remaining,
      required final double ratio}) = _$CategoryVarianceEntityImpl;

  @override
  BudgetCategoryEntity get category;
  @override
  double get spent;
  @override
  double get remaining;
  @override
  double get ratio;
  @override
  @JsonKey(ignore: true)
  _$$CategoryVarianceEntityImplCopyWith<_$CategoryVarianceEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserEntity {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  bool get onboardingComplete => throw _privateConstructorUsedError;
  bool get budgetSetupComplete => throw _privateConstructorUsedError;
  String? get varianceSortPreference => throw _privateConstructorUsedError;
  List<String>? get dashboardVisibleCharts =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserEntityCopyWith<UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) then) =
      _$UserEntityCopyWithImpl<$Res, UserEntity>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoUrl,
      bool onboardingComplete,
      bool budgetSetupComplete,
      String? varianceSortPreference,
      List<String>? dashboardVisibleCharts});
}

/// @nodoc
class _$UserEntityCopyWithImpl<$Res, $Val extends UserEntity>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? onboardingComplete = null,
    Object? budgetSetupComplete = null,
    Object? varianceSortPreference = freezed,
    Object? dashboardVisibleCharts = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      onboardingComplete: null == onboardingComplete
          ? _value.onboardingComplete
          : onboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      budgetSetupComplete: null == budgetSetupComplete
          ? _value.budgetSetupComplete
          : budgetSetupComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      varianceSortPreference: freezed == varianceSortPreference
          ? _value.varianceSortPreference
          : varianceSortPreference // ignore: cast_nullable_to_non_nullable
              as String?,
      dashboardVisibleCharts: freezed == dashboardVisibleCharts
          ? _value.dashboardVisibleCharts
          : dashboardVisibleCharts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserEntityImplCopyWith<$Res>
    implements $UserEntityCopyWith<$Res> {
  factory _$$UserEntityImplCopyWith(
          _$UserEntityImpl value, $Res Function(_$UserEntityImpl) then) =
      __$$UserEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String? displayName,
      String? photoUrl,
      bool onboardingComplete,
      bool budgetSetupComplete,
      String? varianceSortPreference,
      List<String>? dashboardVisibleCharts});
}

/// @nodoc
class __$$UserEntityImplCopyWithImpl<$Res>
    extends _$UserEntityCopyWithImpl<$Res, _$UserEntityImpl>
    implements _$$UserEntityImplCopyWith<$Res> {
  __$$UserEntityImplCopyWithImpl(
      _$UserEntityImpl _value, $Res Function(_$UserEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? onboardingComplete = null,
    Object? budgetSetupComplete = null,
    Object? varianceSortPreference = freezed,
    Object? dashboardVisibleCharts = freezed,
  }) {
    return _then(_$UserEntityImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      onboardingComplete: null == onboardingComplete
          ? _value.onboardingComplete
          : onboardingComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      budgetSetupComplete: null == budgetSetupComplete
          ? _value.budgetSetupComplete
          : budgetSetupComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      varianceSortPreference: freezed == varianceSortPreference
          ? _value.varianceSortPreference
          : varianceSortPreference // ignore: cast_nullable_to_non_nullable
              as String?,
      dashboardVisibleCharts: freezed == dashboardVisibleCharts
          ? _value._dashboardVisibleCharts
          : dashboardVisibleCharts // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$UserEntityImpl implements _UserEntity {
  const _$UserEntityImpl(
      {required this.uid,
      required this.email,
      this.displayName,
      this.photoUrl,
      this.onboardingComplete = false,
      this.budgetSetupComplete = false,
      this.varianceSortPreference,
      final List<String>? dashboardVisibleCharts})
      : _dashboardVisibleCharts = dashboardVisibleCharts;

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final bool onboardingComplete;
  @override
  @JsonKey()
  final bool budgetSetupComplete;
  @override
  final String? varianceSortPreference;
  final List<String>? _dashboardVisibleCharts;
  @override
  List<String>? get dashboardVisibleCharts {
    final value = _dashboardVisibleCharts;
    if (value == null) return null;
    if (_dashboardVisibleCharts is EqualUnmodifiableListView)
      return _dashboardVisibleCharts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserEntity(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, onboardingComplete: $onboardingComplete, budgetSetupComplete: $budgetSetupComplete, varianceSortPreference: $varianceSortPreference, dashboardVisibleCharts: $dashboardVisibleCharts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEntityImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.onboardingComplete, onboardingComplete) ||
                other.onboardingComplete == onboardingComplete) &&
            (identical(other.budgetSetupComplete, budgetSetupComplete) ||
                other.budgetSetupComplete == budgetSetupComplete) &&
            (identical(other.varianceSortPreference, varianceSortPreference) ||
                other.varianceSortPreference == varianceSortPreference) &&
            const DeepCollectionEquality().equals(
                other._dashboardVisibleCharts, _dashboardVisibleCharts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      displayName,
      photoUrl,
      onboardingComplete,
      budgetSetupComplete,
      varianceSortPreference,
      const DeepCollectionEquality().hash(_dashboardVisibleCharts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEntityImplCopyWith<_$UserEntityImpl> get copyWith =>
      __$$UserEntityImplCopyWithImpl<_$UserEntityImpl>(this, _$identity);
}

abstract class _UserEntity implements UserEntity {
  const factory _UserEntity(
      {required final String uid,
      required final String email,
      final String? displayName,
      final String? photoUrl,
      final bool onboardingComplete,
      final bool budgetSetupComplete,
      final String? varianceSortPreference,
      final List<String>? dashboardVisibleCharts}) = _$UserEntityImpl;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  String? get photoUrl;
  @override
  bool get onboardingComplete;
  @override
  bool get budgetSetupComplete;
  @override
  String? get varianceSortPreference;
  @override
  List<String>? get dashboardVisibleCharts;
  @override
  @JsonKey(ignore: true)
  _$$UserEntityImplCopyWith<_$UserEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TemporaryOutflowEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get startMonth => throw _privateConstructorUsedError;
  DateTime get endMonth => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime get lastModifiedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TemporaryOutflowEntityCopyWith<TemporaryOutflowEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemporaryOutflowEntityCopyWith<$Res> {
  factory $TemporaryOutflowEntityCopyWith(TemporaryOutflowEntity value,
          $Res Function(TemporaryOutflowEntity) then) =
      _$TemporaryOutflowEntityCopyWithImpl<$Res, TemporaryOutflowEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      DateTime startMonth,
      DateTime endMonth,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class _$TemporaryOutflowEntityCopyWithImpl<$Res,
        $Val extends TemporaryOutflowEntity>
    implements $TemporaryOutflowEntityCopyWith<$Res> {
  _$TemporaryOutflowEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? startMonth = null,
    Object? endMonth = null,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      startMonth: null == startMonth
          ? _value.startMonth
          : startMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endMonth: null == endMonth
          ? _value.endMonth
          : endMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TemporaryOutflowEntityImplCopyWith<$Res>
    implements $TemporaryOutflowEntityCopyWith<$Res> {
  factory _$$TemporaryOutflowEntityImplCopyWith(
          _$TemporaryOutflowEntityImpl value,
          $Res Function(_$TemporaryOutflowEntityImpl) then) =
      __$$TemporaryOutflowEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      DateTime startMonth,
      DateTime endMonth,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class __$$TemporaryOutflowEntityImplCopyWithImpl<$Res>
    extends _$TemporaryOutflowEntityCopyWithImpl<$Res,
        _$TemporaryOutflowEntityImpl>
    implements _$$TemporaryOutflowEntityImplCopyWith<$Res> {
  __$$TemporaryOutflowEntityImplCopyWithImpl(
      _$TemporaryOutflowEntityImpl _value,
      $Res Function(_$TemporaryOutflowEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? startMonth = null,
    Object? endMonth = null,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_$TemporaryOutflowEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      startMonth: null == startMonth
          ? _value.startMonth
          : startMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endMonth: null == endMonth
          ? _value.endMonth
          : endMonth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$TemporaryOutflowEntityImpl implements _TemporaryOutflowEntity {
  const _$TemporaryOutflowEntityImpl(
      {required this.id,
      required this.name,
      required this.amount,
      required this.startMonth,
      required this.endMonth,
      this.isDeleted = false,
      required this.lastModifiedAt});

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final DateTime startMonth;
  @override
  final DateTime endMonth;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime lastModifiedAt;

  @override
  String toString() {
    return 'TemporaryOutflowEntity(id: $id, name: $name, amount: $amount, startMonth: $startMonth, endMonth: $endMonth, isDeleted: $isDeleted, lastModifiedAt: $lastModifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemporaryOutflowEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.startMonth, startMonth) ||
                other.startMonth == startMonth) &&
            (identical(other.endMonth, endMonth) ||
                other.endMonth == endMonth) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, amount, startMonth,
      endMonth, isDeleted, lastModifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemporaryOutflowEntityImplCopyWith<_$TemporaryOutflowEntityImpl>
      get copyWith => __$$TemporaryOutflowEntityImplCopyWithImpl<
          _$TemporaryOutflowEntityImpl>(this, _$identity);
}

abstract class _TemporaryOutflowEntity implements TemporaryOutflowEntity {
  const factory _TemporaryOutflowEntity(
      {required final String id,
      required final String name,
      required final double amount,
      required final DateTime startMonth,
      required final DateTime endMonth,
      final bool isDeleted,
      required final DateTime lastModifiedAt}) = _$TemporaryOutflowEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  DateTime get startMonth;
  @override
  DateTime get endMonth;
  @override
  bool get isDeleted;
  @override
  DateTime get lastModifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$TemporaryOutflowEntityImplCopyWith<_$TemporaryOutflowEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoadmapMonthEntity {
  String get id => throw _privateConstructorUsedError; // Format: YYYY-MM
  DateTime get month => throw _privateConstructorUsedError;
  double? get netIncomeOverride => throw _privateConstructorUsedError;
  double? get coreFixedExpensesOverride => throw _privateConstructorUsedError;
  String? get actionPlan => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime get lastModifiedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoadmapMonthEntityCopyWith<RoadmapMonthEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadmapMonthEntityCopyWith<$Res> {
  factory $RoadmapMonthEntityCopyWith(
          RoadmapMonthEntity value, $Res Function(RoadmapMonthEntity) then) =
      _$RoadmapMonthEntityCopyWithImpl<$Res, RoadmapMonthEntity>;
  @useResult
  $Res call(
      {String id,
      DateTime month,
      double? netIncomeOverride,
      double? coreFixedExpensesOverride,
      String? actionPlan,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class _$RoadmapMonthEntityCopyWithImpl<$Res, $Val extends RoadmapMonthEntity>
    implements $RoadmapMonthEntityCopyWith<$Res> {
  _$RoadmapMonthEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? netIncomeOverride = freezed,
    Object? coreFixedExpensesOverride = freezed,
    Object? actionPlan = freezed,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      netIncomeOverride: freezed == netIncomeOverride
          ? _value.netIncomeOverride
          : netIncomeOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      coreFixedExpensesOverride: freezed == coreFixedExpensesOverride
          ? _value.coreFixedExpensesOverride
          : coreFixedExpensesOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      actionPlan: freezed == actionPlan
          ? _value.actionPlan
          : actionPlan // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoadmapMonthEntityImplCopyWith<$Res>
    implements $RoadmapMonthEntityCopyWith<$Res> {
  factory _$$RoadmapMonthEntityImplCopyWith(_$RoadmapMonthEntityImpl value,
          $Res Function(_$RoadmapMonthEntityImpl) then) =
      __$$RoadmapMonthEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime month,
      double? netIncomeOverride,
      double? coreFixedExpensesOverride,
      String? actionPlan,
      bool isDeleted,
      DateTime lastModifiedAt});
}

/// @nodoc
class __$$RoadmapMonthEntityImplCopyWithImpl<$Res>
    extends _$RoadmapMonthEntityCopyWithImpl<$Res, _$RoadmapMonthEntityImpl>
    implements _$$RoadmapMonthEntityImplCopyWith<$Res> {
  __$$RoadmapMonthEntityImplCopyWithImpl(_$RoadmapMonthEntityImpl _value,
      $Res Function(_$RoadmapMonthEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? netIncomeOverride = freezed,
    Object? coreFixedExpensesOverride = freezed,
    Object? actionPlan = freezed,
    Object? isDeleted = null,
    Object? lastModifiedAt = null,
  }) {
    return _then(_$RoadmapMonthEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      netIncomeOverride: freezed == netIncomeOverride
          ? _value.netIncomeOverride
          : netIncomeOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      coreFixedExpensesOverride: freezed == coreFixedExpensesOverride
          ? _value.coreFixedExpensesOverride
          : coreFixedExpensesOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      actionPlan: freezed == actionPlan
          ? _value.actionPlan
          : actionPlan // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastModifiedAt: null == lastModifiedAt
          ? _value.lastModifiedAt
          : lastModifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$RoadmapMonthEntityImpl implements _RoadmapMonthEntity {
  const _$RoadmapMonthEntityImpl(
      {required this.id,
      required this.month,
      this.netIncomeOverride,
      this.coreFixedExpensesOverride,
      this.actionPlan,
      this.isDeleted = false,
      required this.lastModifiedAt});

  @override
  final String id;
// Format: YYYY-MM
  @override
  final DateTime month;
  @override
  final double? netIncomeOverride;
  @override
  final double? coreFixedExpensesOverride;
  @override
  final String? actionPlan;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime lastModifiedAt;

  @override
  String toString() {
    return 'RoadmapMonthEntity(id: $id, month: $month, netIncomeOverride: $netIncomeOverride, coreFixedExpensesOverride: $coreFixedExpensesOverride, actionPlan: $actionPlan, isDeleted: $isDeleted, lastModifiedAt: $lastModifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadmapMonthEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.netIncomeOverride, netIncomeOverride) ||
                other.netIncomeOverride == netIncomeOverride) &&
            (identical(other.coreFixedExpensesOverride,
                    coreFixedExpensesOverride) ||
                other.coreFixedExpensesOverride == coreFixedExpensesOverride) &&
            (identical(other.actionPlan, actionPlan) ||
                other.actionPlan == actionPlan) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.lastModifiedAt, lastModifiedAt) ||
                other.lastModifiedAt == lastModifiedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, month, netIncomeOverride,
      coreFixedExpensesOverride, actionPlan, isDeleted, lastModifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadmapMonthEntityImplCopyWith<_$RoadmapMonthEntityImpl> get copyWith =>
      __$$RoadmapMonthEntityImplCopyWithImpl<_$RoadmapMonthEntityImpl>(
          this, _$identity);
}

abstract class _RoadmapMonthEntity implements RoadmapMonthEntity {
  const factory _RoadmapMonthEntity(
      {required final String id,
      required final DateTime month,
      final double? netIncomeOverride,
      final double? coreFixedExpensesOverride,
      final String? actionPlan,
      final bool isDeleted,
      required final DateTime lastModifiedAt}) = _$RoadmapMonthEntityImpl;

  @override
  String get id;
  @override // Format: YYYY-MM
  DateTime get month;
  @override
  double? get netIncomeOverride;
  @override
  double? get coreFixedExpensesOverride;
  @override
  String? get actionPlan;
  @override
  bool get isDeleted;
  @override
  DateTime get lastModifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$RoadmapMonthEntityImplCopyWith<_$RoadmapMonthEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoadmapDisplayEntity {
  String get id => throw _privateConstructorUsedError;
  DateTime get month =>
      throw _privateConstructorUsedError; // The derived/effective values used for projection
  double get effectiveIncome => throw _privateConstructorUsedError;
  double get effectiveFixedExpenses => throw _privateConstructorUsedError;
  double get temporaryOutflows => throw _privateConstructorUsedError;
  double get totalOutflow => throw _privateConstructorUsedError;
  double get surplus => throw _privateConstructorUsedError;
  double get accumulatedWealth =>
      throw _privateConstructorUsedError; // Overrides and user data
  double? get netIncomeOverride => throw _privateConstructorUsedError;
  double? get coreFixedExpensesOverride => throw _privateConstructorUsedError;
  String? get actionPlan => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoadmapDisplayEntityCopyWith<RoadmapDisplayEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadmapDisplayEntityCopyWith<$Res> {
  factory $RoadmapDisplayEntityCopyWith(RoadmapDisplayEntity value,
          $Res Function(RoadmapDisplayEntity) then) =
      _$RoadmapDisplayEntityCopyWithImpl<$Res, RoadmapDisplayEntity>;
  @useResult
  $Res call(
      {String id,
      DateTime month,
      double effectiveIncome,
      double effectiveFixedExpenses,
      double temporaryOutflows,
      double totalOutflow,
      double surplus,
      double accumulatedWealth,
      double? netIncomeOverride,
      double? coreFixedExpensesOverride,
      String? actionPlan});
}

/// @nodoc
class _$RoadmapDisplayEntityCopyWithImpl<$Res,
        $Val extends RoadmapDisplayEntity>
    implements $RoadmapDisplayEntityCopyWith<$Res> {
  _$RoadmapDisplayEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? effectiveIncome = null,
    Object? effectiveFixedExpenses = null,
    Object? temporaryOutflows = null,
    Object? totalOutflow = null,
    Object? surplus = null,
    Object? accumulatedWealth = null,
    Object? netIncomeOverride = freezed,
    Object? coreFixedExpensesOverride = freezed,
    Object? actionPlan = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      effectiveIncome: null == effectiveIncome
          ? _value.effectiveIncome
          : effectiveIncome // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveFixedExpenses: null == effectiveFixedExpenses
          ? _value.effectiveFixedExpenses
          : effectiveFixedExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      temporaryOutflows: null == temporaryOutflows
          ? _value.temporaryOutflows
          : temporaryOutflows // ignore: cast_nullable_to_non_nullable
              as double,
      totalOutflow: null == totalOutflow
          ? _value.totalOutflow
          : totalOutflow // ignore: cast_nullable_to_non_nullable
              as double,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as double,
      accumulatedWealth: null == accumulatedWealth
          ? _value.accumulatedWealth
          : accumulatedWealth // ignore: cast_nullable_to_non_nullable
              as double,
      netIncomeOverride: freezed == netIncomeOverride
          ? _value.netIncomeOverride
          : netIncomeOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      coreFixedExpensesOverride: freezed == coreFixedExpensesOverride
          ? _value.coreFixedExpensesOverride
          : coreFixedExpensesOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      actionPlan: freezed == actionPlan
          ? _value.actionPlan
          : actionPlan // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoadmapDisplayEntityImplCopyWith<$Res>
    implements $RoadmapDisplayEntityCopyWith<$Res> {
  factory _$$RoadmapDisplayEntityImplCopyWith(_$RoadmapDisplayEntityImpl value,
          $Res Function(_$RoadmapDisplayEntityImpl) then) =
      __$$RoadmapDisplayEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime month,
      double effectiveIncome,
      double effectiveFixedExpenses,
      double temporaryOutflows,
      double totalOutflow,
      double surplus,
      double accumulatedWealth,
      double? netIncomeOverride,
      double? coreFixedExpensesOverride,
      String? actionPlan});
}

/// @nodoc
class __$$RoadmapDisplayEntityImplCopyWithImpl<$Res>
    extends _$RoadmapDisplayEntityCopyWithImpl<$Res, _$RoadmapDisplayEntityImpl>
    implements _$$RoadmapDisplayEntityImplCopyWith<$Res> {
  __$$RoadmapDisplayEntityImplCopyWithImpl(_$RoadmapDisplayEntityImpl _value,
      $Res Function(_$RoadmapDisplayEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? effectiveIncome = null,
    Object? effectiveFixedExpenses = null,
    Object? temporaryOutflows = null,
    Object? totalOutflow = null,
    Object? surplus = null,
    Object? accumulatedWealth = null,
    Object? netIncomeOverride = freezed,
    Object? coreFixedExpensesOverride = freezed,
    Object? actionPlan = freezed,
  }) {
    return _then(_$RoadmapDisplayEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      effectiveIncome: null == effectiveIncome
          ? _value.effectiveIncome
          : effectiveIncome // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveFixedExpenses: null == effectiveFixedExpenses
          ? _value.effectiveFixedExpenses
          : effectiveFixedExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      temporaryOutflows: null == temporaryOutflows
          ? _value.temporaryOutflows
          : temporaryOutflows // ignore: cast_nullable_to_non_nullable
              as double,
      totalOutflow: null == totalOutflow
          ? _value.totalOutflow
          : totalOutflow // ignore: cast_nullable_to_non_nullable
              as double,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as double,
      accumulatedWealth: null == accumulatedWealth
          ? _value.accumulatedWealth
          : accumulatedWealth // ignore: cast_nullable_to_non_nullable
              as double,
      netIncomeOverride: freezed == netIncomeOverride
          ? _value.netIncomeOverride
          : netIncomeOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      coreFixedExpensesOverride: freezed == coreFixedExpensesOverride
          ? _value.coreFixedExpensesOverride
          : coreFixedExpensesOverride // ignore: cast_nullable_to_non_nullable
              as double?,
      actionPlan: freezed == actionPlan
          ? _value.actionPlan
          : actionPlan // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RoadmapDisplayEntityImpl implements _RoadmapDisplayEntity {
  const _$RoadmapDisplayEntityImpl(
      {required this.id,
      required this.month,
      required this.effectiveIncome,
      required this.effectiveFixedExpenses,
      required this.temporaryOutflows,
      required this.totalOutflow,
      required this.surplus,
      required this.accumulatedWealth,
      this.netIncomeOverride,
      this.coreFixedExpensesOverride,
      this.actionPlan});

  @override
  final String id;
  @override
  final DateTime month;
// The derived/effective values used for projection
  @override
  final double effectiveIncome;
  @override
  final double effectiveFixedExpenses;
  @override
  final double temporaryOutflows;
  @override
  final double totalOutflow;
  @override
  final double surplus;
  @override
  final double accumulatedWealth;
// Overrides and user data
  @override
  final double? netIncomeOverride;
  @override
  final double? coreFixedExpensesOverride;
  @override
  final String? actionPlan;

  @override
  String toString() {
    return 'RoadmapDisplayEntity(id: $id, month: $month, effectiveIncome: $effectiveIncome, effectiveFixedExpenses: $effectiveFixedExpenses, temporaryOutflows: $temporaryOutflows, totalOutflow: $totalOutflow, surplus: $surplus, accumulatedWealth: $accumulatedWealth, netIncomeOverride: $netIncomeOverride, coreFixedExpensesOverride: $coreFixedExpensesOverride, actionPlan: $actionPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadmapDisplayEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.effectiveIncome, effectiveIncome) ||
                other.effectiveIncome == effectiveIncome) &&
            (identical(other.effectiveFixedExpenses, effectiveFixedExpenses) ||
                other.effectiveFixedExpenses == effectiveFixedExpenses) &&
            (identical(other.temporaryOutflows, temporaryOutflows) ||
                other.temporaryOutflows == temporaryOutflows) &&
            (identical(other.totalOutflow, totalOutflow) ||
                other.totalOutflow == totalOutflow) &&
            (identical(other.surplus, surplus) || other.surplus == surplus) &&
            (identical(other.accumulatedWealth, accumulatedWealth) ||
                other.accumulatedWealth == accumulatedWealth) &&
            (identical(other.netIncomeOverride, netIncomeOverride) ||
                other.netIncomeOverride == netIncomeOverride) &&
            (identical(other.coreFixedExpensesOverride,
                    coreFixedExpensesOverride) ||
                other.coreFixedExpensesOverride == coreFixedExpensesOverride) &&
            (identical(other.actionPlan, actionPlan) ||
                other.actionPlan == actionPlan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      month,
      effectiveIncome,
      effectiveFixedExpenses,
      temporaryOutflows,
      totalOutflow,
      surplus,
      accumulatedWealth,
      netIncomeOverride,
      coreFixedExpensesOverride,
      actionPlan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadmapDisplayEntityImplCopyWith<_$RoadmapDisplayEntityImpl>
      get copyWith =>
          __$$RoadmapDisplayEntityImplCopyWithImpl<_$RoadmapDisplayEntityImpl>(
              this, _$identity);
}

abstract class _RoadmapDisplayEntity implements RoadmapDisplayEntity {
  const factory _RoadmapDisplayEntity(
      {required final String id,
      required final DateTime month,
      required final double effectiveIncome,
      required final double effectiveFixedExpenses,
      required final double temporaryOutflows,
      required final double totalOutflow,
      required final double surplus,
      required final double accumulatedWealth,
      final double? netIncomeOverride,
      final double? coreFixedExpensesOverride,
      final String? actionPlan}) = _$RoadmapDisplayEntityImpl;

  @override
  String get id;
  @override
  DateTime get month;
  @override // The derived/effective values used for projection
  double get effectiveIncome;
  @override
  double get effectiveFixedExpenses;
  @override
  double get temporaryOutflows;
  @override
  double get totalOutflow;
  @override
  double get surplus;
  @override
  double get accumulatedWealth;
  @override // Overrides and user data
  double? get netIncomeOverride;
  @override
  double? get coreFixedExpensesOverride;
  @override
  String? get actionPlan;
  @override
  @JsonKey(ignore: true)
  _$$RoadmapDisplayEntityImplCopyWith<_$RoadmapDisplayEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
