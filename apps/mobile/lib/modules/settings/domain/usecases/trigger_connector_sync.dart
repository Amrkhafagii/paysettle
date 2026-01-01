import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';

class TriggerConnectorSyncUseCase {
  TriggerConnectorSyncUseCase(this._repository);

  final SettingsRepository _repository;

  Future<AccountingConnectorEvent> call({
    required String connectorId,
    String eventType = 'sync',
  }) {
    return _repository.triggerConnectorSync(
      connectorId: connectorId,
      eventType: eventType,
    );
  }
}
