// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventCopyWith<$Res> {
  factory $DashboardEventCopyWith(
          DashboardEvent value, $Res Function(DashboardEvent) then) =
      _$DashboardEventCopyWithImpl<$Res, DashboardEvent>;
}

/// @nodoc
class _$DashboardEventCopyWithImpl<$Res, $Val extends DashboardEvent>
    implements $DashboardEventCopyWith<$Res> {
  _$DashboardEventCopyWithImpl(this._value, this._then);

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
    extends _$DashboardEventCopyWithImpl<$Res, _$LoadImpl>
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
    return 'DashboardEvent.load(month: $month)';
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
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) {
    return load(month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) {
    return load?.call(month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
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
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements DashboardEvent {
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
    extends _$DashboardEventCopyWithImpl<$Res, _$PreviousMonthImpl>
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
    return 'DashboardEvent.previousMonth()';
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
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) {
    return previousMonth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) {
    return previousMonth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
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
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) {
    return previousMonth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) {
    return previousMonth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (previousMonth != null) {
      return previousMonth(this);
    }
    return orElse();
  }
}

abstract class _PreviousMonth implements DashboardEvent {
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
    extends _$DashboardEventCopyWithImpl<$Res, _$NextMonthImpl>
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
    return 'DashboardEvent.nextMonth()';
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
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) {
    return nextMonth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) {
    return nextMonth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
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
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) {
    return nextMonth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) {
    return nextMonth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (nextMonth != null) {
      return nextMonth(this);
    }
    return orElse();
  }
}

abstract class _NextMonth implements DashboardEvent {
  const factory _NextMonth() = _$NextMonthImpl;
}

/// @nodoc
abstract class _$$ChangeSortPreferenceImplCopyWith<$Res> {
  factory _$$ChangeSortPreferenceImplCopyWith(_$ChangeSortPreferenceImpl value,
          $Res Function(_$ChangeSortPreferenceImpl) then) =
      __$$ChangeSortPreferenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String preference});
}

/// @nodoc
class __$$ChangeSortPreferenceImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$ChangeSortPreferenceImpl>
    implements _$$ChangeSortPreferenceImplCopyWith<$Res> {
  __$$ChangeSortPreferenceImplCopyWithImpl(_$ChangeSortPreferenceImpl _value,
      $Res Function(_$ChangeSortPreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preference = null,
  }) {
    return _then(_$ChangeSortPreferenceImpl(
      null == preference
          ? _value.preference
          : preference // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeSortPreferenceImpl implements _ChangeSortPreference {
  const _$ChangeSortPreferenceImpl(this.preference);

  @override
  final String preference;

  @override
  String toString() {
    return 'DashboardEvent.changeSortPreference(preference: $preference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeSortPreferenceImpl &&
            (identical(other.preference, preference) ||
                other.preference == preference));
  }

  @override
  int get hashCode => Object.hash(runtimeType, preference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeSortPreferenceImplCopyWith<_$ChangeSortPreferenceImpl>
      get copyWith =>
          __$$ChangeSortPreferenceImplCopyWithImpl<_$ChangeSortPreferenceImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) {
    return changeSortPreference(preference);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) {
    return changeSortPreference?.call(preference);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (changeSortPreference != null) {
      return changeSortPreference(preference);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) {
    return changeSortPreference(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) {
    return changeSortPreference?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (changeSortPreference != null) {
      return changeSortPreference(this);
    }
    return orElse();
  }
}

abstract class _ChangeSortPreference implements DashboardEvent {
  const factory _ChangeSortPreference(final String preference) =
      _$ChangeSortPreferenceImpl;

  String get preference;
  @JsonKey(ignore: true)
  _$$ChangeSortPreferenceImplCopyWith<_$ChangeSortPreferenceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeTransactionSortPreferenceImplCopyWith<$Res> {
  factory _$$ChangeTransactionSortPreferenceImplCopyWith(
          _$ChangeTransactionSortPreferenceImpl value,
          $Res Function(_$ChangeTransactionSortPreferenceImpl) then) =
      __$$ChangeTransactionSortPreferenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String preference});
}

/// @nodoc
class __$$ChangeTransactionSortPreferenceImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res,
        _$ChangeTransactionSortPreferenceImpl>
    implements _$$ChangeTransactionSortPreferenceImplCopyWith<$Res> {
  __$$ChangeTransactionSortPreferenceImplCopyWithImpl(
      _$ChangeTransactionSortPreferenceImpl _value,
      $Res Function(_$ChangeTransactionSortPreferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? preference = null,
  }) {
    return _then(_$ChangeTransactionSortPreferenceImpl(
      null == preference
          ? _value.preference
          : preference // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeTransactionSortPreferenceImpl
    implements _ChangeTransactionSortPreference {
  const _$ChangeTransactionSortPreferenceImpl(this.preference);

  @override
  final String preference;

  @override
  String toString() {
    return 'DashboardEvent.changeTransactionSortPreference(preference: $preference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeTransactionSortPreferenceImpl &&
            (identical(other.preference, preference) ||
                other.preference == preference));
  }

  @override
  int get hashCode => Object.hash(runtimeType, preference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeTransactionSortPreferenceImplCopyWith<
          _$ChangeTransactionSortPreferenceImpl>
      get copyWith => __$$ChangeTransactionSortPreferenceImplCopyWithImpl<
          _$ChangeTransactionSortPreferenceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) {
    return changeTransactionSortPreference(preference);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) {
    return changeTransactionSortPreference?.call(preference);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (changeTransactionSortPreference != null) {
      return changeTransactionSortPreference(preference);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) {
    return changeTransactionSortPreference(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) {
    return changeTransactionSortPreference?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (changeTransactionSortPreference != null) {
      return changeTransactionSortPreference(this);
    }
    return orElse();
  }
}

abstract class _ChangeTransactionSortPreference implements DashboardEvent {
  const factory _ChangeTransactionSortPreference(final String preference) =
      _$ChangeTransactionSortPreferenceImpl;

  String get preference;
  @JsonKey(ignore: true)
  _$$ChangeTransactionSortPreferenceImplCopyWith<
          _$ChangeTransactionSortPreferenceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleDashboardChartImplCopyWith<$Res> {
  factory _$$ToggleDashboardChartImplCopyWith(_$ToggleDashboardChartImpl value,
          $Res Function(_$ToggleDashboardChartImpl) then) =
      __$$ToggleDashboardChartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String chartId});
}

/// @nodoc
class __$$ToggleDashboardChartImplCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$ToggleDashboardChartImpl>
    implements _$$ToggleDashboardChartImplCopyWith<$Res> {
  __$$ToggleDashboardChartImplCopyWithImpl(_$ToggleDashboardChartImpl _value,
      $Res Function(_$ToggleDashboardChartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chartId = null,
  }) {
    return _then(_$ToggleDashboardChartImpl(
      null == chartId
          ? _value.chartId
          : chartId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToggleDashboardChartImpl implements _ToggleDashboardChart {
  const _$ToggleDashboardChartImpl(this.chartId);

  @override
  final String chartId;

  @override
  String toString() {
    return 'DashboardEvent.toggleDashboardChart(chartId: $chartId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleDashboardChartImpl &&
            (identical(other.chartId, chartId) || other.chartId == chartId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chartId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleDashboardChartImplCopyWith<_$ToggleDashboardChartImpl>
      get copyWith =>
          __$$ToggleDashboardChartImplCopyWithImpl<_$ToggleDashboardChartImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime month) load,
    required TResult Function() previousMonth,
    required TResult Function() nextMonth,
    required TResult Function(String preference) changeSortPreference,
    required TResult Function(String preference)
        changeTransactionSortPreference,
    required TResult Function(String chartId) toggleDashboardChart,
  }) {
    return toggleDashboardChart(chartId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime month)? load,
    TResult? Function()? previousMonth,
    TResult? Function()? nextMonth,
    TResult? Function(String preference)? changeSortPreference,
    TResult? Function(String preference)? changeTransactionSortPreference,
    TResult? Function(String chartId)? toggleDashboardChart,
  }) {
    return toggleDashboardChart?.call(chartId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime month)? load,
    TResult Function()? previousMonth,
    TResult Function()? nextMonth,
    TResult Function(String preference)? changeSortPreference,
    TResult Function(String preference)? changeTransactionSortPreference,
    TResult Function(String chartId)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (toggleDashboardChart != null) {
      return toggleDashboardChart(chartId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_PreviousMonth value) previousMonth,
    required TResult Function(_NextMonth value) nextMonth,
    required TResult Function(_ChangeSortPreference value) changeSortPreference,
    required TResult Function(_ChangeTransactionSortPreference value)
        changeTransactionSortPreference,
    required TResult Function(_ToggleDashboardChart value) toggleDashboardChart,
  }) {
    return toggleDashboardChart(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_PreviousMonth value)? previousMonth,
    TResult? Function(_NextMonth value)? nextMonth,
    TResult? Function(_ChangeSortPreference value)? changeSortPreference,
    TResult? Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult? Function(_ToggleDashboardChart value)? toggleDashboardChart,
  }) {
    return toggleDashboardChart?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_PreviousMonth value)? previousMonth,
    TResult Function(_NextMonth value)? nextMonth,
    TResult Function(_ChangeSortPreference value)? changeSortPreference,
    TResult Function(_ChangeTransactionSortPreference value)?
        changeTransactionSortPreference,
    TResult Function(_ToggleDashboardChart value)? toggleDashboardChart,
    required TResult orElse(),
  }) {
    if (toggleDashboardChart != null) {
      return toggleDashboardChart(this);
    }
    return orElse();
  }
}

abstract class _ToggleDashboardChart implements DashboardEvent {
  const factory _ToggleDashboardChart(final String chartId) =
      _$ToggleDashboardChartImpl;

  String get chartId;
  @JsonKey(ignore: true)
  _$$ToggleDashboardChartImplCopyWith<_$ToggleDashboardChartImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DashboardState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            DateTime month,
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

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
    extends _$DashboardStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'DashboardState.initial()';
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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

abstract class _Initial implements DashboardState {
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
    extends _$DashboardStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'DashboardState.loading()';
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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

abstract class _Loading implements DashboardState {
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
      MonthlySurplusEntity surplus,
      List<CategoryVarianceEntity> variances,
      List<TransactionEntity> recentTransactions,
      List<MonthlySurplusEntity> wealthHistory,
      List<List<CategoryVarianceEntity>> historicalVariances,
      String sortPreference,
      String txSortPref,
      List<String> visibleCharts});

  $MonthlySurplusEntityCopyWith<$Res> get surplus;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? surplus = null,
    Object? variances = null,
    Object? recentTransactions = null,
    Object? wealthHistory = null,
    Object? historicalVariances = null,
    Object? sortPreference = null,
    Object? txSortPref = null,
    Object? visibleCharts = null,
  }) {
    return _then(_$LoadedImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      surplus: null == surplus
          ? _value.surplus
          : surplus // ignore: cast_nullable_to_non_nullable
              as MonthlySurplusEntity,
      variances: null == variances
          ? _value._variances
          : variances // ignore: cast_nullable_to_non_nullable
              as List<CategoryVarianceEntity>,
      recentTransactions: null == recentTransactions
          ? _value._recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionEntity>,
      wealthHistory: null == wealthHistory
          ? _value._wealthHistory
          : wealthHistory // ignore: cast_nullable_to_non_nullable
              as List<MonthlySurplusEntity>,
      historicalVariances: null == historicalVariances
          ? _value._historicalVariances
          : historicalVariances // ignore: cast_nullable_to_non_nullable
              as List<List<CategoryVarianceEntity>>,
      sortPreference: null == sortPreference
          ? _value.sortPreference
          : sortPreference // ignore: cast_nullable_to_non_nullable
              as String,
      txSortPref: null == txSortPref
          ? _value.txSortPref
          : txSortPref // ignore: cast_nullable_to_non_nullable
              as String,
      visibleCharts: null == visibleCharts
          ? _value._visibleCharts
          : visibleCharts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MonthlySurplusEntityCopyWith<$Res> get surplus {
    return $MonthlySurplusEntityCopyWith<$Res>(_value.surplus, (value) {
      return _then(_value.copyWith(surplus: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.month,
      required this.surplus,
      required final List<CategoryVarianceEntity> variances,
      required final List<TransactionEntity> recentTransactions,
      required final List<MonthlySurplusEntity> wealthHistory,
      required final List<List<CategoryVarianceEntity>> historicalVariances,
      required this.sortPreference,
      this.txSortPref = 'dateDesc',
      final List<String> visibleCharts = const []})
      : _variances = variances,
        _recentTransactions = recentTransactions,
        _wealthHistory = wealthHistory,
        _historicalVariances = historicalVariances,
        _visibleCharts = visibleCharts;

  @override
  final DateTime month;
  @override
  final MonthlySurplusEntity surplus;
  final List<CategoryVarianceEntity> _variances;
  @override
  List<CategoryVarianceEntity> get variances {
    if (_variances is EqualUnmodifiableListView) return _variances;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variances);
  }

  final List<TransactionEntity> _recentTransactions;
  @override
  List<TransactionEntity> get recentTransactions {
    if (_recentTransactions is EqualUnmodifiableListView)
      return _recentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransactions);
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
  final String sortPreference;
  @override
  @JsonKey()
  final String txSortPref;
  final List<String> _visibleCharts;
  @override
  @JsonKey()
  List<String> get visibleCharts {
    if (_visibleCharts is EqualUnmodifiableListView) return _visibleCharts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_visibleCharts);
  }

  @override
  String toString() {
    return 'DashboardState.loaded(month: $month, surplus: $surplus, variances: $variances, recentTransactions: $recentTransactions, wealthHistory: $wealthHistory, historicalVariances: $historicalVariances, sortPreference: $sortPreference, txSortPref: $txSortPref, visibleCharts: $visibleCharts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.surplus, surplus) || other.surplus == surplus) &&
            const DeepCollectionEquality()
                .equals(other._variances, _variances) &&
            const DeepCollectionEquality()
                .equals(other._recentTransactions, _recentTransactions) &&
            const DeepCollectionEquality()
                .equals(other._wealthHistory, _wealthHistory) &&
            const DeepCollectionEquality()
                .equals(other._historicalVariances, _historicalVariances) &&
            (identical(other.sortPreference, sortPreference) ||
                other.sortPreference == sortPreference) &&
            (identical(other.txSortPref, txSortPref) ||
                other.txSortPref == txSortPref) &&
            const DeepCollectionEquality()
                .equals(other._visibleCharts, _visibleCharts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      month,
      surplus,
      const DeepCollectionEquality().hash(_variances),
      const DeepCollectionEquality().hash(_recentTransactions),
      const DeepCollectionEquality().hash(_wealthHistory),
      const DeepCollectionEquality().hash(_historicalVariances),
      sortPreference,
      txSortPref,
      const DeepCollectionEquality().hash(_visibleCharts));

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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return loaded(month, surplus, variances, recentTransactions, wealthHistory,
        historicalVariances, sortPreference, txSortPref, visibleCharts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            DateTime month,
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(
        month,
        surplus,
        variances,
        recentTransactions,
        wealthHistory,
        historicalVariances,
        sortPreference,
        txSortPref,
        visibleCharts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            DateTime month,
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          month,
          surplus,
          variances,
          recentTransactions,
          wealthHistory,
          historicalVariances,
          sortPreference,
          txSortPref,
          visibleCharts);
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

abstract class _Loaded implements DashboardState {
  const factory _Loaded(
      {required final DateTime month,
      required final MonthlySurplusEntity surplus,
      required final List<CategoryVarianceEntity> variances,
      required final List<TransactionEntity> recentTransactions,
      required final List<MonthlySurplusEntity> wealthHistory,
      required final List<List<CategoryVarianceEntity>> historicalVariances,
      required final String sortPreference,
      final String txSortPref,
      final List<String> visibleCharts}) = _$LoadedImpl;

  DateTime get month;
  MonthlySurplusEntity get surplus;
  List<CategoryVarianceEntity> get variances;
  List<TransactionEntity> get recentTransactions;
  List<MonthlySurplusEntity> get wealthHistory;
  List<List<CategoryVarianceEntity>> get historicalVariances;
  String get sortPreference;
  String get txSortPref;
  List<String> get visibleCharts;
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
    extends _$DashboardStateCopyWithImpl<$Res, _$FailureImpl>
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
    return 'DashboardState.failure(message: $message)';
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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
            MonthlySurplusEntity surplus,
            List<CategoryVarianceEntity> variances,
            List<TransactionEntity> recentTransactions,
            List<MonthlySurplusEntity> wealthHistory,
            List<List<CategoryVarianceEntity>> historicalVariances,
            String sortPreference,
            String txSortPref,
            List<String> visibleCharts)?
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

abstract class _Failure implements DashboardState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
