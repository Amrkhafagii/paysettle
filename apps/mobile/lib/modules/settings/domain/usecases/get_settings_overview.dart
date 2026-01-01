import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';

class GetSettingsOverviewUseCase {
  GetSettingsOverviewUseCase(this._repository);

  final SettingsRepository _repository;

  Future<SettingsOverview> call() => _repository.fetchOverview();
}
