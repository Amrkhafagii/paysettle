// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthFailure {
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) network,
    required TResult Function(String? message) invalidCredentials,
    required TResult Function(String? message) biometricUnavailable,
    required TResult Function(String? message) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? invalidCredentials,
    TResult? Function(String? message)? biometricUnavailable,
    TResult? Function(String? message)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? network,
    TResult Function(String? message)? invalidCredentials,
    TResult Function(String? message)? biometricUnavailable,
    TResult Function(String? message)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidCredentialsFailure value)
        invalidCredentials,
    required TResult Function(_BiometricUnavailableFailure value)
        biometricUnavailable,
    required TResult Function(_UnknownFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult? Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult? Function(_UnknownFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult Function(_UnknownFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthFailureCopyWith<AuthFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res, AuthFailure>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res, $Val extends AuthFailure>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NetworkFailureImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl implements _NetworkFailure {
  const _$NetworkFailureImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) network,
    required TResult Function(String? message) invalidCredentials,
    required TResult Function(String? message) biometricUnavailable,
    required TResult Function(String? message) unknown,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? invalidCredentials,
    TResult? Function(String? message)? biometricUnavailable,
    TResult? Function(String? message)? unknown,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? network,
    TResult Function(String? message)? invalidCredentials,
    TResult Function(String? message)? biometricUnavailable,
    TResult Function(String? message)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidCredentialsFailure value)
        invalidCredentials,
    required TResult Function(_BiometricUnavailableFailure value)
        biometricUnavailable,
    required TResult Function(_UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult? Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult? Function(_UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult Function(_UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class _NetworkFailure implements AuthFailure {
  const factory _NetworkFailure([final String? message]) = _$NetworkFailureImpl;

  @override
  String? get message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidCredentialsFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$InvalidCredentialsFailureImplCopyWith(
          _$InvalidCredentialsFailureImpl value,
          $Res Function(_$InvalidCredentialsFailureImpl) then) =
      __$$InvalidCredentialsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$InvalidCredentialsFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$InvalidCredentialsFailureImpl>
    implements _$$InvalidCredentialsFailureImplCopyWith<$Res> {
  __$$InvalidCredentialsFailureImplCopyWithImpl(
      _$InvalidCredentialsFailureImpl _value,
      $Res Function(_$InvalidCredentialsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$InvalidCredentialsFailureImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InvalidCredentialsFailureImpl implements _InvalidCredentialsFailure {
  const _$InvalidCredentialsFailureImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.invalidCredentials(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidCredentialsFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidCredentialsFailureImplCopyWith<_$InvalidCredentialsFailureImpl>
      get copyWith => __$$InvalidCredentialsFailureImplCopyWithImpl<
          _$InvalidCredentialsFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) network,
    required TResult Function(String? message) invalidCredentials,
    required TResult Function(String? message) biometricUnavailable,
    required TResult Function(String? message) unknown,
  }) {
    return invalidCredentials(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? invalidCredentials,
    TResult? Function(String? message)? biometricUnavailable,
    TResult? Function(String? message)? unknown,
  }) {
    return invalidCredentials?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? network,
    TResult Function(String? message)? invalidCredentials,
    TResult Function(String? message)? biometricUnavailable,
    TResult Function(String? message)? unknown,
    required TResult orElse(),
  }) {
    if (invalidCredentials != null) {
      return invalidCredentials(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidCredentialsFailure value)
        invalidCredentials,
    required TResult Function(_BiometricUnavailableFailure value)
        biometricUnavailable,
    required TResult Function(_UnknownFailure value) unknown,
  }) {
    return invalidCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult? Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult? Function(_UnknownFailure value)? unknown,
  }) {
    return invalidCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult Function(_UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidCredentials != null) {
      return invalidCredentials(this);
    }
    return orElse();
  }
}

abstract class _InvalidCredentialsFailure implements AuthFailure {
  const factory _InvalidCredentialsFailure([final String? message]) =
      _$InvalidCredentialsFailureImpl;

  @override
  String? get message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvalidCredentialsFailureImplCopyWith<_$InvalidCredentialsFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BiometricUnavailableFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$BiometricUnavailableFailureImplCopyWith(
          _$BiometricUnavailableFailureImpl value,
          $Res Function(_$BiometricUnavailableFailureImpl) then) =
      __$$BiometricUnavailableFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$BiometricUnavailableFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$BiometricUnavailableFailureImpl>
    implements _$$BiometricUnavailableFailureImplCopyWith<$Res> {
  __$$BiometricUnavailableFailureImplCopyWithImpl(
      _$BiometricUnavailableFailureImpl _value,
      $Res Function(_$BiometricUnavailableFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$BiometricUnavailableFailureImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BiometricUnavailableFailureImpl
    implements _BiometricUnavailableFailure {
  const _$BiometricUnavailableFailureImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.biometricUnavailable(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BiometricUnavailableFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BiometricUnavailableFailureImplCopyWith<_$BiometricUnavailableFailureImpl>
      get copyWith => __$$BiometricUnavailableFailureImplCopyWithImpl<
          _$BiometricUnavailableFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) network,
    required TResult Function(String? message) invalidCredentials,
    required TResult Function(String? message) biometricUnavailable,
    required TResult Function(String? message) unknown,
  }) {
    return biometricUnavailable(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? invalidCredentials,
    TResult? Function(String? message)? biometricUnavailable,
    TResult? Function(String? message)? unknown,
  }) {
    return biometricUnavailable?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? network,
    TResult Function(String? message)? invalidCredentials,
    TResult Function(String? message)? biometricUnavailable,
    TResult Function(String? message)? unknown,
    required TResult orElse(),
  }) {
    if (biometricUnavailable != null) {
      return biometricUnavailable(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidCredentialsFailure value)
        invalidCredentials,
    required TResult Function(_BiometricUnavailableFailure value)
        biometricUnavailable,
    required TResult Function(_UnknownFailure value) unknown,
  }) {
    return biometricUnavailable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult? Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult? Function(_UnknownFailure value)? unknown,
  }) {
    return biometricUnavailable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult Function(_UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (biometricUnavailable != null) {
      return biometricUnavailable(this);
    }
    return orElse();
  }
}

abstract class _BiometricUnavailableFailure implements AuthFailure {
  const factory _BiometricUnavailableFailure([final String? message]) =
      _$BiometricUnavailableFailureImpl;

  @override
  String? get message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BiometricUnavailableFailureImplCopyWith<_$BiometricUnavailableFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $AuthFailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(_$UnknownFailureImpl value,
          $Res Function(_$UnknownFailureImpl) then) =
      __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
      _$UnknownFailureImpl _value, $Res Function(_$UnknownFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnknownFailureImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownFailureImpl implements _UnknownFailure {
  const _$UnknownFailureImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) network,
    required TResult Function(String? message) invalidCredentials,
    required TResult Function(String? message) biometricUnavailable,
    required TResult Function(String? message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? network,
    TResult? Function(String? message)? invalidCredentials,
    TResult? Function(String? message)? biometricUnavailable,
    TResult? Function(String? message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? network,
    TResult Function(String? message)? invalidCredentials,
    TResult Function(String? message)? biometricUnavailable,
    TResult Function(String? message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NetworkFailure value) network,
    required TResult Function(_InvalidCredentialsFailure value)
        invalidCredentials,
    required TResult Function(_BiometricUnavailableFailure value)
        biometricUnavailable,
    required TResult Function(_UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NetworkFailure value)? network,
    TResult? Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult? Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult? Function(_UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NetworkFailure value)? network,
    TResult Function(_InvalidCredentialsFailure value)? invalidCredentials,
    TResult Function(_BiometricUnavailableFailure value)? biometricUnavailable,
    TResult Function(_UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _UnknownFailure implements AuthFailure {
  const factory _UnknownFailure([final String? message]) = _$UnknownFailureImpl;

  @override
  String? get message;

  /// Create a copy of AuthFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
