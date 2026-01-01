// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InsightsTrendPoint {
  String get label => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  /// Create a copy of InsightsTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsightsTrendPointCopyWith<InsightsTrendPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightsTrendPointCopyWith<$Res> {
  factory $InsightsTrendPointCopyWith(
          InsightsTrendPoint value, $Res Function(InsightsTrendPoint) then) =
      _$InsightsTrendPointCopyWithImpl<$Res, InsightsTrendPoint>;
  @useResult
  $Res call({String label, double value});
}

/// @nodoc
class _$InsightsTrendPointCopyWithImpl<$Res, $Val extends InsightsTrendPoint>
    implements $InsightsTrendPointCopyWith<$Res> {
  _$InsightsTrendPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsightsTrendPoint
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
abstract class _$$InsightsTrendPointImplCopyWith<$Res>
    implements $InsightsTrendPointCopyWith<$Res> {
  factory _$$InsightsTrendPointImplCopyWith(_$InsightsTrendPointImpl value,
          $Res Function(_$InsightsTrendPointImpl) then) =
      __$$InsightsTrendPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double value});
}

/// @nodoc
class __$$InsightsTrendPointImplCopyWithImpl<$Res>
    extends _$InsightsTrendPointCopyWithImpl<$Res, _$InsightsTrendPointImpl>
    implements _$$InsightsTrendPointImplCopyWith<$Res> {
  __$$InsightsTrendPointImplCopyWithImpl(_$InsightsTrendPointImpl _value,
      $Res Function(_$InsightsTrendPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of InsightsTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
  }) {
    return _then(_$InsightsTrendPointImpl(
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

class _$InsightsTrendPointImpl implements _InsightsTrendPoint {
  const _$InsightsTrendPointImpl({required this.label, required this.value});

  @override
  final String label;
  @override
  final double value;

  @override
  String toString() {
    return 'InsightsTrendPoint(label: $label, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightsTrendPointImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, value);

  /// Create a copy of InsightsTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightsTrendPointImplCopyWith<_$InsightsTrendPointImpl> get copyWith =>
      __$$InsightsTrendPointImplCopyWithImpl<_$InsightsTrendPointImpl>(
          this, _$identity);
}

abstract class _InsightsTrendPoint implements InsightsTrendPoint {
  const factory _InsightsTrendPoint(
      {required final String label,
      required final double value}) = _$InsightsTrendPointImpl;

  @override
  String get label;
  @override
  double get value;

  /// Create a copy of InsightsTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsightsTrendPointImplCopyWith<_$InsightsTrendPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsightCategoryBreakdown {
  String? get categoryId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  double get percent => throw _privateConstructorUsedError;

  /// Create a copy of InsightCategoryBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsightCategoryBreakdownCopyWith<InsightCategoryBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightCategoryBreakdownCopyWith<$Res> {
  factory $InsightCategoryBreakdownCopyWith(InsightCategoryBreakdown value,
          $Res Function(InsightCategoryBreakdown) then) =
      _$InsightCategoryBreakdownCopyWithImpl<$Res, InsightCategoryBreakdown>;
  @useResult
  $Res call(
      {String? categoryId,
      String label,
      String? color,
      double value,
      double percent});
}

/// @nodoc
class _$InsightCategoryBreakdownCopyWithImpl<$Res,
        $Val extends InsightCategoryBreakdown>
    implements $InsightCategoryBreakdownCopyWith<$Res> {
  _$InsightCategoryBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsightCategoryBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? label = null,
    Object? color = freezed,
    Object? value = null,
    Object? percent = null,
  }) {
    return _then(_value.copyWith(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightCategoryBreakdownImplCopyWith<$Res>
    implements $InsightCategoryBreakdownCopyWith<$Res> {
  factory _$$InsightCategoryBreakdownImplCopyWith(
          _$InsightCategoryBreakdownImpl value,
          $Res Function(_$InsightCategoryBreakdownImpl) then) =
      __$$InsightCategoryBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? categoryId,
      String label,
      String? color,
      double value,
      double percent});
}

/// @nodoc
class __$$InsightCategoryBreakdownImplCopyWithImpl<$Res>
    extends _$InsightCategoryBreakdownCopyWithImpl<$Res,
        _$InsightCategoryBreakdownImpl>
    implements _$$InsightCategoryBreakdownImplCopyWith<$Res> {
  __$$InsightCategoryBreakdownImplCopyWithImpl(
      _$InsightCategoryBreakdownImpl _value,
      $Res Function(_$InsightCategoryBreakdownImpl) _then)
      : super(_value, _then);

  /// Create a copy of InsightCategoryBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? label = null,
    Object? color = freezed,
    Object? value = null,
    Object? percent = null,
  }) {
    return _then(_$InsightCategoryBreakdownImpl(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$InsightCategoryBreakdownImpl implements _InsightCategoryBreakdown {
  const _$InsightCategoryBreakdownImpl(
      {this.categoryId,
      required this.label,
      this.color,
      required this.value,
      required this.percent});

  @override
  final String? categoryId;
  @override
  final String label;
  @override
  final String? color;
  @override
  final double value;
  @override
  final double percent;

  @override
  String toString() {
    return 'InsightCategoryBreakdown(categoryId: $categoryId, label: $label, color: $color, value: $value, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightCategoryBreakdownImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryId, label, color, value, percent);

  /// Create a copy of InsightCategoryBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightCategoryBreakdownImplCopyWith<_$InsightCategoryBreakdownImpl>
      get copyWith => __$$InsightCategoryBreakdownImplCopyWithImpl<
          _$InsightCategoryBreakdownImpl>(this, _$identity);
}

abstract class _InsightCategoryBreakdown implements InsightCategoryBreakdown {
  const factory _InsightCategoryBreakdown(
      {final String? categoryId,
      required final String label,
      final String? color,
      required final double value,
      required final double percent}) = _$InsightCategoryBreakdownImpl;

  @override
  String? get categoryId;
  @override
  String get label;
  @override
  String? get color;
  @override
  double get value;
  @override
  double get percent;

  /// Create a copy of InsightCategoryBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsightCategoryBreakdownImplCopyWith<_$InsightCategoryBreakdownImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsightActivity {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get occurredOn => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of InsightActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsightActivityCopyWith<InsightActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightActivityCopyWith<$Res> {
  factory $InsightActivityCopyWith(
          InsightActivity value, $Res Function(InsightActivity) then) =
      _$InsightActivityCopyWithImpl<$Res, InsightActivity>;
  @useResult
  $Res call(
      {String id,
      String label,
      double amount,
      String currency,
      DateTime occurredOn,
      String? notes});
}

/// @nodoc
class _$InsightActivityCopyWithImpl<$Res, $Val extends InsightActivity>
    implements $InsightActivityCopyWith<$Res> {
  _$InsightActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsightActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? amount = null,
    Object? currency = null,
    Object? occurredOn = null,
    Object? notes = freezed,
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
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      occurredOn: null == occurredOn
          ? _value.occurredOn
          : occurredOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightActivityImplCopyWith<$Res>
    implements $InsightActivityCopyWith<$Res> {
  factory _$$InsightActivityImplCopyWith(_$InsightActivityImpl value,
          $Res Function(_$InsightActivityImpl) then) =
      __$$InsightActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      double amount,
      String currency,
      DateTime occurredOn,
      String? notes});
}

/// @nodoc
class __$$InsightActivityImplCopyWithImpl<$Res>
    extends _$InsightActivityCopyWithImpl<$Res, _$InsightActivityImpl>
    implements _$$InsightActivityImplCopyWith<$Res> {
  __$$InsightActivityImplCopyWithImpl(
      _$InsightActivityImpl _value, $Res Function(_$InsightActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of InsightActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? amount = null,
    Object? currency = null,
    Object? occurredOn = null,
    Object? notes = freezed,
  }) {
    return _then(_$InsightActivityImpl(
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
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      occurredOn: null == occurredOn
          ? _value.occurredOn
          : occurredOn // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InsightActivityImpl implements _InsightActivity {
  const _$InsightActivityImpl(
      {required this.id,
      required this.label,
      required this.amount,
      required this.currency,
      required this.occurredOn,
      this.notes});

  @override
  final String id;
  @override
  final String label;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final DateTime occurredOn;
  @override
  final String? notes;

  @override
  String toString() {
    return 'InsightActivity(id: $id, label: $label, amount: $amount, currency: $currency, occurredOn: $occurredOn, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.occurredOn, occurredOn) ||
                other.occurredOn == occurredOn) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, amount, currency, occurredOn, notes);

  /// Create a copy of InsightActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightActivityImplCopyWith<_$InsightActivityImpl> get copyWith =>
      __$$InsightActivityImplCopyWithImpl<_$InsightActivityImpl>(
          this, _$identity);
}

abstract class _InsightActivity implements InsightActivity {
  const factory _InsightActivity(
      {required final String id,
      required final String label,
      required final double amount,
      required final String currency,
      required final DateTime occurredOn,
      final String? notes}) = _$InsightActivityImpl;

  @override
  String get id;
  @override
  String get label;
  @override
  double get amount;
  @override
  String get currency;
  @override
  DateTime get occurredOn;
  @override
  String? get notes;

  /// Create a copy of InsightActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsightActivityImplCopyWith<_$InsightActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsightsDashboard {
  String get timeframe => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  double get totalSpent => throw _privateConstructorUsedError;
  double get averageDaily => throw _privateConstructorUsedError;
  double? get changePercent => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  List<InsightsTrendPoint> get trend => throw _privateConstructorUsedError;
  List<InsightCategoryBreakdown> get categories =>
      throw _privateConstructorUsedError;
  List<InsightActivity> get recentActivities =>
      throw _privateConstructorUsedError;

  /// Create a copy of InsightsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsightsDashboardCopyWith<InsightsDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightsDashboardCopyWith<$Res> {
  factory $InsightsDashboardCopyWith(
          InsightsDashboard value, $Res Function(InsightsDashboard) then) =
      _$InsightsDashboardCopyWithImpl<$Res, InsightsDashboard>;
  @useResult
  $Res call(
      {String timeframe,
      DateTime periodStart,
      DateTime periodEnd,
      double totalSpent,
      double averageDaily,
      double? changePercent,
      String currency,
      List<InsightsTrendPoint> trend,
      List<InsightCategoryBreakdown> categories,
      List<InsightActivity> recentActivities});
}

/// @nodoc
class _$InsightsDashboardCopyWithImpl<$Res, $Val extends InsightsDashboard>
    implements $InsightsDashboardCopyWith<$Res> {
  _$InsightsDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InsightsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeframe = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalSpent = null,
    Object? averageDaily = null,
    Object? changePercent = freezed,
    Object? currency = null,
    Object? trend = null,
    Object? categories = null,
    Object? recentActivities = null,
  }) {
    return _then(_value.copyWith(
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      averageDaily: null == averageDaily
          ? _value.averageDaily
          : averageDaily // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: freezed == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<InsightsTrendPoint>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<InsightCategoryBreakdown>,
      recentActivities: null == recentActivities
          ? _value.recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<InsightActivity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightsDashboardImplCopyWith<$Res>
    implements $InsightsDashboardCopyWith<$Res> {
  factory _$$InsightsDashboardImplCopyWith(_$InsightsDashboardImpl value,
          $Res Function(_$InsightsDashboardImpl) then) =
      __$$InsightsDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String timeframe,
      DateTime periodStart,
      DateTime periodEnd,
      double totalSpent,
      double averageDaily,
      double? changePercent,
      String currency,
      List<InsightsTrendPoint> trend,
      List<InsightCategoryBreakdown> categories,
      List<InsightActivity> recentActivities});
}

/// @nodoc
class __$$InsightsDashboardImplCopyWithImpl<$Res>
    extends _$InsightsDashboardCopyWithImpl<$Res, _$InsightsDashboardImpl>
    implements _$$InsightsDashboardImplCopyWith<$Res> {
  __$$InsightsDashboardImplCopyWithImpl(_$InsightsDashboardImpl _value,
      $Res Function(_$InsightsDashboardImpl) _then)
      : super(_value, _then);

  /// Create a copy of InsightsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeframe = null,
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? totalSpent = null,
    Object? averageDaily = null,
    Object? changePercent = freezed,
    Object? currency = null,
    Object? trend = null,
    Object? categories = null,
    Object? recentActivities = null,
  }) {
    return _then(_$InsightsDashboardImpl(
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      averageDaily: null == averageDaily
          ? _value.averageDaily
          : averageDaily // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: freezed == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      trend: null == trend
          ? _value._trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<InsightsTrendPoint>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<InsightCategoryBreakdown>,
      recentActivities: null == recentActivities
          ? _value._recentActivities
          : recentActivities // ignore: cast_nullable_to_non_nullable
              as List<InsightActivity>,
    ));
  }
}

/// @nodoc

class _$InsightsDashboardImpl implements _InsightsDashboard {
  const _$InsightsDashboardImpl(
      {required this.timeframe,
      required this.periodStart,
      required this.periodEnd,
      required this.totalSpent,
      required this.averageDaily,
      this.changePercent,
      required this.currency,
      required final List<InsightsTrendPoint> trend,
      required final List<InsightCategoryBreakdown> categories,
      required final List<InsightActivity> recentActivities})
      : _trend = trend,
        _categories = categories,
        _recentActivities = recentActivities;

  @override
  final String timeframe;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final double totalSpent;
  @override
  final double averageDaily;
  @override
  final double? changePercent;
  @override
  final String currency;
  final List<InsightsTrendPoint> _trend;
  @override
  List<InsightsTrendPoint> get trend {
    if (_trend is EqualUnmodifiableListView) return _trend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trend);
  }

  final List<InsightCategoryBreakdown> _categories;
  @override
  List<InsightCategoryBreakdown> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<InsightActivity> _recentActivities;
  @override
  List<InsightActivity> get recentActivities {
    if (_recentActivities is EqualUnmodifiableListView)
      return _recentActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentActivities);
  }

  @override
  String toString() {
    return 'InsightsDashboard(timeframe: $timeframe, periodStart: $periodStart, periodEnd: $periodEnd, totalSpent: $totalSpent, averageDaily: $averageDaily, changePercent: $changePercent, currency: $currency, trend: $trend, categories: $categories, recentActivities: $recentActivities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightsDashboardImpl &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.averageDaily, averageDaily) ||
                other.averageDaily == averageDaily) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(other._trend, _trend) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._recentActivities, _recentActivities));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      timeframe,
      periodStart,
      periodEnd,
      totalSpent,
      averageDaily,
      changePercent,
      currency,
      const DeepCollectionEquality().hash(_trend),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_recentActivities));

  /// Create a copy of InsightsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightsDashboardImplCopyWith<_$InsightsDashboardImpl> get copyWith =>
      __$$InsightsDashboardImplCopyWithImpl<_$InsightsDashboardImpl>(
          this, _$identity);
}

abstract class _InsightsDashboard implements InsightsDashboard {
  const factory _InsightsDashboard(
          {required final String timeframe,
          required final DateTime periodStart,
          required final DateTime periodEnd,
          required final double totalSpent,
          required final double averageDaily,
          final double? changePercent,
          required final String currency,
          required final List<InsightsTrendPoint> trend,
          required final List<InsightCategoryBreakdown> categories,
          required final List<InsightActivity> recentActivities}) =
      _$InsightsDashboardImpl;

  @override
  String get timeframe;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  double get totalSpent;
  @override
  double get averageDaily;
  @override
  double? get changePercent;
  @override
  String get currency;
  @override
  List<InsightsTrendPoint> get trend;
  @override
  List<InsightCategoryBreakdown> get categories;
  @override
  List<InsightActivity> get recentActivities;

  /// Create a copy of InsightsDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsightsDashboardImplCopyWith<_$InsightsDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
