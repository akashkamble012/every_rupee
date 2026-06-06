// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insights_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InsightsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightsEventCopyWith<$Res> {
  factory $InsightsEventCopyWith(
          InsightsEvent value, $Res Function(InsightsEvent) then) =
      _$InsightsEventCopyWithImpl<$Res, InsightsEvent>;
}

/// @nodoc
class _$InsightsEventCopyWithImpl<$Res, $Val extends InsightsEvent>
    implements $InsightsEventCopyWith<$Res> {
  _$InsightsEventCopyWithImpl(this._value, this._then);

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
  @useResult
  $Res call({DateTime month});
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$InsightsEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
  }) {
    return _then(_$LoadImpl(
      null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl(this.month);

  @override
  final DateTime month;

  @override
  String toString() {
    return 'InsightsEvent.load(month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadImpl &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, month);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      __$$LoadImplCopyWithImpl<_$LoadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
  }) {
    return load(month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
  }) {
    return load?.call(month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements InsightsEvent {
  const factory _Load(final DateTime month) = _$LoadImpl;

  DateTime get month;
  @JsonKey(ignore: true)
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PreviousMonthImplCopyWith<$Res> {
  factory _$$PreviousMonthImplCopyWith(
          _$PreviousMonthImpl value, $Res Function(_$PreviousMonthImpl) then) =
      __$$PreviousMonthImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PreviousMonthImplCopyWithImpl<$Res>
    extends _$InsightsEventCopyWithImpl<$Res, _$PreviousMonthImpl>
    implements _$$PreviousMonthImplCopyWith<$Res> {
  __$$PreviousMonthImplCopyWithImpl(
      _$PreviousMonthImpl _value, $Res Function(_$PreviousMonthImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PreviousMonthImpl implements _PreviousMonth {
  const _$PreviousMonthImpl();

  @override
  String toString() {
    return 'InsightsEvent.previousMonth()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PreviousMonthImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
  }) {
    return previousMonth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
  }) {
    return previousMonth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    required TResult orElse(),
  }) {
    if (previousMonth != null) {
      return previousMonth();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
  }) {
    return previousMonth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
  }) {
    return previousMonth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    required TResult orElse(),
  }) {
    if (previousMonth != null) {
      return previousMonth(this);
    }
    return orElse();
  }
}

abstract class _PreviousMonth implements InsightsEvent {
  const factory _PreviousMonth() = _$PreviousMonthImpl;
}

/// @nodoc
abstract class _$$NextMonthImplCopyWith<$Res> {
  factory _$$NextMonthImplCopyWith(
          _$NextMonthImpl value, $Res Function(_$NextMonthImpl) then) =
      __$$NextMonthImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NextMonthImplCopyWithImpl<$Res>
    extends _$InsightsEventCopyWithImpl<$Res, _$NextMonthImpl>
    implements _$$NextMonthImplCopyWith<$Res> {
  __$$NextMonthImplCopyWithImpl(
      _$NextMonthImpl _value, $Res Function(_$NextMonthImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NextMonthImpl implements _NextMonth {
  const _$NextMonthImpl();

  @override
  String toString() {
    return 'InsightsEvent.nextMonth()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NextMonthImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
  }) {
    return nextMonth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
  }) {
    return nextMonth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    required TResult orElse(),
  }) {
    if (nextMonth != null) {
      return nextMonth();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
  }) {
    return nextMonth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
  }) {
    return nextMonth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    required TResult orElse(),
  }) {
    if (nextMonth != null) {
      return nextMonth(this);
    }
    return orElse();
  }
}

abstract class _NextMonth implements InsightsEvent {
  const factory _NextMonth() = _$NextMonthImpl;
}

/// @nodoc
mixin _$InsightsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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
abstract class $InsightsStateCopyWith<$Res> {
  factory $InsightsStateCopyWith(
          InsightsState value, $Res Function(InsightsState) then) =
      _$InsightsStateCopyWithImpl<$Res, InsightsState>;
}

/// @nodoc
class _$InsightsStateCopyWithImpl<$Res, $Val extends InsightsState>
    implements $InsightsStateCopyWith<$Res> {
  _$InsightsStateCopyWithImpl(this._value, this._then);

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
    extends _$InsightsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'InsightsState.initial()';
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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

abstract class _Initial implements InsightsState {
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
    extends _$InsightsStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'InsightsState.loading()';
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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

abstract class _Loading implements InsightsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {DateTime month,
      List<TransactionEntity> currentMonthTransactions,
      List<MonthlySurplusEntity> wealthHistory,
      List<List<CategoryVarianceEntity>> historicalVariances});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$InsightsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? currentMonthTransactions = null,
    Object? wealthHistory = null,
    Object? historicalVariances = null,
  }) {
    return _then(_$LoadedImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentMonthTransactions: null == currentMonthTransactions
          ? _value._currentMonthTransactions
          : currentMonthTransactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionEntity>,
      wealthHistory: null == wealthHistory
          ? _value._wealthHistory
          : wealthHistory // ignore: cast_nullable_to_non_nullable
              as List<MonthlySurplusEntity>,
      historicalVariances: null == historicalVariances
          ? _value._historicalVariances
          : historicalVariances // ignore: cast_nullable_to_non_nullable
              as List<List<CategoryVarianceEntity>>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.month,
      required final List<TransactionEntity> currentMonthTransactions,
      required final List<MonthlySurplusEntity> wealthHistory,
      required final List<List<CategoryVarianceEntity>> historicalVariances})
      : _currentMonthTransactions = currentMonthTransactions,
        _wealthHistory = wealthHistory,
        _historicalVariances = historicalVariances;

  @override
  final DateTime month;
  final List<TransactionEntity> _currentMonthTransactions;
  @override
  List<TransactionEntity> get currentMonthTransactions {
    if (_currentMonthTransactions is EqualUnmodifiableListView)
      return _currentMonthTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentMonthTransactions);
  }

  final List<MonthlySurplusEntity> _wealthHistory;
  @override
  List<MonthlySurplusEntity> get wealthHistory {
    if (_wealthHistory is EqualUnmodifiableListView) return _wealthHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wealthHistory);
  }

  final List<List<CategoryVarianceEntity>> _historicalVariances;
  @override
  List<List<CategoryVarianceEntity>> get historicalVariances {
    if (_historicalVariances is EqualUnmodifiableListView)
      return _historicalVariances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalVariances);
  }

  @override
  String toString() {
    return 'InsightsState.loaded(month: $month, currentMonthTransactions: $currentMonthTransactions, wealthHistory: $wealthHistory, historicalVariances: $historicalVariances)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.month, month) || other.month == month) &&
            const DeepCollectionEquality().equals(
                other._currentMonthTransactions, _currentMonthTransactions) &&
            const DeepCollectionEquality()
                .equals(other._wealthHistory, _wealthHistory) &&
            const DeepCollectionEquality()
                .equals(other._historicalVariances, _historicalVariances));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      month,
      const DeepCollectionEquality().hash(_currentMonthTransactions),
      const DeepCollectionEquality().hash(_wealthHistory),
      const DeepCollectionEquality().hash(_historicalVariances));

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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return loaded(
        month, currentMonthTransactions, wealthHistory, historicalVariances);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(
        month, currentMonthTransactions, wealthHistory, historicalVariances);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          month, currentMonthTransactions, wealthHistory, historicalVariances);
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

abstract class _Loaded implements InsightsState {
  const factory _Loaded(
      {required final DateTime month,
      required final List<TransactionEntity> currentMonthTransactions,
      required final List<MonthlySurplusEntity> wealthHistory,
      required final List<List<CategoryVarianceEntity>>
          historicalVariances}) = _$LoadedImpl;

  DateTime get month;
  List<TransactionEntity> get currentMonthTransactions;
  List<MonthlySurplusEntity> get wealthHistory;
  List<List<CategoryVarianceEntity>> get historicalVariances;
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
    extends _$InsightsStateCopyWithImpl<$Res, _$FailureImpl>
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
    return 'InsightsState.failure(message: $message)';
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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
            DateTime month,
            List<TransactionEntity> currentMonthTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances)?
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

abstract class _Failure implements InsightsState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
