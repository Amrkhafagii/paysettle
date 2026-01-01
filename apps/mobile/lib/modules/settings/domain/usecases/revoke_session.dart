import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';

class RevokeSessionUseCase {
  RevokeSessionUseCase(this._repository);

  final SettingsRepository _repository;

  Future<UserSessionInfo?> call(String sessionId) {
    return _repository.revokeSession(sessionId);
  }
}
