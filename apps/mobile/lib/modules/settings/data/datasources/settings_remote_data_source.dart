import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../../domain/entities/settings_overview.dart';
import '../../domain/value_objects/data_export_request.dart';
import '../../domain/value_objects/preferences_update.dart';
import '../../domain/value_objects/update_profile_request.dart';

class SettingsRemoteDataSource {
  SettingsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<Map<String, dynamic>> fetchOverview() async {
    final response =
        await _client.rpc<Map<String, dynamic>>('settings_overview');
    return response;
  }

  Future<Map<String, dynamic>> updateProfile(UpdateProfileRequest request) {
    final params = <String, dynamic>{
      'p_full_name': request.fullName,
      if (request.phone != null) 'p_phone': request.phone,
      if (request.avatarUrl != null) 'p_avatar_url': request.avatarUrl,
      if (request.jobTitle != null) 'p_job_title': request.jobTitle,
      if (request.country != null) 'p_country': request.country,
      if (request.timezone != null) 'p_timezone': request.timezone,
    };
    return _client.rpc<Map<String, dynamic>>(
      'update_user_profile',
      params: params,
    );
  }

  Future<Map<String, dynamic>> updatePreferences(PreferencesUpdate update) {
    if (update.isEmpty) {
      throw ArgumentError('Preferences update cannot be empty');
    }
    final params = <String, dynamic>{
      if (update.currency != null) 'p_preferred_currency': update.currency,
      if (update.theme != null) 'p_dark_mode': update.theme!.apiValue,
      if (update.notificationsEnabled != null)
        'p_notifications_enabled': update.notificationsEnabled,
      if (update.faceIdEnabled != null)
        'p_face_id_enabled': update.faceIdEnabled,
    };
    return _client.rpc<Map<String, dynamic>>(
      'update_app_preferences',
      params: params,
    );
  }

  Future<Map<String, dynamic>> requestDataExport(
      DataExportRequest request) {
    final params = {
      'p_export_type': request.type.apiValue,
      'p_format': request.format.apiValue,
    };
    return _client.rpc<Map<String, dynamic>>(
      'request_data_export',
      params: params,
    );
  }

  Future<Map<String, dynamic>> connectAccounting(String provider) {
    return _client.rpc<Map<String, dynamic>>(
      'connect_accounting_provider',
      params: {'p_provider': provider},
    );
  }

  Future<Map<String, dynamic>> triggerConnectorSync({
    required String connectorId,
    String eventType = 'sync',
  }) {
    return _client.rpc<Map<String, dynamic>>(
      'trigger_connector_webhook',
      params: {
        'p_connector_id': connectorId,
        'p_event': eventType,
      },
    );
  }

  Future<Map<String, dynamic>?> revokeSession(String sessionId) {
    return _client.rpc<Map<String, dynamic>?>(
      'revoke_user_session',
      params: {'p_session_id': sessionId},
    );
  }
}

final settingsRemoteDataSourceProvider =
    Provider<SettingsRemoteDataSource>((ref) {
  return SettingsRemoteDataSource(ref.watch(supabaseClientProvider));
});
