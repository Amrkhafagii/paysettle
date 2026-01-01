import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../domain/entities/auth_session.dart';
import 'auth_user_dto.dart';

part 'auth_session_dto.freezed.dart';
part 'auth_session_dto.g.dart';

@freezed
class AuthSessionDto with _$AuthSessionDto {
  const factory AuthSessionDto({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required AuthUserDto user,
  }) = _AuthSessionDto;

  factory AuthSessionDto.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionDtoFromJson(json);

  factory AuthSessionDto.fromSupabase(supa.Session session) {
    final supabaseUser = session.user;
    if (supabaseUser == null) {
      throw StateError('Supabase session missing user payload');
    }

    final expiresAt = _parseDate(session.expiresAt);
    return AuthSessionDto(
      accessToken: session.accessToken ?? '',
      refreshToken: session.refreshToken ?? '',
      expiresAt: expiresAt ?? DateTime.now(),
      user: AuthUserDto.fromSupabase(supabaseUser),
    );
  }
}

extension AuthSessionDtoX on AuthSessionDto {
  AuthSession toDomain() {
    return AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      user: user.toDomain(),
    );
  }
}

DateTime? _parseDate(dynamic value) {
  if (value is DateTime) {
    return value;
  }
  if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}
