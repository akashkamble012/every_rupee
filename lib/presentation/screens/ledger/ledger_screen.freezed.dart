// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_screen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LedgerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(DateTime? fromDate, DateTime? toDate,
            String? categoryId, TransactionType? type, String? searchText)
        applyFilter,
    required TResult Function(String id) softDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult? Function(String id)? softDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult Function(String id)? softDelete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ApplyFilter value) applyFilter,
    required TResult Function(_SoftDelete value) softDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ApplyFilter value)? applyFilter,
    TResult? Function(_SoftDelete value)? softDelete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ApplyFilter value)? applyFilter,
    TResult Function(_SoftDelete value)? softDelete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerEventCopyWith<$Res> {
  factory $LedgerEventCopyWith(
          LedgerEvent value, $Res Function(LedgerEvent) then) =
      _$LedgerEventCopyWithImpl<$Res, LedgerEvent>;
}

/// @nodoc
class _$LedgerEventCopyWithImpl<$Res, $Val extends LedgerEvent>
    implements $LedgerEventCopyWith<$Res> {
  _$LedgerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadImplCopyWith<$Res> {
  factory _$$LoadImplCopyWith(
          _$LoadImpl value, $Res Function(_$LoadImpl) then) =
      __$$LoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$LedgerEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl();

  @override
  String toString() {
    return 'LedgerEvent.load()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(DateTime? fromDate, DateTime? toDate,
            String? categoryId, TransactionType? type, String? searchText)
        applyFilter,
    required TResult Function(String id) softDelete,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult? Function(String id)? softDelete,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult Function(String id)? softDelete,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ApplyFilter value) applyFilter,
    required TResult Function(_SoftDelete value) softDelete,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ApplyFilter value)? applyFilter,
    TResult? Function(_SoftDelete value)? softDelete,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ApplyFilter value)? applyFilter,
    TResult Function(_SoftDelete value)? softDelete,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements LedgerEvent {
  const factory _Load() = _$LoadImpl;
}

/// @nodoc
abstract class _$$LoadMoreImplCopyWith<$Res> {
  factory _$$LoadMoreImplCopyWith(
          _$LoadMoreImpl value, $Res Function(_$LoadMoreImpl) then) =
      __$$LoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreImplCopyWithImpl<$Res>
    extends _$LedgerEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
      _$LoadMoreImpl _value, $Res Function(_$LoadMoreImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadMoreImpl implements _LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'LedgerEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(DateTime? fromDate, DateTime? toDate,
            String? categoryId, TransactionType? type, String? searchText)
        applyFilter,
    required TResult Function(String id) softDelete,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult? Function(String id)? softDelete,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult Function(String id)? softDelete,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ApplyFilter value) applyFilter,
    required TResult Function(_SoftDelete value) softDelete,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ApplyFilter value)? applyFilter,
    TResult? Function(_SoftDelete value)? softDelete,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ApplyFilter value)? applyFilter,
    TResult Function(_SoftDelete value)? softDelete,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class _LoadMore implements LedgerEvent {
  const factory _LoadMore() = _$LoadMoreImpl;
}

/// @nodoc
abstract class _$$ApplyFilterImplCopyWith<$Res> {
  factory _$$ApplyFilterImplCopyWith(
          _$ApplyFilterImpl value, $Res Function(_$ApplyFilterImpl) then) =
      __$$ApplyFilterImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {DateTime? fromDate,
      DateTime? toDate,
      String? categoryId,
      TransactionType? type,
      String? searchText});
}

/// @nodoc
class __$$ApplyFilterImplCopyWithImpl<$Res>
    extends _$LedgerEventCopyWithImpl<$Res, _$ApplyFilterImpl>
    implements _$$ApplyFilterImplCopyWith<$Res> {
  __$$ApplyFilterImplCopyWithImpl(
      _$ApplyFilterImpl _value, $Res Function(_$ApplyFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromDate = freezed,
    Object? toDate = freezed,
    Object? categoryId = freezed,
    Object? type = freezed,
    Object? searchText = freezed,
  }) {
    return _then(_$ApplyFilterImpl(
      fromDate: freezed == fromDate
          ? _value.fromDate
          : fromDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      toDate: freezed == toDate
          ? _value.toDate
          : toDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType?,
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ApplyFilterImpl implements _ApplyFilter {
  const _$ApplyFilterImpl(
      {this.fromDate,
      this.toDate,
      this.categoryId,
      this.type,
      this.searchText});

  @override
  final DateTime? fromDate;
  @override
  final DateTime? toDate;
  @override
  final String? categoryId;
  @override
  final TransactionType? type;
  @override
  final String? searchText;

  @override
  String toString() {
    return 'LedgerEvent.applyFilter(fromDate: $fromDate, toDate: $toDate, categoryId: $categoryId, type: $type, searchText: $searchText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyFilterImpl &&
            (identical(other.fromDate, fromDate) ||
                other.fromDate == fromDate) &&
            (identical(other.toDate, toDate) || other.toDate == toDate) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fromDate, toDate, categoryId, type, searchText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyFilterImplCopyWith<_$ApplyFilterImpl> get copyWith =>
      __$$ApplyFilterImplCopyWithImpl<_$ApplyFilterImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(DateTime? fromDate, DateTime? toDate,
            String? categoryId, TransactionType? type, String? searchText)
        applyFilter,
    required TResult Function(String id) softDelete,
  }) {
    return applyFilter(fromDate, toDate, categoryId, type, searchText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult? Function(String id)? softDelete,
  }) {
    return applyFilter?.call(fromDate, toDate, categoryId, type, searchText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult Function(String id)? softDelete,
    required TResult orElse(),
  }) {
    if (applyFilter != null) {
      return applyFilter(fromDate, toDate, categoryId, type, searchText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ApplyFilter value) applyFilter,
    required TResult Function(_SoftDelete value) softDelete,
  }) {
    return applyFilter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ApplyFilter value)? applyFilter,
    TResult? Function(_SoftDelete value)? softDelete,
  }) {
    return applyFilter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ApplyFilter value)? applyFilter,
    TResult Function(_SoftDelete value)? softDelete,
    required TResult orElse(),
  }) {
    if (applyFilter != null) {
      return applyFilter(this);
    }
    return orElse();
  }
}

abstract class _ApplyFilter implements LedgerEvent {
  const factory _ApplyFilter(
      {final DateTime? fromDate,
      final DateTime? toDate,
      final String? categoryId,
      final TransactionType? type,
      final String? searchText}) = _$ApplyFilterImpl;

  DateTime? get fromDate;
  DateTime? get toDate;
  String? get categoryId;
  TransactionType? get type;
  String? get searchText;
  @JsonKey(ignore: true)
  _$$ApplyFilterImplCopyWith<_$ApplyFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SoftDeleteImplCopyWith<$Res> {
  factory _$$SoftDeleteImplCopyWith(
          _$SoftDeleteImpl value, $Res Function(_$SoftDeleteImpl) then) =
      __$$SoftDeleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$SoftDeleteImplCopyWithImpl<$Res>
    extends _$LedgerEventCopyWithImpl<$Res, _$SoftDeleteImpl>
    implements _$$SoftDeleteImplCopyWith<$Res> {
  __$$SoftDeleteImplCopyWithImpl(
      _$SoftDeleteImpl _value, $Res Function(_$SoftDeleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$SoftDeleteImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SoftDeleteImpl implements _SoftDelete {
  const _$SoftDeleteImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'LedgerEvent.softDelete(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SoftDeleteImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SoftDeleteImplCopyWith<_$SoftDeleteImpl> get copyWith =>
      __$$SoftDeleteImplCopyWithImpl<_$SoftDeleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() loadMore,
    required TResult Function(DateTime? fromDate, DateTime? toDate,
            String? categoryId, TransactionType? type, String? searchText)
        applyFilter,
    required TResult Function(String id) softDelete,
  }) {
    return softDelete(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function()? loadMore,
    TResult? Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult? Function(String id)? softDelete,
  }) {
    return softDelete?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? loadMore,
    TResult Function(DateTime? fromDate, DateTime? toDate, String? categoryId,
            TransactionType? type, String? searchText)?
        applyFilter,
    TResult Function(String id)? softDelete,
    required TResult orElse(),
  }) {
    if (softDelete != null) {
      return softDelete(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_LoadMore value) loadMore,
    required TResult Function(_ApplyFilter value) applyFilter,
    required TResult Function(_SoftDelete value) softDelete,
  }) {
    return softDelete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_LoadMore value)? loadMore,
    TResult? Function(_ApplyFilter value)? applyFilter,
    TResult? Function(_SoftDelete value)? softDelete,
  }) {
    return softDelete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_LoadMore value)? loadMore,
    TResult Function(_ApplyFilter value)? applyFilter,
    TResult Function(_SoftDelete value)? softDelete,
    required TResult orElse(),
  }) {
    if (softDelete != null) {
      return softDelete(this);
    }
    return orElse();
  }
}

abstract class _SoftDelete implements LedgerEvent {
  const factory _SoftDelete(final String id) = _$SoftDeleteImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$SoftDeleteImplCopyWith<_$SoftDeleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LedgerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Failure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Failure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerStateCopyWith<$Res> {
  factory $LedgerStateCopyWith(
          LedgerState value, $Res Function(LedgerState) then) =
      _$LedgerStateCopyWithImpl<$Res, LedgerState>;
}

/// @nodoc
class _$LedgerStateCopyWithImpl<$Res, $Val extends LedgerState>
    implements $LedgerStateCopyWith<$Res> {
  _$LedgerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LedgerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'LedgerState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Failure value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Failure value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LedgerState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$LedgerStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LedgerState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Failure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Failure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements LedgerState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TransactionEntity> transactions, bool hasMore, int page});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LedgerStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? hasMore = null,
    Object? page = null,
  }) {
    return _then(_$LoadedImpl(
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionEntity>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<TransactionEntity> transactions,
      required this.hasMore,
      required this.page})
      : _transactions = transactions;

  final List<TransactionEntity> _transactions;
  @override
  List<TransactionEntity> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final bool hasMore;
  @override
  final int page;

  @override
  String toString() {
    return 'LedgerState.loaded(transactions: $transactions, hasMore: $hasMore, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_transactions), hasMore, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return loaded(transactions, hasMore, page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(transactions, hasMore, page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(transactions, hasMore, page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Failure value) failure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Failure value)? failure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements LedgerState {
  const factory _Loaded(
      {required final List<TransactionEntity> transactions,
      required final bool hasMore,
      required final int page}) = _$LoadedImpl;

  List<TransactionEntity> get transactions;
  bool get hasMore;
  int get page;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$LedgerStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'LedgerState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<TransactionEntity> transactions, bool hasMore, int page)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Failure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Failure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Failure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements LedgerState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
