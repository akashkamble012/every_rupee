// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoadmapEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int monthsToProject) load,
    required TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)
        saveOverride,
    required TResult Function(TemporaryOutflowEntity outflow)
        saveTemporaryOutflow,
    required TResult Function(String id) deleteTemporaryOutflow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int monthsToProject)? load,
    TResult? Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult? Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult? Function(String id)? deleteTemporaryOutflow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int monthsToProject)? load,
    TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult Function(String id)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveOverride value) saveOverride,
    required TResult Function(_SaveTemporaryOutflow value) saveTemporaryOutflow,
    required TResult Function(_DeleteTemporaryOutflow value)
        deleteTemporaryOutflow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveOverride value)? saveOverride,
    TResult? Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult? Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveOverride value)? saveOverride,
    TResult Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadmapEventCopyWith<$Res> {
  factory $RoadmapEventCopyWith(
          RoadmapEvent value, $Res Function(RoadmapEvent) then) =
      _$RoadmapEventCopyWithImpl<$Res, RoadmapEvent>;
}

/// @nodoc
class _$RoadmapEventCopyWithImpl<$Res, $Val extends RoadmapEvent>
    implements $RoadmapEventCopyWith<$Res> {
  _$RoadmapEventCopyWithImpl(this._value, this._then);

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
  $Res call({int monthsToProject});
}

/// @nodoc
class __$$LoadImplCopyWithImpl<$Res>
    extends _$RoadmapEventCopyWithImpl<$Res, _$LoadImpl>
    implements _$$LoadImplCopyWith<$Res> {
  __$$LoadImplCopyWithImpl(_$LoadImpl _value, $Res Function(_$LoadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthsToProject = null,
  }) {
    return _then(_$LoadImpl(
      monthsToProject: null == monthsToProject
          ? _value.monthsToProject
          : monthsToProject // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadImpl implements _Load {
  const _$LoadImpl({this.monthsToProject = 12});

  @override
  @JsonKey()
  final int monthsToProject;

  @override
  String toString() {
    return 'RoadmapEvent.load(monthsToProject: $monthsToProject)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadImpl &&
            (identical(other.monthsToProject, monthsToProject) ||
                other.monthsToProject == monthsToProject));
  }

  @override
  int get hashCode => Object.hash(runtimeType, monthsToProject);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      __$$LoadImplCopyWithImpl<_$LoadImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int monthsToProject) load,
    required TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)
        saveOverride,
    required TResult Function(TemporaryOutflowEntity outflow)
        saveTemporaryOutflow,
    required TResult Function(String id) deleteTemporaryOutflow,
  }) {
    return load(monthsToProject);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int monthsToProject)? load,
    TResult? Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult? Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult? Function(String id)? deleteTemporaryOutflow,
  }) {
    return load?.call(monthsToProject);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int monthsToProject)? load,
    TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult Function(String id)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(monthsToProject);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveOverride value) saveOverride,
    required TResult Function(_SaveTemporaryOutflow value) saveTemporaryOutflow,
    required TResult Function(_DeleteTemporaryOutflow value)
        deleteTemporaryOutflow,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveOverride value)? saveOverride,
    TResult? Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult? Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveOverride value)? saveOverride,
    TResult Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements RoadmapEvent {
  const factory _Load({final int monthsToProject}) = _$LoadImpl;

  int get monthsToProject;
  @JsonKey(ignore: true)
  _$$LoadImplCopyWith<_$LoadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveOverrideImplCopyWith<$Res> {
  factory _$$SaveOverrideImplCopyWith(
          _$SaveOverrideImpl value, $Res Function(_$SaveOverrideImpl) then) =
      __$$SaveOverrideImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {DateTime month,
      double? netIncomeOverride,
      double? coreFixedExpensesOverride,
      String? actionPlan});
}

/// @nodoc
class __$$SaveOverrideImplCopyWithImpl<$Res>
    extends _$RoadmapEventCopyWithImpl<$Res, _$SaveOverrideImpl>
    implements _$$SaveOverrideImplCopyWith<$Res> {
  __$$SaveOverrideImplCopyWithImpl(
      _$SaveOverrideImpl _value, $Res Function(_$SaveOverrideImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? netIncomeOverride = freezed,
    Object? coreFixedExpensesOverride = freezed,
    Object? actionPlan = freezed,
  }) {
    return _then(_$SaveOverrideImpl(
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
    ));
  }
}

/// @nodoc

class _$SaveOverrideImpl implements _SaveOverride {
  const _$SaveOverrideImpl(
      {required this.month,
      this.netIncomeOverride,
      this.coreFixedExpensesOverride,
      this.actionPlan});

  @override
  final DateTime month;
  @override
  final double? netIncomeOverride;
  @override
  final double? coreFixedExpensesOverride;
  @override
  final String? actionPlan;

  @override
  String toString() {
    return 'RoadmapEvent.saveOverride(month: $month, netIncomeOverride: $netIncomeOverride, coreFixedExpensesOverride: $coreFixedExpensesOverride, actionPlan: $actionPlan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveOverrideImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.netIncomeOverride, netIncomeOverride) ||
                other.netIncomeOverride == netIncomeOverride) &&
            (identical(other.coreFixedExpensesOverride,
                    coreFixedExpensesOverride) ||
                other.coreFixedExpensesOverride == coreFixedExpensesOverride) &&
            (identical(other.actionPlan, actionPlan) ||
                other.actionPlan == actionPlan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, month, netIncomeOverride,
      coreFixedExpensesOverride, actionPlan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveOverrideImplCopyWith<_$SaveOverrideImpl> get copyWith =>
      __$$SaveOverrideImplCopyWithImpl<_$SaveOverrideImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int monthsToProject) load,
    required TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)
        saveOverride,
    required TResult Function(TemporaryOutflowEntity outflow)
        saveTemporaryOutflow,
    required TResult Function(String id) deleteTemporaryOutflow,
  }) {
    return saveOverride(
        month, netIncomeOverride, coreFixedExpensesOverride, actionPlan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int monthsToProject)? load,
    TResult? Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult? Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult? Function(String id)? deleteTemporaryOutflow,
  }) {
    return saveOverride?.call(
        month, netIncomeOverride, coreFixedExpensesOverride, actionPlan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int monthsToProject)? load,
    TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult Function(String id)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (saveOverride != null) {
      return saveOverride(
          month, netIncomeOverride, coreFixedExpensesOverride, actionPlan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveOverride value) saveOverride,
    required TResult Function(_SaveTemporaryOutflow value) saveTemporaryOutflow,
    required TResult Function(_DeleteTemporaryOutflow value)
        deleteTemporaryOutflow,
  }) {
    return saveOverride(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveOverride value)? saveOverride,
    TResult? Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult? Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
  }) {
    return saveOverride?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveOverride value)? saveOverride,
    TResult Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (saveOverride != null) {
      return saveOverride(this);
    }
    return orElse();
  }
}

abstract class _SaveOverride implements RoadmapEvent {
  const factory _SaveOverride(
      {required final DateTime month,
      final double? netIncomeOverride,
      final double? coreFixedExpensesOverride,
      final String? actionPlan}) = _$SaveOverrideImpl;

  DateTime get month;
  double? get netIncomeOverride;
  double? get coreFixedExpensesOverride;
  String? get actionPlan;
  @JsonKey(ignore: true)
  _$$SaveOverrideImplCopyWith<_$SaveOverrideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveTemporaryOutflowImplCopyWith<$Res> {
  factory _$$SaveTemporaryOutflowImplCopyWith(_$SaveTemporaryOutflowImpl value,
          $Res Function(_$SaveTemporaryOutflowImpl) then) =
      __$$SaveTemporaryOutflowImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TemporaryOutflowEntity outflow});

  $TemporaryOutflowEntityCopyWith<$Res> get outflow;
}

/// @nodoc
class __$$SaveTemporaryOutflowImplCopyWithImpl<$Res>
    extends _$RoadmapEventCopyWithImpl<$Res, _$SaveTemporaryOutflowImpl>
    implements _$$SaveTemporaryOutflowImplCopyWith<$Res> {
  __$$SaveTemporaryOutflowImplCopyWithImpl(_$SaveTemporaryOutflowImpl _value,
      $Res Function(_$SaveTemporaryOutflowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outflow = null,
  }) {
    return _then(_$SaveTemporaryOutflowImpl(
      outflow: null == outflow
          ? _value.outflow
          : outflow // ignore: cast_nullable_to_non_nullable
              as TemporaryOutflowEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TemporaryOutflowEntityCopyWith<$Res> get outflow {
    return $TemporaryOutflowEntityCopyWith<$Res>(_value.outflow, (value) {
      return _then(_value.copyWith(outflow: value));
    });
  }
}

/// @nodoc

class _$SaveTemporaryOutflowImpl implements _SaveTemporaryOutflow {
  const _$SaveTemporaryOutflowImpl({required this.outflow});

  @override
  final TemporaryOutflowEntity outflow;

  @override
  String toString() {
    return 'RoadmapEvent.saveTemporaryOutflow(outflow: $outflow)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveTemporaryOutflowImpl &&
            (identical(other.outflow, outflow) || other.outflow == outflow));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outflow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveTemporaryOutflowImplCopyWith<_$SaveTemporaryOutflowImpl>
      get copyWith =>
          __$$SaveTemporaryOutflowImplCopyWithImpl<_$SaveTemporaryOutflowImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int monthsToProject) load,
    required TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)
        saveOverride,
    required TResult Function(TemporaryOutflowEntity outflow)
        saveTemporaryOutflow,
    required TResult Function(String id) deleteTemporaryOutflow,
  }) {
    return saveTemporaryOutflow(outflow);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int monthsToProject)? load,
    TResult? Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult? Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult? Function(String id)? deleteTemporaryOutflow,
  }) {
    return saveTemporaryOutflow?.call(outflow);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int monthsToProject)? load,
    TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult Function(String id)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (saveTemporaryOutflow != null) {
      return saveTemporaryOutflow(outflow);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveOverride value) saveOverride,
    required TResult Function(_SaveTemporaryOutflow value) saveTemporaryOutflow,
    required TResult Function(_DeleteTemporaryOutflow value)
        deleteTemporaryOutflow,
  }) {
    return saveTemporaryOutflow(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveOverride value)? saveOverride,
    TResult? Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult? Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
  }) {
    return saveTemporaryOutflow?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveOverride value)? saveOverride,
    TResult Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (saveTemporaryOutflow != null) {
      return saveTemporaryOutflow(this);
    }
    return orElse();
  }
}

abstract class _SaveTemporaryOutflow implements RoadmapEvent {
  const factory _SaveTemporaryOutflow(
          {required final TemporaryOutflowEntity outflow}) =
      _$SaveTemporaryOutflowImpl;

  TemporaryOutflowEntity get outflow;
  @JsonKey(ignore: true)
  _$$SaveTemporaryOutflowImplCopyWith<_$SaveTemporaryOutflowImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTemporaryOutflowImplCopyWith<$Res> {
  factory _$$DeleteTemporaryOutflowImplCopyWith(
          _$DeleteTemporaryOutflowImpl value,
          $Res Function(_$DeleteTemporaryOutflowImpl) then) =
      __$$DeleteTemporaryOutflowImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteTemporaryOutflowImplCopyWithImpl<$Res>
    extends _$RoadmapEventCopyWithImpl<$Res, _$DeleteTemporaryOutflowImpl>
    implements _$$DeleteTemporaryOutflowImplCopyWith<$Res> {
  __$$DeleteTemporaryOutflowImplCopyWithImpl(
      _$DeleteTemporaryOutflowImpl _value,
      $Res Function(_$DeleteTemporaryOutflowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$DeleteTemporaryOutflowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteTemporaryOutflowImpl implements _DeleteTemporaryOutflow {
  const _$DeleteTemporaryOutflowImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'RoadmapEvent.deleteTemporaryOutflow(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTemporaryOutflowImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTemporaryOutflowImplCopyWith<_$DeleteTemporaryOutflowImpl>
      get copyWith => __$$DeleteTemporaryOutflowImplCopyWithImpl<
          _$DeleteTemporaryOutflowImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int monthsToProject) load,
    required TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)
        saveOverride,
    required TResult Function(TemporaryOutflowEntity outflow)
        saveTemporaryOutflow,
    required TResult Function(String id) deleteTemporaryOutflow,
  }) {
    return deleteTemporaryOutflow(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int monthsToProject)? load,
    TResult? Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult? Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult? Function(String id)? deleteTemporaryOutflow,
  }) {
    return deleteTemporaryOutflow?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int monthsToProject)? load,
    TResult Function(DateTime month, double? netIncomeOverride,
            double? coreFixedExpensesOverride, String? actionPlan)?
        saveOverride,
    TResult Function(TemporaryOutflowEntity outflow)? saveTemporaryOutflow,
    TResult Function(String id)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (deleteTemporaryOutflow != null) {
      return deleteTemporaryOutflow(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_SaveOverride value) saveOverride,
    required TResult Function(_SaveTemporaryOutflow value) saveTemporaryOutflow,
    required TResult Function(_DeleteTemporaryOutflow value)
        deleteTemporaryOutflow,
  }) {
    return deleteTemporaryOutflow(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Load value)? load,
    TResult? Function(_SaveOverride value)? saveOverride,
    TResult? Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult? Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
  }) {
    return deleteTemporaryOutflow?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_SaveOverride value)? saveOverride,
    TResult Function(_SaveTemporaryOutflow value)? saveTemporaryOutflow,
    TResult Function(_DeleteTemporaryOutflow value)? deleteTemporaryOutflow,
    required TResult orElse(),
  }) {
    if (deleteTemporaryOutflow != null) {
      return deleteTemporaryOutflow(this);
    }
    return orElse();
  }
}

abstract class _DeleteTemporaryOutflow implements RoadmapEvent {
  const factory _DeleteTemporaryOutflow({required final String id}) =
      _$DeleteTemporaryOutflowImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$DeleteTemporaryOutflowImplCopyWith<_$DeleteTemporaryOutflowImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoadmapState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)
        loaded,
    required TResult Function(String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
        loaded,
    TResult? Function(String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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
abstract class $RoadmapStateCopyWith<$Res> {
  factory $RoadmapStateCopyWith(
          RoadmapState value, $Res Function(RoadmapState) then) =
      _$RoadmapStateCopyWithImpl<$Res, RoadmapState>;
}

/// @nodoc
class _$RoadmapStateCopyWithImpl<$Res, $Val extends RoadmapState>
    implements $RoadmapStateCopyWith<$Res> {
  _$RoadmapStateCopyWithImpl(this._value, this._then);

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
    extends _$RoadmapStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'RoadmapState.initial()';
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
    required TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)
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
    TResult? Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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
    TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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

abstract class _Initial implements RoadmapState {
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
    extends _$RoadmapStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'RoadmapState.loading()';
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
    required TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)
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
    TResult? Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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
    TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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

abstract class _Loading implements RoadmapState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<RoadmapDisplayEntity> projectedMonths,
      List<TemporaryOutflowEntity> temporaryOutflows});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$RoadmapStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectedMonths = null,
    Object? temporaryOutflows = null,
  }) {
    return _then(_$LoadedImpl(
      projectedMonths: null == projectedMonths
          ? _value._projectedMonths
          : projectedMonths // ignore: cast_nullable_to_non_nullable
              as List<RoadmapDisplayEntity>,
      temporaryOutflows: null == temporaryOutflows
          ? _value._temporaryOutflows
          : temporaryOutflows // ignore: cast_nullable_to_non_nullable
              as List<TemporaryOutflowEntity>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<RoadmapDisplayEntity> projectedMonths,
      required final List<TemporaryOutflowEntity> temporaryOutflows})
      : _projectedMonths = projectedMonths,
        _temporaryOutflows = temporaryOutflows;

  final List<RoadmapDisplayEntity> _projectedMonths;
  @override
  List<RoadmapDisplayEntity> get projectedMonths {
    if (_projectedMonths is EqualUnmodifiableListView) return _projectedMonths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projectedMonths);
  }

  final List<TemporaryOutflowEntity> _temporaryOutflows;
  @override
  List<TemporaryOutflowEntity> get temporaryOutflows {
    if (_temporaryOutflows is EqualUnmodifiableListView)
      return _temporaryOutflows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_temporaryOutflows);
  }

  @override
  String toString() {
    return 'RoadmapState.loaded(projectedMonths: $projectedMonths, temporaryOutflows: $temporaryOutflows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._projectedMonths, _projectedMonths) &&
            const DeepCollectionEquality()
                .equals(other._temporaryOutflows, _temporaryOutflows));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_projectedMonths),
      const DeepCollectionEquality().hash(_temporaryOutflows));

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
    required TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)
        loaded,
    required TResult Function(String message) failure,
  }) {
    return loaded(projectedMonths, temporaryOutflows);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
        loaded,
    TResult? Function(String message)? failure,
  }) {
    return loaded?.call(projectedMonths, temporaryOutflows);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
        loaded,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(projectedMonths, temporaryOutflows);
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

abstract class _Loaded implements RoadmapState {
  const factory _Loaded(
          {required final List<RoadmapDisplayEntity> projectedMonths,
          required final List<TemporaryOutflowEntity> temporaryOutflows}) =
      _$LoadedImpl;

  List<RoadmapDisplayEntity> get projectedMonths;
  List<TemporaryOutflowEntity> get temporaryOutflows;
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
    extends _$RoadmapStateCopyWithImpl<$Res, _$FailureImpl>
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
    return 'RoadmapState.failure(message: $message)';
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
    required TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)
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
    TResult? Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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
    TResult Function(List<RoadmapDisplayEntity> projectedMonths,
            List<TemporaryOutflowEntity> temporaryOutflows)?
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

abstract class _Failure implements RoadmapState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
