import '../entities/settings_overview.dart';
import '../value_objects/data_export_request.dart';
import '../value_objects/preferences_update.dart';
import '../value_objects/update_profile_request.dart';

abstract class SettingsRepository {
  Future<SettingsOverview> fetchOverview();
  Future<SettingsProfile> updateProfile(UpdateProfileRequest request);
  Future<AppPreferences> updatePreferences(PreferencesUpdate update);
  Future<DataExportJob> requestDataExport(DataExportRequest request);
  Future<AccountingConnector> connectAccounting(String provider);
  Future<AccountingConnectorEvent> triggerConnectorSync({
    required String connectorId,
    String eventType,
  });
  Future<UserSessionInfo?> revokeSession(String sessionId);
}
