import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  BiometricAuthService(this._localAuth);

  final LocalAuthentication _localAuth;

  Future<bool> canCheckBiometrics() => _localAuth.canCheckBiometrics;

  Future<bool> isDeviceSupported() => _localAuth.isDeviceSupported();

  Future<bool> authenticate({required String reason}) {
    return _localAuth.authenticate(
      localizedReason: reason,
      options:
          const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
    );
  }
}

final biometricAuthServiceProvider = Provider<BiometricAuthService>(
  (ref) => BiometricAuthService(LocalAuthentication()),
);
