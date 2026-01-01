import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_keys.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../dtos/auth_session_dto.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this._cache);

  final CacheService _cache;

  Future<void> cacheSession(AuthSessionDto session) {
    return _cache.write(
        CacheBox.secure, CacheKeys.authSession, session.toJson());
  }

  AuthSessionDto? readCachedSession() {
    final data = _cache.read<Map<dynamic, dynamic>>(
        CacheBox.secure, CacheKeys.authSession);
    if (data == null) {
      return null;
    }
    return AuthSessionDto.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> clearSession() =>
      _cache.delete(CacheBox.secure, CacheKeys.authSession);

  Future<void> setOnboardingComplete(bool value) {
    return _cache.write(CacheBox.core, CacheKeys.onboardingComplete, value);
  }

  bool hasCompletedOnboarding() {
    return _cache.read<bool>(CacheBox.core, CacheKeys.onboardingComplete) ??
        false;
  }

  Future<void> setBiometricsEnabled(bool enabled) {
    return _cache.write(CacheBox.secure, CacheKeys.biometricsEnabled, enabled);
  }

  bool isBiometricsEnabled() {
    return _cache.read<bool>(CacheBox.secure, CacheKeys.biometricsEnabled) ??
        false;
  }
}

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSource(ref.watch(cacheServiceProvider)),
);
