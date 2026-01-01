// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletTrendPoint {
  String get label => throw _privateConstructorUsedError;
  double get collect => throw _privateConstructorUsedError;
  double get pay => throw _privateConstructorUsedError;

  /// Create a copy of WalletTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletTrendPointCopyWith<WalletTrendPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTrendPointCopyWith<$Res> {
  factory $WalletTrendPointCopyWith(
          WalletTrendPoint value, $Res Function(WalletTrendPoint) then) =
      _$WalletTrendPointCopyWithImpl<$Res, WalletTrendPoint>;
  @useResult
  $Res call({String label, double collect, double pay});
}

/// @nodoc
class _$WalletTrendPointCopyWithImpl<$Res, $Val extends WalletTrendPoint>
    implements $WalletTrendPointCopyWith<$Res> {
  _$WalletTrendPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? collect = null,
    Object? pay = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      collect: null == collect
          ? _value.collect
          : collect // ignore: cast_nullable_to_non_nullable
              as double,
      pay: null == pay
          ? _value.pay
          : pay // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletTrendPointImplCopyWith<$Res>
    implements $WalletTrendPointCopyWith<$Res> {
  factory _$$WalletTrendPointImplCopyWith(_$WalletTrendPointImpl value,
          $Res Function(_$WalletTrendPointImpl) then) =
      __$$WalletTrendPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double collect, double pay});
}

/// @nodoc
class __$$WalletTrendPointImplCopyWithImpl<$Res>
    extends _$WalletTrendPointCopyWithImpl<$Res, _$WalletTrendPointImpl>
    implements _$$WalletTrendPointImplCopyWith<$Res> {
  __$$WalletTrendPointImplCopyWithImpl(_$WalletTrendPointImpl _value,
      $Res Function(_$WalletTrendPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? collect = null,
    Object? pay = null,
  }) {
    return _then(_$WalletTrendPointImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      collect: null == collect
          ? _value.collect
          : collect // ignore: cast_nullable_to_non_nullable
              as double,
      pay: null == pay
          ? _value.pay
          : pay // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$WalletTrendPointImpl implements _WalletTrendPoint {
  const _$WalletTrendPointImpl(
      {required this.label, required this.collect, required this.pay});

  @override
  final String label;
  @override
  final double collect;
  @override
  final double pay;

  @override
  String toString() {
    return 'WalletTrendPoint(label: $label, collect: $collect, pay: $pay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTrendPointImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.collect, collect) || other.collect == collect) &&
            (identical(other.pay, pay) || other.pay == pay));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, collect, pay);

  /// Create a copy of WalletTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTrendPointImplCopyWith<_$WalletTrendPointImpl> get copyWith =>
      __$$WalletTrendPointImplCopyWithImpl<_$WalletTrendPointImpl>(
          this, _$identity);
}

abstract class _WalletTrendPoint implements WalletTrendPoint {
  const factory _WalletTrendPoint(
      {required final String label,
      required final double collect,
      required final double pay}) = _$WalletTrendPointImpl;

  @override
  String get label;
  @override
  double get collect;
  @override
  double get pay;

  /// Create a copy of WalletTrendPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletTrendPointImplCopyWith<_$WalletTrendPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletPaymentMethod {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  WalletPaymentMethodType get type => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  String? get instructions => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Create a copy of WalletPaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletPaymentMethodCopyWith<WalletPaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletPaymentMethodCopyWith<$Res> {
  factory $WalletPaymentMethodCopyWith(
          WalletPaymentMethod value, $Res Function(WalletPaymentMethod) then) =
      _$WalletPaymentMethodCopyWithImpl<$Res, WalletPaymentMethod>;
  @useResult
  $Res call(
      {String id,
      String label,
      String provider,
      WalletPaymentMethodType type,
      bool isPrimary,
      String? accountNumber,
      String? instructions,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$WalletPaymentMethodCopyWithImpl<$Res, $Val extends WalletPaymentMethod>
    implements $WalletPaymentMethodCopyWith<$Res> {
  _$WalletPaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? provider = null,
    Object? type = null,
    Object? isPrimary = null,
    Object? accountNumber = freezed,
    Object? instructions = freezed,
    Object? metadata = null,
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
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WalletPaymentMethodType,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletPaymentMethodImplCopyWith<$Res>
    implements $WalletPaymentMethodCopyWith<$Res> {
  factory _$$WalletPaymentMethodImplCopyWith(_$WalletPaymentMethodImpl value,
          $Res Function(_$WalletPaymentMethodImpl) then) =
      __$$WalletPaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      String provider,
      WalletPaymentMethodType type,
      bool isPrimary,
      String? accountNumber,
      String? instructions,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$WalletPaymentMethodImplCopyWithImpl<$Res>
    extends _$WalletPaymentMethodCopyWithImpl<$Res, _$WalletPaymentMethodImpl>
    implements _$$WalletPaymentMethodImplCopyWith<$Res> {
  __$$WalletPaymentMethodImplCopyWithImpl(_$WalletPaymentMethodImpl _value,
      $Res Function(_$WalletPaymentMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? provider = null,
    Object? type = null,
    Object? isPrimary = null,
    Object? accountNumber = freezed,
    Object? instructions = freezed,
    Object? metadata = null,
  }) {
    return _then(_$WalletPaymentMethodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WalletPaymentMethodType,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$WalletPaymentMethodImpl implements _WalletPaymentMethod {
  const _$WalletPaymentMethodImpl(
      {required this.id,
      required this.label,
      required this.provider,
      required this.type,
      required this.isPrimary,
      this.accountNumber,
      this.instructions,
      final Map<String, dynamic> metadata = const <String, dynamic>{}})
      : _metadata = metadata;

  @override
  final String id;
  @override
  final String label;
  @override
  final String provider;
  @override
  final WalletPaymentMethodType type;
  @override
  final bool isPrimary;
  @override
  final String? accountNumber;
  @override
  final String? instructions;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'WalletPaymentMethod(id: $id, label: $label, provider: $provider, type: $type, isPrimary: $isPrimary, accountNumber: $accountNumber, instructions: $instructions, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletPaymentMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      label,
      provider,
      type,
      isPrimary,
      accountNumber,
      instructions,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of WalletPaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletPaymentMethodImplCopyWith<_$WalletPaymentMethodImpl> get copyWith =>
      __$$WalletPaymentMethodImplCopyWithImpl<_$WalletPaymentMethodImpl>(
          this, _$identity);
}

abstract class _WalletPaymentMethod implements WalletPaymentMethod {
  const factory _WalletPaymentMethod(
      {required final String id,
      required final String label,
      required final String provider,
      required final WalletPaymentMethodType type,
      required final bool isPrimary,
      final String? accountNumber,
      final String? instructions,
      final Map<String, dynamic> metadata}) = _$WalletPaymentMethodImpl;

  @override
  String get id;
  @override
  String get label;
  @override
  String get provider;
  @override
  WalletPaymentMethodType get type;
  @override
  bool get isPrimary;
  @override
  String? get accountNumber;
  @override
  String? get instructions;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of WalletPaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletPaymentMethodImplCopyWith<_$WalletPaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletCounterparty {
  String get transactionId => throw _privateConstructorUsedError;
  String? get contactId => throw _privateConstructorUsedError;
  String? get journeyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  WalletDirection get direction => throw _privateConstructorUsedError;
  DateTime? get issueDate => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;

  /// Create a copy of WalletCounterparty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCounterpartyCopyWith<WalletCounterparty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCounterpartyCopyWith<$Res> {
  factory $WalletCounterpartyCopyWith(
          WalletCounterparty value, $Res Function(WalletCounterparty) then) =
      _$WalletCounterpartyCopyWithImpl<$Res, WalletCounterparty>;
  @useResult
  $Res call(
      {String transactionId,
      String? contactId,
      String? journeyId,
      String name,
      double amount,
      String status,
      WalletDirection direction,
      DateTime? issueDate,
      DateTime? dueDate});
}

/// @nodoc
class _$WalletCounterpartyCopyWithImpl<$Res, $Val extends WalletCounterparty>
    implements $WalletCounterpartyCopyWith<$Res> {
  _$WalletCounterpartyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletCounterparty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? contactId = freezed,
    Object? journeyId = freezed,
    Object? name = null,
    Object? amount = null,
    Object? status = null,
    Object? direction = null,
    Object? issueDate = freezed,
    Object? dueDate = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      contactId: freezed == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String?,
      journeyId: freezed == journeyId
          ? _value.journeyId
          : journeyId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as WalletDirection,
      issueDate: freezed == issueDate
          ? _value.issueDate
          : issueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletCounterpartyImplCopyWith<$Res>
    implements $WalletCounterpartyCopyWith<$Res> {
  factory _$$WalletCounterpartyImplCopyWith(_$WalletCounterpartyImpl value,
          $Res Function(_$WalletCounterpartyImpl) then) =
      __$$WalletCounterpartyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionId,
      String? contactId,
      String? journeyId,
      String name,
      double amount,
      String status,
      WalletDirection direction,
      DateTime? issueDate,
      DateTime? dueDate});
}

/// @nodoc
class __$$WalletCounterpartyImplCopyWithImpl<$Res>
    extends _$WalletCounterpartyCopyWithImpl<$Res, _$WalletCounterpartyImpl>
    implements _$$WalletCounterpartyImplCopyWith<$Res> {
  __$$WalletCounterpartyImplCopyWithImpl(_$WalletCounterpartyImpl _value,
      $Res Function(_$WalletCounterpartyImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletCounterparty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? contactId = freezed,
    Object? journeyId = freezed,
    Object? name = null,
    Object? amount = null,
    Object? status = null,
    Object? direction = null,
    Object? issueDate = freezed,
    Object? dueDate = freezed,
  }) {
    return _then(_$WalletCounterpartyImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      contactId: freezed == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String?,
      journeyId: freezed == journeyId
          ? _value.journeyId
          : journeyId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as WalletDirection,
      issueDate: freezed == issueDate
          ? _value.issueDate
          : issueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$WalletCounterpartyImpl implements _WalletCounterparty {
  const _$WalletCounterpartyImpl(
      {required this.transactionId,
      this.contactId,
      this.journeyId,
      required this.name,
      required this.amount,
      required this.status,
      required this.direction,
      this.issueDate,
      this.dueDate});

  @override
  final String transactionId;
  @override
  final String? contactId;
  @override
  final String? journeyId;
  @override
  final String name;
  @override
  final double amount;
  @override
  final String status;
  @override
  final WalletDirection direction;
  @override
  final DateTime? issueDate;
  @override
  final DateTime? dueDate;

  @override
  String toString() {
    return 'WalletCounterparty(transactionId: $transactionId, contactId: $contactId, journeyId: $journeyId, name: $name, amount: $amount, status: $status, direction: $direction, issueDate: $issueDate, dueDate: $dueDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletCounterpartyImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId) &&
            (identical(other.journeyId, journeyId) ||
                other.journeyId == journeyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.issueDate, issueDate) ||
                other.issueDate == issueDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionId, contactId,
      journeyId, name, amount, status, direction, issueDate, dueDate);

  /// Create a copy of WalletCounterparty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletCounterpartyImplCopyWith<_$WalletCounterpartyImpl> get copyWith =>
      __$$WalletCounterpartyImplCopyWithImpl<_$WalletCounterpartyImpl>(
          this, _$identity);
}

abstract class _WalletCounterparty implements WalletCounterparty {
  const factory _WalletCounterparty(
      {required final String transactionId,
      final String? contactId,
      final String? journeyId,
      required final String name,
      required final double amount,
      required final String status,
      required final WalletDirection direction,
      final DateTime? issueDate,
      final DateTime? dueDate}) = _$WalletCounterpartyImpl;

  @override
  String get transactionId;
  @override
  String? get contactId;
  @override
  String? get journeyId;
  @override
  String get name;
  @override
  double get amount;
  @override
  String get status;
  @override
  WalletDirection get direction;
  @override
  DateTime? get issueDate;
  @override
  DateTime? get dueDate;

  /// Create a copy of WalletCounterparty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletCounterpartyImplCopyWith<_$WalletCounterpartyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletSettlementLogEntry {
  String get id => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  WalletSettlementEventType get eventType => throw _privateConstructorUsedError;
  String get counterparty => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  DateTime get occurredAt => throw _privateConstructorUsedError;

  /// Create a copy of WalletSettlementLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletSettlementLogEntryCopyWith<WalletSettlementLogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletSettlementLogEntryCopyWith<$Res> {
  factory $WalletSettlementLogEntryCopyWith(WalletSettlementLogEntry value,
          $Res Function(WalletSettlementLogEntry) then) =
      _$WalletSettlementLogEntryCopyWithImpl<$Res, WalletSettlementLogEntry>;
  @useResult
  $Res call(
      {String id,
      String transactionId,
      WalletSettlementEventType eventType,
      String counterparty,
      String status,
      double? amount,
      DateTime occurredAt});
}

/// @nodoc
class _$WalletSettlementLogEntryCopyWithImpl<$Res,
        $Val extends WalletSettlementLogEntry>
    implements $WalletSettlementLogEntryCopyWith<$Res> {
  _$WalletSettlementLogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletSettlementLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = null,
    Object? eventType = null,
    Object? counterparty = null,
    Object? status = null,
    Object? amount = freezed,
    Object? occurredAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as WalletSettlementEventType,
      counterparty: null == counterparty
          ? _value.counterparty
          : counterparty // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletSettlementLogEntryImplCopyWith<$Res>
    implements $WalletSettlementLogEntryCopyWith<$Res> {
  factory _$$WalletSettlementLogEntryImplCopyWith(
          _$WalletSettlementLogEntryImpl value,
          $Res Function(_$WalletSettlementLogEntryImpl) then) =
      __$$WalletSettlementLogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String transactionId,
      WalletSettlementEventType eventType,
      String counterparty,
      String status,
      double? amount,
      DateTime occurredAt});
}

/// @nodoc
class __$$WalletSettlementLogEntryImplCopyWithImpl<$Res>
    extends _$WalletSettlementLogEntryCopyWithImpl<$Res,
        _$WalletSettlementLogEntryImpl>
    implements _$$WalletSettlementLogEntryImplCopyWith<$Res> {
  __$$WalletSettlementLogEntryImplCopyWithImpl(
      _$WalletSettlementLogEntryImpl _value,
      $Res Function(_$WalletSettlementLogEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletSettlementLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = null,
    Object? eventType = null,
    Object? counterparty = null,
    Object? status = null,
    Object? amount = freezed,
    Object? occurredAt = null,
  }) {
    return _then(_$WalletSettlementLogEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as WalletSettlementEventType,
      counterparty: null == counterparty
          ? _value.counterparty
          : counterparty // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$WalletSettlementLogEntryImpl implements _WalletSettlementLogEntry {
  const _$WalletSettlementLogEntryImpl(
      {required this.id,
      required this.transactionId,
      required this.eventType,
      required this.counterparty,
      required this.status,
      this.amount,
      required this.occurredAt});

  @override
  final String id;
  @override
  final String transactionId;
  @override
  final WalletSettlementEventType eventType;
  @override
  final String counterparty;
  @override
  final String status;
  @override
  final double? amount;
  @override
  final DateTime occurredAt;

  @override
  String toString() {
    return 'WalletSettlementLogEntry(id: $id, transactionId: $transactionId, eventType: $eventType, counterparty: $counterparty, status: $status, amount: $amount, occurredAt: $occurredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletSettlementLogEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.counterparty, counterparty) ||
                other.counterparty == counterparty) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, transactionId, eventType,
      counterparty, status, amount, occurredAt);

  /// Create a copy of WalletSettlementLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletSettlementLogEntryImplCopyWith<_$WalletSettlementLogEntryImpl>
      get copyWith => __$$WalletSettlementLogEntryImplCopyWithImpl<
          _$WalletSettlementLogEntryImpl>(this, _$identity);
}

abstract class _WalletSettlementLogEntry implements WalletSettlementLogEntry {
  const factory _WalletSettlementLogEntry(
      {required final String id,
      required final String transactionId,
      required final WalletSettlementEventType eventType,
      required final String counterparty,
      required final String status,
      final double? amount,
      required final DateTime occurredAt}) = _$WalletSettlementLogEntryImpl;

  @override
  String get id;
  @override
  String get transactionId;
  @override
  WalletSettlementEventType get eventType;
  @override
  String get counterparty;
  @override
  String get status;
  @override
  double? get amount;
  @override
  DateTime get occurredAt;

  /// Create a copy of WalletSettlementLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletSettlementLogEntryImplCopyWith<_$WalletSettlementLogEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletOverview {
  double get totalBalance => throw _privateConstructorUsedError;
  double get totalOwed => throw _privateConstructorUsedError;
  double get totalDue => throw _privateConstructorUsedError;
  double get netValue => throw _privateConstructorUsedError;
  List<WalletCounterparty> get collectFrom =>
      throw _privateConstructorUsedError;
  List<WalletCounterparty> get payTo => throw _privateConstructorUsedError;
  List<WalletSettlementLogEntry> get settlementLog =>
      throw _privateConstructorUsedError;
  List<WalletTrendPoint> get trend => throw _privateConstructorUsedError;
  List<WalletPaymentMethod> get paymentMethods =>
      throw _privateConstructorUsedError;
  DateTime get fetchedAt => throw _privateConstructorUsedError;
  WalletTimeframe get timeframe => throw _privateConstructorUsedError;

  /// Create a copy of WalletOverview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletOverviewCopyWith<WalletOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletOverviewCopyWith<$Res> {
  factory $WalletOverviewCopyWith(
          WalletOverview value, $Res Function(WalletOverview) then) =
      _$WalletOverviewCopyWithImpl<$Res, WalletOverview>;
  @useResult
  $Res call(
      {double totalBalance,
      double totalOwed,
      double totalDue,
      double netValue,
      List<WalletCounterparty> collectFrom,
      List<WalletCounterparty> payTo,
      List<WalletSettlementLogEntry> settlementLog,
      List<WalletTrendPoint> trend,
      List<WalletPaymentMethod> paymentMethods,
      DateTime fetchedAt,
      WalletTimeframe timeframe});
}

/// @nodoc
class _$WalletOverviewCopyWithImpl<$Res, $Val extends WalletOverview>
    implements $WalletOverviewCopyWith<$Res> {
  _$WalletOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletOverview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBalance = null,
    Object? totalOwed = null,
    Object? totalDue = null,
    Object? netValue = null,
    Object? collectFrom = null,
    Object? payTo = null,
    Object? settlementLog = null,
    Object? trend = null,
    Object? paymentMethods = null,
    Object? fetchedAt = null,
    Object? timeframe = null,
  }) {
    return _then(_value.copyWith(
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      totalOwed: null == totalOwed
          ? _value.totalOwed
          : totalOwed // ignore: cast_nullable_to_non_nullable
              as double,
      totalDue: null == totalDue
          ? _value.totalDue
          : totalDue // ignore: cast_nullable_to_non_nullable
              as double,
      netValue: null == netValue
          ? _value.netValue
          : netValue // ignore: cast_nullable_to_non_nullable
              as double,
      collectFrom: null == collectFrom
          ? _value.collectFrom
          : collectFrom // ignore: cast_nullable_to_non_nullable
              as List<WalletCounterparty>,
      payTo: null == payTo
          ? _value.payTo
          : payTo // ignore: cast_nullable_to_non_nullable
              as List<WalletCounterparty>,
      settlementLog: null == settlementLog
          ? _value.settlementLog
          : settlementLog // ignore: cast_nullable_to_non_nullable
              as List<WalletSettlementLogEntry>,
      trend: null == trend
          ? _value.trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<WalletTrendPoint>,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<WalletPaymentMethod>,
      fetchedAt: null == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as WalletTimeframe,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletOverviewImplCopyWith<$Res>
    implements $WalletOverviewCopyWith<$Res> {
  factory _$$WalletOverviewImplCopyWith(_$WalletOverviewImpl value,
          $Res Function(_$WalletOverviewImpl) then) =
      __$$WalletOverviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalBalance,
      double totalOwed,
      double totalDue,
      double netValue,
      List<WalletCounterparty> collectFrom,
      List<WalletCounterparty> payTo,
      List<WalletSettlementLogEntry> settlementLog,
      List<WalletTrendPoint> trend,
      List<WalletPaymentMethod> paymentMethods,
      DateTime fetchedAt,
      WalletTimeframe timeframe});
}

/// @nodoc
class __$$WalletOverviewImplCopyWithImpl<$Res>
    extends _$WalletOverviewCopyWithImpl<$Res, _$WalletOverviewImpl>
    implements _$$WalletOverviewImplCopyWith<$Res> {
  __$$WalletOverviewImplCopyWithImpl(
      _$WalletOverviewImpl _value, $Res Function(_$WalletOverviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletOverview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalBalance = null,
    Object? totalOwed = null,
    Object? totalDue = null,
    Object? netValue = null,
    Object? collectFrom = null,
    Object? payTo = null,
    Object? settlementLog = null,
    Object? trend = null,
    Object? paymentMethods = null,
    Object? fetchedAt = null,
    Object? timeframe = null,
  }) {
    return _then(_$WalletOverviewImpl(
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      totalOwed: null == totalOwed
          ? _value.totalOwed
          : totalOwed // ignore: cast_nullable_to_non_nullable
              as double,
      totalDue: null == totalDue
          ? _value.totalDue
          : totalDue // ignore: cast_nullable_to_non_nullable
              as double,
      netValue: null == netValue
          ? _value.netValue
          : netValue // ignore: cast_nullable_to_non_nullable
              as double,
      collectFrom: null == collectFrom
          ? _value._collectFrom
          : collectFrom // ignore: cast_nullable_to_non_nullable
              as List<WalletCounterparty>,
      payTo: null == payTo
          ? _value._payTo
          : payTo // ignore: cast_nullable_to_non_nullable
              as List<WalletCounterparty>,
      settlementLog: null == settlementLog
          ? _value._settlementLog
          : settlementLog // ignore: cast_nullable_to_non_nullable
              as List<WalletSettlementLogEntry>,
      trend: null == trend
          ? _value._trend
          : trend // ignore: cast_nullable_to_non_nullable
              as List<WalletTrendPoint>,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<WalletPaymentMethod>,
      fetchedAt: null == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as WalletTimeframe,
    ));
  }
}

/// @nodoc

class _$WalletOverviewImpl implements _WalletOverview {
  const _$WalletOverviewImpl(
      {required this.totalBalance,
      required this.totalOwed,
      required this.totalDue,
      required this.netValue,
      required final List<WalletCounterparty> collectFrom,
      required final List<WalletCounterparty> payTo,
      required final List<WalletSettlementLogEntry> settlementLog,
      required final List<WalletTrendPoint> trend,
      required final List<WalletPaymentMethod> paymentMethods,
      required this.fetchedAt,
      required this.timeframe})
      : _collectFrom = collectFrom,
        _payTo = payTo,
        _settlementLog = settlementLog,
        _trend = trend,
        _paymentMethods = paymentMethods;

  @override
  final double totalBalance;
  @override
  final double totalOwed;
  @override
  final double totalDue;
  @override
  final double netValue;
  final List<WalletCounterparty> _collectFrom;
  @override
  List<WalletCounterparty> get collectFrom {
    if (_collectFrom is EqualUnmodifiableListView) return _collectFrom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectFrom);
  }

  final List<WalletCounterparty> _payTo;
  @override
  List<WalletCounterparty> get payTo {
    if (_payTo is EqualUnmodifiableListView) return _payTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payTo);
  }

  final List<WalletSettlementLogEntry> _settlementLog;
  @override
  List<WalletSettlementLogEntry> get settlementLog {
    if (_settlementLog is EqualUnmodifiableListView) return _settlementLog;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settlementLog);
  }

  final List<WalletTrendPoint> _trend;
  @override
  List<WalletTrendPoint> get trend {
    if (_trend is EqualUnmodifiableListView) return _trend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trend);
  }

  final List<WalletPaymentMethod> _paymentMethods;
  @override
  List<WalletPaymentMethod> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  final DateTime fetchedAt;
  @override
  final WalletTimeframe timeframe;

  @override
  String toString() {
    return 'WalletOverview(totalBalance: $totalBalance, totalOwed: $totalOwed, totalDue: $totalDue, netValue: $netValue, collectFrom: $collectFrom, payTo: $payTo, settlementLog: $settlementLog, trend: $trend, paymentMethods: $paymentMethods, fetchedAt: $fetchedAt, timeframe: $timeframe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletOverviewImpl &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.totalOwed, totalOwed) ||
                other.totalOwed == totalOwed) &&
            (identical(other.totalDue, totalDue) ||
                other.totalDue == totalDue) &&
            (identical(other.netValue, netValue) ||
                other.netValue == netValue) &&
            const DeepCollectionEquality()
                .equals(other._collectFrom, _collectFrom) &&
            const DeepCollectionEquality().equals(other._payTo, _payTo) &&
            const DeepCollectionEquality()
                .equals(other._settlementLog, _settlementLog) &&
            const DeepCollectionEquality().equals(other._trend, _trend) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalBalance,
      totalOwed,
      totalDue,
      netValue,
      const DeepCollectionEquality().hash(_collectFrom),
      const DeepCollectionEquality().hash(_payTo),
      const DeepCollectionEquality().hash(_settlementLog),
      const DeepCollectionEquality().hash(_trend),
      const DeepCollectionEquality().hash(_paymentMethods),
      fetchedAt,
      timeframe);

  /// Create a copy of WalletOverview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletOverviewImplCopyWith<_$WalletOverviewImpl> get copyWith =>
      __$$WalletOverviewImplCopyWithImpl<_$WalletOverviewImpl>(
          this, _$identity);
}

abstract class _WalletOverview implements WalletOverview {
  const factory _WalletOverview(
      {required final double totalBalance,
      required final double totalOwed,
      required final double totalDue,
      required final double netValue,
      required final List<WalletCounterparty> collectFrom,
      required final List<WalletCounterparty> payTo,
      required final List<WalletSettlementLogEntry> settlementLog,
      required final List<WalletTrendPoint> trend,
      required final List<WalletPaymentMethod> paymentMethods,
      required final DateTime fetchedAt,
      required final WalletTimeframe timeframe}) = _$WalletOverviewImpl;

  @override
  double get totalBalance;
  @override
  double get totalOwed;
  @override
  double get totalDue;
  @override
  double get netValue;
  @override
  List<WalletCounterparty> get collectFrom;
  @override
  List<WalletCounterparty> get payTo;
  @override
  List<WalletSettlementLogEntry> get settlementLog;
  @override
  List<WalletTrendPoint> get trend;
  @override
  List<WalletPaymentMethod> get paymentMethods;
  @override
  DateTime get fetchedAt;
  @override
  WalletTimeframe get timeframe;

  /// Create a copy of WalletOverview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletOverviewImplCopyWith<_$WalletOverviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
