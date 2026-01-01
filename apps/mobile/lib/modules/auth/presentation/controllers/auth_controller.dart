import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/usecases/authenticate_with_biometrics.dart';
import '../../domain/usecases/check_biometric_support.dart';
import '../../domain/usecases/check_onboarding_status.dart';
import '../../domain/usecases/complete_onboarding.dart';
import '../../domain/usecases/get_biometrics_enabled.dart';
import '../../domain/usecases/observe_auth_state.dart';
import '../../domain/usecases/refresh_session.dart';
import '../../domain/usecases/restore_session.dart';
import '../../domain/usecases/send_password_reset.dart';
import '../../domain/usecases/set_biometrics_enabled.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../state/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required SignInWithEmailUseCase signInWithEmail,
    required SignUpWithEmailUseCase signUpWithEmail,
    required SendPasswordResetUseCase sendPasswordReset,
    required SignOutUseCase signOut,
    required RefreshSessionUseCase refreshSession,
    required RestoreSessionUseCase restoreSession,
    required ObserveAuthStateUseCase observeAuthState,
    required CompleteOnboardingUseCase completeOnboarding,
    required CheckOnboardingStatusUseCase checkOnboardingStatus,
    required SetBiometricsEnabledUseCase setBiometricsEnabled,
    required GetBiometricsEnabledUseCase getBiometricsEnabled,
    required CheckBiometricSupportUseCase checkBiometricSupport,
    required AuthenticateWithBiometricsUseCase authenticateWithBiometrics,
  })  : _signInWithEmail = signInWithEmail,
        _signUpWithEmail = signUpWithEmail,
        _sendPasswordReset = sendPasswordReset,
        _signOut = signOut,
        _refreshSession = refreshSession,
        _restoreSession = restoreSession,
        _observeAuthState = observeAuthState,
        _completeOnboarding = completeOnboarding,
        _checkOnboardingStatus = checkOnboardingStatus,
        _setBiometricsEnabled = setBiometricsEnabled,
        _getBiometricsEnabled = getBiometricsEnabled,
        _checkBiometricSupport = checkBiometricSupport,
        _authenticateWithBiometrics = authenticateWithBiometrics,
        super(AuthState.initial()) {
    _initialize();
    _subscription = _observeAuthState().listen(_handleAuthSession);
  }

  final SignInWithEmailUseCase _signInWithEmail;
  final SignUpWithEmailUseCase _signUpWithEmail;
  final SendPasswordResetUseCase _sendPasswordReset;
  final SignOutUseCase _signOut;
  final RefreshSessionUseCase _refreshSession;
  final RestoreSessionUseCase _restoreSession;
  final ObserveAuthStateUseCase _observeAuthState;
  final CompleteOnboardingUseCase _completeOnboarding;
  final CheckOnboardingStatusUseCase _checkOnboardingStatus;
  final SetBiometricsEnabledUseCase _setBiometricsEnabled;
  final GetBiometricsEnabledUseCase _getBiometricsEnabled;
  final CheckBiometricSupportUseCase _checkBiometricSupport;
  final AuthenticateWithBiometricsUseCase _authenticateWithBiometrics;

  StreamSubscription<AuthSession?>? _subscription;

  Future<void> _initialize() async {
    final hasOnboarded = await _checkOnboardingStatus();
    final biometricsEnabled = await _getBiometricsEnabled();
    final canUseBiometrics = await _checkBiometricSupport();

    final session = await _restoreSession();

    if (!hasOnboarded) {
      state = state.copyWith(
        status: AuthStatus.needsOnboarding,
        hasCompletedOnboarding: false,
        biometricsEnabled: biometricsEnabled,
        canUseBiometrics: canUseBiometrics,
      );
      return;
    }

    if (session != null) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: session.user,
        hasCompletedOnboarding: true,
        biometricsEnabled: biometricsEnabled,
        canUseBiometrics: canUseBiometrics,
        errorMessage: null,
      );
    } else {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        hasCompletedOnboarding: true,
        biometricsEnabled: biometricsEnabled,
        canUseBiometrics: canUseBiometrics,
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    bool enableBiometrics = false,
  }) async {
    state =
        state.copyWith(status: AuthStatus.authenticating, errorMessage: null);

    try {
      final session = await _signInWithEmail(email: email, password: password);
      if (enableBiometrics) {
        await _setBiometricsEnabled(true);
      }
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: session.user,
        biometricsEnabled: enableBiometrics ? true : state.biometricsEnabled,
        errorMessage: null,
      );
    } on AuthFailure catch (failure) {
      _emitFailure(failure);
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    state =
        state.copyWith(status: AuthStatus.authenticating, errorMessage: null);
    try {
      final session =
          await _signUpWithEmail(name: name, email: email, password: password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: session.user,
        hasCompletedOnboarding: true,
      );
    } on AuthFailure catch (failure) {
      _emitFailure(failure);
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _sendPasswordReset(email);
      state = state.copyWith(passwordResetSent: true, errorMessage: null);
    } on AuthFailure catch (failure) {
      _emitFailure(failure);
    }
  }

  Future<void> signOut() async {
    await _signOut();
    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }

  Future<void> refreshSession() async {
    state = state.copyWith(status: AuthStatus.authenticating);
    final session = await _refreshSession();
    if (session != null) {
      state =
          state.copyWith(status: AuthStatus.authenticated, user: session.user);
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> completeOnboarding() async {
    await _completeOnboarding();
    state = state.copyWith(
      hasCompletedOnboarding: true,
      status: AuthStatus.unauthenticated,
    );
  }

  Future<void> setBiometricsEnabled(bool enabled) async {
    await _setBiometricsEnabled(enabled);
    final canUse = await _checkBiometricSupport();
    state = state.copyWith(
      biometricsEnabled: enabled,
      canUseBiometrics: canUse,
    );
  }

  Future<void> authenticateWithBiometrics() async {
    state =
        state.copyWith(status: AuthStatus.authenticating, errorMessage: null);
    try {
      final session = await _authenticateWithBiometrics();
      if (session == null) {
        state = state.copyWith(status: AuthStatus.unauthenticated);
        return;
      }
      state =
          state.copyWith(status: AuthStatus.authenticated, user: session.user);
    } on AuthFailure catch (failure) {
      _emitFailure(failure);
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  void _handleAuthSession(AuthSession? session) {
    if (session == null) {
      if (state.hasCompletedOnboarding) {
        state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
      }
      return;
    }

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: session.user,
      hasCompletedOnboarding: true,
    );
  }

  void _emitFailure(AuthFailure failure) {
    final message = failure.when(
      network: (msg) => msg ?? 'Network error',
      invalidCredentials: (msg) => msg ?? 'Invalid credentials',
      biometricUnavailable: (msg) => msg ?? 'Biometric login unavailable',
      unknown: (msg) => msg ?? 'Unknown error',
    );
    state = state.copyWith(status: AuthStatus.error, errorMessage: message);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    signInWithEmail: ref.watch(signInWithEmailUseCaseProvider),
    signUpWithEmail: ref.watch(signUpWithEmailUseCaseProvider),
    sendPasswordReset: ref.watch(sendPasswordResetUseCaseProvider),
    signOut: ref.watch(signOutUseCaseProvider),
    refreshSession: ref.watch(refreshSessionUseCaseProvider),
    restoreSession: ref.watch(restoreSessionUseCaseProvider),
    observeAuthState: ref.watch(observeAuthStateUseCaseProvider),
    completeOnboarding: ref.watch(completeOnboardingUseCaseProvider),
    checkOnboardingStatus: ref.watch(checkOnboardingStatusUseCaseProvider),
    setBiometricsEnabled: ref.watch(setBiometricsEnabledUseCaseProvider),
    getBiometricsEnabled: ref.watch(getBiometricsEnabledUseCaseProvider),
    checkBiometricSupport: ref.watch(checkBiometricSupportUseCaseProvider),
    authenticateWithBiometrics:
        ref.watch(authenticateWithBiometricsUseCaseProvider),
  );
});
