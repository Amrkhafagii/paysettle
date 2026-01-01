// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BudgetCategoryOption {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  bool get isSystem => throw _privateConstructorUsedError;

  /// Create a copy of BudgetCategoryOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetCategoryOptionCopyWith<BudgetCategoryOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCategoryOptionCopyWith<$Res> {
  factory $BudgetCategoryOptionCopyWith(BudgetCategoryOption value,
          $Res Function(BudgetCategoryOption) then) =
      _$BudgetCategoryOptionCopyWithImpl<$Res, BudgetCategoryOption>;
  @useResult
  $Res call(
      {String id, String label, String? icon, String? color, bool isSystem});
}

/// @nodoc
class _$BudgetCategoryOptionCopyWithImpl<$Res,
        $Val extends BudgetCategoryOption>
    implements $BudgetCategoryOptionCopyWith<$Res> {
  _$BudgetCategoryOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetCategoryOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? icon = freezed,
    Object? color = freezed,
    Object? isSystem = null,
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
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isSystem: null == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetCategoryOptionImplCopyWith<$Res>
    implements $BudgetCategoryOptionCopyWith<$Res> {
  factory _$$BudgetCategoryOptionImplCopyWith(_$BudgetCategoryOptionImpl value,
          $Res Function(_$BudgetCategoryOptionImpl) then) =
      __$$BudgetCategoryOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String label, String? icon, String? color, bool isSystem});
}

/// @nodoc
class __$$BudgetCategoryOptionImplCopyWithImpl<$Res>
    extends _$BudgetCategoryOptionCopyWithImpl<$Res, _$BudgetCategoryOptionImpl>
    implements _$$BudgetCategoryOptionImplCopyWith<$Res> {
  __$$BudgetCategoryOptionImplCopyWithImpl(_$BudgetCategoryOptionImpl _value,
      $Res Function(_$BudgetCategoryOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of BudgetCategoryOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? icon = freezed,
    Object? color = freezed,
    Object? isSystem = null,
  }) {
    return _then(_$BudgetCategoryOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isSystem: null == isSystem
          ? _value.isSystem
          : isSystem // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BudgetCategoryOptionImpl implements _BudgetCategoryOption {
  const _$BudgetCategoryOptionImpl(
      {required this.id,
      required this.label,
      this.icon,
      this.color,
      this.isSystem = false});

  @override
  final String id;
  @override
  final String label;
  @override
  final String? icon;
  @override
  final String? color;
  @override
  @JsonKey()
  final bool isSystem;

  @override
  String toString() {
    return 'BudgetCategoryOption(id: $id, label: $label, icon: $icon, color: $color, isSystem: $isSystem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCategoryOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isSystem, isSystem) ||
                other.isSystem == isSystem));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, icon, color, isSystem);

  /// Create a copy of BudgetCategoryOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCategoryOptionImplCopyWith<_$BudgetCategoryOptionImpl>
      get copyWith =>
          __$$BudgetCategoryOptionImplCopyWithImpl<_$BudgetCategoryOptionImpl>(
              this, _$identity);
}

abstract class _BudgetCategoryOption implements BudgetCategoryOption {
  const factory _BudgetCategoryOption(
      {required final String id,
      required final String label,
      final String? icon,
      final String? color,
      final bool isSystem}) = _$BudgetCategoryOptionImpl;

  @override
  String get id;
  @override
  String get label;
  @override
  String? get icon;
  @override
  String? get color;
  @override
  bool get isSystem;

  /// Create a copy of BudgetCategoryOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetCategoryOptionImplCopyWith<_$BudgetCategoryOptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
