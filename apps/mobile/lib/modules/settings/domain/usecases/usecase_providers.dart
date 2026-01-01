import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_service.dart';
import '../../data/datasources/settings_remote_data_source.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../repositories/settings_repository.dart';
import 'connect_accounting_provider.dart';
import 'get_settings_overview.dart';
import 'request_data_export.dart';
import 'revoke_session.dart';
import 'trigger_connector_sync.dart';
import 'update_settings_preferences.dart';
import 'update_settings_profile.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    remoteDataSource: ref.watch(settingsRemoteDataSourceProvider),
    cacheService: ref.watch(cacheServiceProvider),
  );
});

final getSettingsOverviewUseCaseProvider =
    Provider<GetSettingsOverviewUseCase>((ref) {
  return GetSettingsOverviewUseCase(ref.watch(settingsRepositoryProvider));
});

final updateSettingsProfileUseCaseProvider =
    Provider<UpdateSettingsProfileUseCase>((ref) {
  return UpdateSettingsProfileUseCase(ref.watch(settingsRepositoryProvider));
});

final updateSettingsPreferencesUseCaseProvider =
    Provider<UpdateSettingsPreferencesUseCase>((ref) {
  return UpdateSettingsPreferencesUseCase(ref.watch(settingsRepositoryProvider));
});

final requestDataExportUseCaseProvider =
    Provider<RequestDataExportUseCase>((ref) {
  return RequestDataExportUseCase(ref.watch(settingsRepositoryProvider));
});

final connectAccountingProviderUseCaseProvider =
    Provider<ConnectAccountingProviderUseCase>((ref) {
  return ConnectAccountingProviderUseCase(
    ref.watch(settingsRepositoryProvider),
  );
});

final triggerConnectorSyncUseCaseProvider =
    Provider<TriggerConnectorSyncUseCase>((ref) {
  return TriggerConnectorSyncUseCase(ref.watch(settingsRepositoryProvider));
});

final revokeSessionUseCaseProvider = Provider<RevokeSessionUseCase>((ref) {
  return RevokeSessionUseCase(ref.watch(settingsRepositoryProvider));
});
