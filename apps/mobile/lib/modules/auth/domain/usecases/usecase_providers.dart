import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/auth_repository_impl.dart';
import 'authenticate_with_biometrics.dart';
import 'check_biometric_support.dart';
import 'check_onboarding_status.dart';
import 'complete_onboarding.dart';
import 'get_biometrics_enabled.dart';
import 'observe_auth_state.dart';
import 'refresh_session.dart';
import 'restore_session.dart';
import 'send_password_reset.dart';
import 'set_biometrics_enabled.dart';
import 'sign_in_with_email.dart';
import 'sign_out.dart';
import 'sign_up_with_email.dart';

final signInWithEmailUseCaseProvider = Provider(
    (ref) => SignInWithEmailUseCase(ref.watch(authRepositoryProvider)));
final signUpWithEmailUseCaseProvider = Provider(
    (ref) => SignUpWithEmailUseCase(ref.watch(authRepositoryProvider)));
final sendPasswordResetUseCaseProvider = Provider(
    (ref) => SendPasswordResetUseCase(ref.watch(authRepositoryProvider)));
final signOutUseCaseProvider =
    Provider((ref) => SignOutUseCase(ref.watch(authRepositoryProvider)));
final refreshSessionUseCaseProvider =
    Provider((ref) => RefreshSessionUseCase(ref.watch(authRepositoryProvider)));
final restoreSessionUseCaseProvider =
    Provider((ref) => RestoreSessionUseCase(ref.watch(authRepositoryProvider)));
final observeAuthStateUseCaseProvider = Provider(
    (ref) => ObserveAuthStateUseCase(ref.watch(authRepositoryProvider)));
final completeOnboardingUseCaseProvider = Provider(
    (ref) => CompleteOnboardingUseCase(ref.watch(authRepositoryProvider)));
final checkOnboardingStatusUseCaseProvider = Provider(
    (ref) => CheckOnboardingStatusUseCase(ref.watch(authRepositoryProvider)));
final setBiometricsEnabledUseCaseProvider = Provider(
    (ref) => SetBiometricsEnabledUseCase(ref.watch(authRepositoryProvider)));
final getBiometricsEnabledUseCaseProvider = Provider(
    (ref) => GetBiometricsEnabledUseCase(ref.watch(authRepositoryProvider)));
final checkBiometricSupportUseCaseProvider = Provider(
    (ref) => CheckBiometricSupportUseCase(ref.watch(authRepositoryProvider)));
final authenticateWithBiometricsUseCaseProvider = Provider((ref) =>
    AuthenticateWithBiometricsUseCase(ref.watch(authRepositoryProvider)));
