import '../entities/settings_overview.dart';
import '../repositories/settings_repository.dart';

class ConnectAccountingProviderUseCase {
  ConnectAccountingProviderUseCase(this._repository);

  final SettingsRepository _repository;

  Future<AccountingConnector> call(String provider) {
    return _repository.connectAccounting(provider);
  }
}
