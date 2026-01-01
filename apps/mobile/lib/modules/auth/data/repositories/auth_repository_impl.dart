import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../dtos/auth_session_dto.dart';
import '../services/biometric_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required BiometricAuthService biometricAuthService,
  })  : _remote = remoteDataSource,
        _local = localDataSource,
        _biometrics = biometricAuthService;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final BiometricAuthService _biometrics;

  @override
  Future<AuthSession> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final dto = await _remote.signIn(email: email, password: password);
      await _local.cacheSession(dto);
      return dto.toDomain();
    } on AuthException catch (error) {
      throw AuthFailure.invalidCredentials(error.message);
    } catch (_) {
      throw const AuthFailure.unknown();
    }
  }

  @override
  Future<AuthSession> signUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final dto =
          await _remote.signUp(name: name, email: email, password: password);
      await _local.cacheSession(dto);
      return dto.toDomain();
    } on AuthException catch (error) {
      throw AuthFailure.invalidCredentials(error.message);
    } catch (_) {
      throw const AuthFailure.unknown();
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await _remote.sendPasswordReset(email);
    } on AuthException catch (error) {
      throw AuthFailure.network(error.message);
    } catch (_) {
      throw const AuthFailure.unknown();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _remote.signOut();
      await _local.clearSession();
    } catch (_) {
      throw const AuthFailure.unknown();
    }
  }

  @override
  Future<AuthSession?> refreshSession() async {
    try {
      final session = await _remote.refreshSession();
      await _local.cacheSession(session);
      return session.toDomain();
    } on AuthException catch (error) {
      throw AuthFailure.network(error.message);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AuthSession?> restorePersistedSession() async {
    final remoteSession = await _remote.currentSession();
    if (remoteSession != null) {
      await _local.cacheSession(remoteSession);
      return remoteSession.toDomain();
    }

    final cached = _local.readCachedSession();
    return cached?.toDomain();
  }

  @override
  Stream<AuthSession?> authStateChanges() {
    return _remote.authStateChanges().asyncMap((dto) async {
      if (dto != null) {
        await _local.cacheSession(dto);
      } else {
        await _local.clearSession();
      }
      return dto?.toDomain();
    });
  }

  @override
  Future<void> markOnboardingComplete() => _local.setOnboardingComplete(true);

  @override
  Future<bool> hasCompletedOnboarding() async =>
      _local.hasCompletedOnboarding();

  @override
  Future<void> setBiometricsEnabled(bool enabled) =>
      _local.setBiometricsEnabled(enabled);

  @override
  Future<bool> isBiometricsEnabled() async => _local.isBiometricsEnabled();

  @override
  Future<bool> canUseBiometrics() async {
    final supported = await _biometrics.isDeviceSupported();
    if (!supported) {
      return false;
    }
    return _biometrics.canCheckBiometrics();
  }

  @override
  Future<AuthSession?> authenticateWithBiometrics() async {
    final biometricsEnabled = await isBiometricsEnabled();
    if (!biometricsEnabled) {
      throw const AuthFailure.biometricUnavailable();
    }
    final canAuthenticate = await canUseBiometrics();
    if (!canAuthenticate) {
      throw const AuthFailure.biometricUnavailable();
    }

    final success = await _biometrics.authenticate(reason: 'Unlock PaySettle');
    if (!success) {
      throw const AuthFailure.biometricUnavailable();
    }

    final existingSession = await _remote.currentSession();
    if (existingSession != null) {
      return existingSession.toDomain();
    }

    try {
      final refreshed = await _remote.refreshSession();
      await _local.cacheSession(refreshed);
      return refreshed.toDomain();
    } catch (_) {
      return null;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);
  final biometrics = ref.watch(biometricAuthServiceProvider);
  return AuthRepositoryImpl(
      remoteDataSource: remote,
      localDataSource: local,
      biometricAuthService: biometrics);
});
