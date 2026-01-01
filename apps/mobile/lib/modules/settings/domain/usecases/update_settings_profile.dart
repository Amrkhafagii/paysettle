import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';
import '../value_objects/update_profile_request.dart';

class UpdateSettingsProfileUseCase {
  UpdateSettingsProfileUseCase(this._repository);

  final SettingsRepository _repository;

  Future<SettingsProfile> call(UpdateProfileRequest request) {
    return _repository.updateProfile(request);
  }
}
