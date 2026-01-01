// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BudgetAlert {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  double? get thresholdPercent => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Create a copy of BudgetAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetAlertCopyWith<BudgetAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetAlertCopyWith<$Res> {
  factory $BudgetAlertCopyWith(
          BudgetAlert value, $Res Function(BudgetAlert) then) =
      _$BudgetAlertCopyWithImpl<$Res, BudgetAlert>;
  @useResult
  $Res call(
      {String id,
      String type,
      String status,
      double? amount,
      double? thresholdPercent,
      DateTime createdAt,
      DateTime? resolvedAt});
}

/// @nodoc
class _$BudgetAlertCopyWithImpl<$Res, $Val extends BudgetAlert>
    implements $BudgetAlertCopyWith<$Res> {
  _$BudgetAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? amount = freezed,
    Object? thresholdPercent = freezed,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      thresholdPercent: freezed == thresholdPercent
          ? _value.thresholdPercent
          : thresholdPercent // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetAlertImplCopyWith<$Res>
    implements $BudgetAlertCopyWith<$Res> {
  factory _$$BudgetAlertImplCopyWith(
          _$BudgetAlertImpl value, $Res Function(_$BudgetAlertImpl) then) =
      __$$BudgetAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String status,
      double? amount,
      double? thresholdPercent,
      DateTime createdAt,
      DateTime? resolvedAt});
}

/// @nodoc
class __$$BudgetAlertImplCopyWithImpl<$Res>
    extends _$BudgetAlertCopyWithImpl<$Res, _$BudgetAlertImpl>
    implements _$$BudgetAlertImplCopyWith<$Res> {
  __$$BudgetAlertImplCopyWithImpl(
      _$BudgetAlertImpl _value, $Res Function(_$BudgetAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of BudgetAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? status = null,
    Object? amount = freezed,
    Object? thresholdPercent = freezed,
    Object? createdAt = null,
    Object? resolvedAt = freezed,
  }) {
    return _then(_$BudgetAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      thresholdPercent: freezed == thresholdPercent
          ? _value.thresholdPercent
          : thresholdPercent // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$BudgetAlertImpl implements _BudgetAlert {
  const _$BudgetAlertImpl(
      {required this.id,
      required this.type,
      required this.status,
      required this.amount,
      required this.thresholdPercent,
      required this.createdAt,
      this.resolvedAt});

  @override
  final String id;
  @override
  final String type;
  @override
  final String status;
  @override
  final double? amount;
  @override
  final double? thresholdPercent;
  @override
  final DateTime createdAt;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'BudgetAlert(id: $id, type: $type, status: $status, amount: $amount, thresholdPercent: $thresholdPercent, createdAt: $createdAt, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.thresholdPercent, thresholdPercent) ||
                other.thresholdPercent == thresholdPercent) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, type, status, amount,
      thresholdPercent, createdAt, resolvedAt);

  /// Create a copy of BudgetAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetAlertImplCopyWith<_$BudgetAlertImpl> get copyWith =>
      __$$BudgetAlertImplCopyWithImpl<_$BudgetAlertImpl>(this, _$identity);
}

abstract class _BudgetAlert implements BudgetAlert {
  const factory _BudgetAlert(
      {required final String id,
      required final String type,
      required final String status,
      required final double? amount,
      required final double? thresholdPercent,
      required final DateTime createdAt,
      final DateTime? resolvedAt}) = _$BudgetAlertImpl;

  @override
  String get id;
  @override
  String get type;
  @override
  String get status;
  @override
  double? get amount;
  @override
  double? get thresholdPercent;
  @override
  DateTime get createdAt;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of BudgetAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetAlertImplCopyWith<_$BudgetAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetTrendPoint {
  String get label => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  /// Create a copy of BudgetTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetTrendPointCopyWith<BudgetTrendPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetTrendPointCopyWith<$Res> {
  factory $BudgetTrendPointCopyWith(
          BudgetTrendPoint value, $Res Function(BudgetTrendPoint) then) =
      _$BudgetTrendPointCopyWithImpl<$Res, BudgetTrendPoint>;
  @useResult
  $Res call({String label, double value});
}

/// @nodoc
class _$BudgetTrendPointCopyWithImpl<$Res, $Val extends BudgetTrendPoint>
    implements $BudgetTrendPointCopyWith<$Res> {
  _$BudgetTrendPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetTrendPointImplCopyWith<$Res>
    implements $BudgetTrendPointCopyWith<$Res> {
  factory _$$BudgetTrendPointImplCopyWith(_$BudgetTrendPointImpl value,
          $Res Function(_$BudgetTrendPointImpl) then) =
      __$$BudgetTrendPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double value});
}

/// @nodoc
class __$$BudgetTrendPointImplCopyWithImpl<$Res>
    extends _$BudgetTrendPointCopyWithImpl<$Res, _$BudgetTrendPointImpl>
    implements _$$BudgetTrendPointImplCopyWith<$Res> {
  __$$BudgetTrendPointImplCopyWithImpl(_$BudgetTrendPointImpl _value,
      $Res Function(_$BudgetTrendPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of BudgetTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_$BudgetTrendPointImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$BudgetTrendPointImpl implements _BudgetTrendPoint {
  const _$BudgetTrendPointImpl({required this.label, required this.value});

  @override
  final String label;
  @override
  final double value;

  @override
  String toString() {
    return 'BudgetTrendPoint(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetTrendPointImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of BudgetTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetTrendPointImplCopyWith<_$BudgetTrendPointImpl> get copyWith =>
      __$$BudgetTrendPointImplCopyWithImpl<_$BudgetTrendPointImpl>(
          this, _$identity);
}

abstract class _BudgetTrendPoint implements BudgetTrendPoint {
  const factory _BudgetTrendPoint(
      {required final String label,
      required final double value}) = _$BudgetTrendPointImpl;

  @override
  String get label;
  @override
  double get value;

  /// Create a copy of BudgetTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetTrendPointImplCopyWith<_$BudgetTrendPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetSummary {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get spent => throw _privateConstructorUsedError;
  double get remaining => throw _privateConstructorUsedError;
  double get threshold => throw _privateConstructorUsedError;
  double get thresholdPercent => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  BudgetStatus get status => throw _privateConstructorUsedError;
  BudgetRecurrence get recurrence => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  DateTime? get resetOn => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get categoryLabel => throw _privateConstructorUsedError;
  String? get categoryColor => throw _privateConstructorUsedError;
  List<BudgetAlert> get alerts => throw _privateConstructorUsedError;
  List<BudgetTrendPoint> get trend => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Create a copy of BudgetSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetSummaryCopyWith<BudgetSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetSummaryCopyWith<$Res> {
  factory $BudgetSummaryCopyWith(
          BudgetSummary value, $Res Function(BudgetSummary) then) =
      _$BudgetSummaryCopyWithImpl<$Res, BudgetSummary>;
  @useResult
  $Res call(
      {String id,
      String label,
      double amount,
      double spent,
      double remaining,
      double threshold,
      double thresholdPercent,
      double progress,
      BudgetStatus status,
      BudgetRecurrence recurrence,
      DateTime periodStart,
      DateTime periodEnd,
      DateTime? resetOn,
      String? categoryId,
      String? categoryLabel,
      String? categoryColor,
      List<BudgetAlert> alerts,
      List<BudgetTrendPoint> trend,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$BudgetSummaryCopyWithImpl<$Res, $Val extends BudgetSummary>
    implements $BudgetSummaryCopyWith<$Res> {
  _$BudgetSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? amount = null,
    Object? spent = null,
    Object? remaining = null,
    Object? threshold = null,
    Object? thresholdPercent = null,
    Object? progress = null,
    Object? status = null,
    Object? recurrence = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? resetOn = freezed,
    Object? categoryId = freezed,
    Object? categoryLabel = freezed,
    Object? categoryColor = freezed,
    Object? alerts = null,
    Object? trend = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double,
      thresholdPercent: null == thresholdPercent
          ? _value.thresholdPercent
          : thresholdPercent // ignore: cast_nullable_to_non_nullable
              as double,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BudgetStatus,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as BudgetRecurrence,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resetOn: freezed == resetOn
          ? _value.resetOn
          : resetOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLabel: freezed == categoryLabel
          ? _value.categoryLabel
          : categoryLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColor: freezed == categoryColor
          ? _value.categoryColor
          : categoryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<BudgetAlert>,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<BudgetTrendPoint>,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetSummaryImplCopyWith<$Res>
    implements $BudgetSummaryCopyWith<$Res> {
  factory _$$BudgetSummaryImplCopyWith(
          _$BudgetSummaryImpl value, $Res Function(_$BudgetSummaryImpl) then) =
      __$$BudgetSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      double amount,
      double spent,
      double remaining,
      double threshold,
      double thresholdPercent,
      double progress,
      BudgetStatus status,
      BudgetRecurrence recurrence,
      DateTime periodStart,
      DateTime periodEnd,
      DateTime? resetOn,
      String? categoryId,
      String? categoryLabel,
      String? categoryColor,
      List<BudgetAlert> alerts,
      List<BudgetTrendPoint> trend,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$BudgetSummaryImplCopyWithImpl<$Res>
    extends _$BudgetSummaryCopyWithImpl<$Res, _$BudgetSummaryImpl>
    implements _$$BudgetSummaryImplCopyWith<$Res> {
  __$$BudgetSummaryImplCopyWithImpl(
      _$BudgetSummaryImpl _value, $Res Function(_$BudgetSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BudgetSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? amount = null,
    Object? spent = null,
    Object? remaining = null,
    Object? threshold = null,
    Object? thresholdPercent = null,
    Object? progress = null,
    Object? status = null,
    Object? recurrence = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? resetOn = freezed,
    Object? categoryId = freezed,
    Object? categoryLabel = freezed,
    Object? categoryColor = freezed,
    Object? alerts = null,
    Object? trend = null,
    Object? metadata = freezed,
  }) {
    return _then(_$BudgetSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double,
      thresholdPercent: null == thresholdPercent
          ? _value.thresholdPercent
          : thresholdPercent // ignore: cast_nullable_to_non_nullable
              as double,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BudgetStatus,
      recurrence: null == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as BudgetRecurrence,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      resetOn: freezed == resetOn
          ? _value.resetOn
          : resetOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryLabel: freezed == categoryLabel
          ? _value.categoryLabel
          : categoryLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColor: freezed == categoryColor
          ? _value.categoryColor
          : categoryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      alerts: null == alerts
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<BudgetAlert>,
      trend: null == trend
          ? _value._trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<BudgetTrendPoint>,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$BudgetSummaryImpl implements _BudgetSummary {
  const _$BudgetSummaryImpl(
      {required this.id,
      required this.label,
      required this.amount,
      required this.spent,
      required this.remaining,
      required this.threshold,
      required this.thresholdPercent,
      required this.progress,
      required this.status,
      required this.recurrence,
      required this.periodStart,
      required this.periodEnd,
      this.resetOn,
      this.categoryId,
      this.categoryLabel,
      this.categoryColor,
      required final List<BudgetAlert> alerts,
      required final List<BudgetTrendPoint> trend,
      final Map<String, dynamic>? metadata})
      : _alerts = alerts,
        _trend = trend,
        _metadata = metadata;

  @override
  final String id;
  @override
  final String label;
  @override
  final double amount;
  @override
  final double spent;
  @override
  final double remaining;
  @override
  final double threshold;
  @override
  final double thresholdPercent;
  @override
  final double progress;
  @override
  final BudgetStatus status;
  @override
  final BudgetRecurrence recurrence;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final DateTime? resetOn;
  @override
  final String? categoryId;
  @override
  final String? categoryLabel;
  @override
  final String? categoryColor;
  final List<BudgetAlert> _alerts;
  @override
  List<BudgetAlert> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  final List<BudgetTrendPoint> _trend;
  @override
  List<BudgetTrendPoint> get trend {
    if (_trend is EqualUnmodifiableListView) return _trend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trend);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BudgetSummary(id: $id, label: $label, amount: $amount, spent: $spent, remaining: $remaining, threshold: $threshold, thresholdPercent: $thresholdPercent, progress: $progress, status: $status, recurrence: $recurrence, periodStart: $periodStart, periodEnd: $periodEnd, resetOn: $resetOn, categoryId: $categoryId, categoryLabel: $categoryLabel, categoryColor: $categoryColor, alerts: $alerts, trend: $trend, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold) &&
            (identical(other.thresholdPercent, thresholdPercent) ||
                other.thresholdPercent == thresholdPercent) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.resetOn, resetOn) || other.resetOn == resetOn) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryLabel, categoryLabel) ||
                other.categoryLabel == categoryLabel) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            const DeepCollectionEquality().equals(other._trend, _trend) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        label,
        amount,
        spent,
        remaining,
        threshold,
        thresholdPercent,
        progress,
        status,
        recurrence,
        periodStart,
        periodEnd,
        resetOn,
        categoryId,
        categoryLabel,
        categoryColor,
        const DeepCollectionEquality().hash(_alerts),
        const DeepCollectionEquality().hash(_trend),
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of BudgetSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetSummaryImplCopyWith<_$BudgetSummaryImpl> get copyWith =>
      __$$BudgetSummaryImplCopyWithImpl<_$BudgetSummaryImpl>(this, _$identity);
}

abstract class _BudgetSummary implements BudgetSummary {
  const factory _BudgetSummary(
      {required final String id,
      required final String label,
      required final double amount,
      required final double spent,
      required final double remaining,
      required final double threshold,
      required final double thresholdPercent,
      required final double progress,
      required final BudgetStatus status,
      required final BudgetRecurrence recurrence,
      required final DateTime periodStart,
      required final DateTime periodEnd,
      final DateTime? resetOn,
      final String? categoryId,
      final String? categoryLabel,
      final String? categoryColor,
      required final List<BudgetAlert> alerts,
      required final List<BudgetTrendPoint> trend,
      final Map<String, dynamic>? metadata}) = _$BudgetSummaryImpl;

  @override
  String get id;
  @override
  String get label;
  @override
  double get amount;
  @override
  double get spent;
  @override
  double get remaining;
  @override
  double get threshold;
  @override
  double get thresholdPercent;
  @override
  double get progress;
  @override
  BudgetStatus get status;
  @override
  BudgetRecurrence get recurrence;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  DateTime? get resetOn;
  @override
  String? get categoryId;
  @override
  String? get categoryLabel;
  @override
  String? get categoryColor;
  @override
  List<BudgetAlert> get alerts;
  @override
  List<BudgetTrendPoint> get trend;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of BudgetSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetSummaryImplCopyWith<_$BudgetSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetOverview {
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  double get totalLimit => throw _privateConstructorUsedError;
  double get totalSpent => throw _privateConstructorUsedError;
  double get remaining => throw _privateConstructorUsedError;
  int get warningCount => throw _privateConstructorUsedError;
  int get criticalCount => throw _privateConstructorUsedError;
  List<BudgetSummary> get budgets => throw _privateConstructorUsedError;

  /// Create a copy of BudgetOverview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetOverviewCopyWith<BudgetOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetOverviewCopyWith<$Res> {
  factory $BudgetOverviewCopyWith(
          BudgetOverview value, $Res Function(BudgetOverview) then) =
      _$BudgetOverviewCopyWithImpl<$Res, BudgetOverview>;
  @useResult
  $Res call(
      {DateTime periodStart,
      DateTime periodEnd,
      double totalLimit,
      double totalSpent,
      double remaining,
      int warningCount,
      int criticalCount,
      List<BudgetSummary> budgets});
}

/// @nodoc
class _$BudgetOverviewCopyWithImpl<$Res, $Val extends BudgetOverview>
    implements $BudgetOverviewCopyWith<$Res> {
  _$BudgetOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetOverview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalLimit = null,
    Object? totalSpent = null,
    Object? remaining = null,
    Object? warningCount = null,
    Object? criticalCount = null,
    Object? budgets = null,
  }) {
    return _then(_value.copyWith(
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalLimit: null == totalLimit
          ? _value.totalLimit
          : totalLimit // ignore: cast_nullable_to_non_nullable
              as double,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      warningCount: null == warningCount
          ? _value.warningCount
          : warningCount // ignore: cast_nullable_to_non_nullable
              as int,
      criticalCount: null == criticalCount
          ? _value.criticalCount
          : criticalCount // ignore: cast_nullable_to_non_nullable
              as int,
      budgets: null == budgets
          ? _value.budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetOverviewImplCopyWith<$Res>
    implements $BudgetOverviewCopyWith<$Res> {
  factory _$$BudgetOverviewImplCopyWith(_$BudgetOverviewImpl value,
          $Res Function(_$BudgetOverviewImpl) then) =
      __$$BudgetOverviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime periodStart,
      DateTime periodEnd,
      double totalLimit,
      double totalSpent,
      double remaining,
      int warningCount,
      int criticalCount,
      List<BudgetSummary> budgets});
}

/// @nodoc
class __$$BudgetOverviewImplCopyWithImpl<$Res>
    extends _$BudgetOverviewCopyWithImpl<$Res, _$BudgetOverviewImpl>
    implements _$$BudgetOverviewImplCopyWith<$Res> {
  __$$BudgetOverviewImplCopyWithImpl(
      _$BudgetOverviewImpl _value, $Res Function(_$BudgetOverviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of BudgetOverview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalLimit = null,
    Object? totalSpent = null,
    Object? remaining = null,
    Object? warningCount = null,
    Object? criticalCount = null,
    Object? budgets = null,
  }) {
    return _then(_$BudgetOverviewImpl(
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalLimit: null == totalLimit
          ? _value.totalLimit
          : totalLimit // ignore: cast_nullable_to_non_nullable
              as double,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as double,
      warningCount: null == warningCount
          ? _value.warningCount
          : warningCount // ignore: cast_nullable_to_non_nullable
              as int,
      criticalCount: null == criticalCount
          ? _value.criticalCount
          : criticalCount // ignore: cast_nullable_to_non_nullable
              as int,
      budgets: null == budgets
          ? _value._budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetSummary>,
    ));
  }
}

/// @nodoc

class _$BudgetOverviewImpl implements _BudgetOverview {
  const _$BudgetOverviewImpl(
      {required this.periodStart,
      required this.periodEnd,
      required this.totalLimit,
      required this.totalSpent,
      required this.remaining,
      required this.warningCount,
      required this.criticalCount,
      required final List<BudgetSummary> budgets})
      : _budgets = budgets;

  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final double totalLimit;
  @override
  final double totalSpent;
  @override
  final double remaining;
  @override
  final int warningCount;
  @override
  final int criticalCount;
  final List<BudgetSummary> _budgets;
  @override
  List<BudgetSummary> get budgets {
    if (_budgets is EqualUnmodifiableListView) return _budgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgets);
  }

  @override
  String toString() {
    return 'BudgetOverview(periodStart: $periodStart, periodEnd: $periodEnd, totalLimit: $totalLimit, totalSpent: $totalSpent, remaining: $remaining, warningCount: $warningCount, criticalCount: $criticalCount, budgets: $budgets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetOverviewImpl &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.totalLimit, totalLimit) ||
                other.totalLimit == totalLimit) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.warningCount, warningCount) ||
                other.warningCount == warningCount) &&
            (identical(other.criticalCount, criticalCount) ||
                other.criticalCount == criticalCount) &&
            const DeepCollectionEquality().equals(other._budgets, _budgets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      periodStart,
      periodEnd,
      totalLimit,
      totalSpent,
      remaining,
      warningCount,
      criticalCount,
      const DeepCollectionEquality().hash(_budgets));

  /// Create a copy of BudgetOverview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetOverviewImplCopyWith<_$BudgetOverviewImpl> get copyWith =>
      __$$BudgetOverviewImplCopyWithImpl<_$BudgetOverviewImpl>(
          this, _$identity);
}

abstract class _BudgetOverview implements BudgetOverview {
  const factory _BudgetOverview(
      {required final DateTime periodStart,
      required final DateTime periodEnd,
      required final double totalLimit,
      required final double totalSpent,
      required final double remaining,
      required final int warningCount,
      required final int criticalCount,
      required final List<BudgetSummary> budgets}) = _$BudgetOverviewImpl;

  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  double get totalLimit;
  @override
  double get totalSpent;
  @override
  double get remaining;
  @override
  int get warningCount;
  @override
  int get criticalCount;
  @override
  List<BudgetSummary> get budgets;

  /// Create a copy of BudgetOverview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetOverviewImplCopyWith<_$BudgetOverviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
