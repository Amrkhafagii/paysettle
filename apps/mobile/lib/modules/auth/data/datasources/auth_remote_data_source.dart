import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../dtos/auth_session_dto.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<AuthSessionDto> signIn(
      {required String email, required String password}) async {
    final response =
        await _client.auth.signInWithPassword(email: email, password: password);
    final session = response.session;
    if (session == null) {
      throw AuthException('Missing session information',
          statusCode: 'auth_session_missing');
    }
    return AuthSessionDto.fromSupabase(session);
  }

  Future<AuthSessionDto> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': name,
      },
    );

    final session = response.session;
    if (session == null) {
      throw AuthException('Signup requires email confirmation');
    }
    return AuthSessionDto.fromSupabase(session);
  }

  Future<void> sendPasswordReset(String email) {
    return _client.auth.resetPasswordForEmail(email);
  }

  Future<void> signOut() => _client.auth.signOut();

  Future<AuthSessionDto?> currentSession() async {
    final session = _client.auth.currentSession;
    if (session == null) {
      return null;
    }
    return AuthSessionDto.fromSupabase(session);
  }

  Future<AuthSessionDto> refreshSession() async {
    final response = await _client.auth.refreshSession();
    final session = response.session;
    if (session == null) {
      throw AuthException('Unable to refresh session');
    }
    return AuthSessionDto.fromSupabase(session);
  }

  Stream<AuthSessionDto?> authStateChanges() {
    return _client.auth.onAuthStateChange.map(
      (event) => event.session != null
          ? AuthSessionDto.fromSupabase(event.session!)
          : null,
    );
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.watch(supabaseClientProvider)),
);
