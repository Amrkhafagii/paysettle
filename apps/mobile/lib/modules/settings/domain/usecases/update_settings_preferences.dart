import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';
import '../value_objects/preferences_update.dart';

class UpdateSettingsPreferencesUseCase {
  UpdateSettingsPreferencesUseCase(this._repository);

  final SettingsRepository _repository;

  Future<AppPreferences> call(PreferencesUpdate update) {
    return _repository.updatePreferences(update);
  }
}
