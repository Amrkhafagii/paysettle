import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> signInWithEmail(
      {required String email, required String password});
  Future<AuthSession> signUpWithEmail(
      {required String name, required String email, required String password});
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
  Future<AuthSession?> refreshSession();
  Future<AuthSession?> restorePersistedSession();
  Stream<AuthSession?> authStateChanges();

  Future<void> markOnboardingComplete();
  Future<bool> hasCompletedOnboarding();

  Future<void> setBiometricsEnabled(bool enabled);
  Future<bool> isBiometricsEnabled();
  Future<bool> canUseBiometrics();
  Future<AuthSession?> authenticateWithBiometrics();
}
