import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_user.dart';

part 'auth_session.freezed.dart';

@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required AuthUser user,
  }) = _AuthSession;
}
