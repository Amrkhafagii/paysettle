import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../domain/entities/auth_user.dart';

part 'auth_user_dto.freezed.dart';
part 'auth_user_dto.g.dart';

@freezed
class AuthUserDto with _$AuthUserDto {
  const factory AuthUserDto({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    DateTime? createdAt,
  }) = _AuthUserDto;

  factory AuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDtoFromJson(json);

  factory AuthUserDto.fromSupabase(supa.User user) {
    final metadata = user.userMetadata ?? <String, dynamic>{};
    final name =
        metadata['full_name'] as String? ?? metadata['name'] as String?;
    final createdAt = _parseDate(user.createdAt);
    return AuthUserDto(
      id: user.id,
      email: user.email ?? '',
      name: name,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: createdAt,
    );
  }
}

extension AuthUserDtoX on AuthUserDto {
  AuthUser toDomain() {
    return AuthUser(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
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
