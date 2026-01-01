import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure implements Exception {
  const factory AuthFailure.network([String? message]) = _NetworkFailure;
  const factory AuthFailure.invalidCredentials([String? message]) =
      _InvalidCredentialsFailure;
  const factory AuthFailure.biometricUnavailable([String? message]) =
      _BiometricUnavailableFailure;
  const factory AuthFailure.unknown([String? message]) = _UnknownFailure;
}
