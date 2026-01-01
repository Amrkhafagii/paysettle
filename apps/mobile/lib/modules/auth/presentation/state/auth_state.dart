import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_user.dart';

part 'auth_state.freezed.dart';

enum AuthStatus {
  initializing,
  needsOnboarding,
  unauthenticated,
  authenticating,
  authenticated,
  error,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required AuthStatus status,
    AuthUser? user,
    String? errorMessage,
    @Default(false) bool hasCompletedOnboarding,
    @Default(false) bool canUseBiometrics,
    @Default(false) bool biometricsEnabled,
    @Default(false) bool passwordResetSent,
  }) = _AuthState;

  const AuthState._();

  factory AuthState.initial() =>
      const AuthState(status: AuthStatus.initializing);

  bool get isLoading =>
      status == AuthStatus.initializing || status == AuthStatus.authenticating;
}
