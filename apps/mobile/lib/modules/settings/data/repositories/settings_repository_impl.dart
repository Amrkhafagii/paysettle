import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_keys.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../../domain/entities/settings_overview.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/value_objects/data_export_request.dart';
import '../../domain/value_objects/preferences_update.dart';
import '../../domain/value_objects/update_profile_request.dart';
import '../datasources/settings_remote_data_source.dart';
import '../dtos/settings_overview_dto.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required SettingsRemoteDataSource remoteDataSource,
    required CacheService cacheService,
  })  : _remote = remoteDataSource,
        _cache = cacheService;

  final SettingsRemoteDataSource _remote;
  final CacheService _cache;

  @override
  Future<SettingsOverview> fetchOverview() async {
    try {
      final response = await _remote.fetchOverview();
      await _cache.write(CacheBox.core, CacheKeys.settingsOverview, response);
      return SettingsOverviewDto.fromMap(response).toDomain();
    } catch (_) {
      final cached = _cache.read<Map<dynamic, dynamic>>(
          CacheBox.core, CacheKeys.settingsOverview);
      if (cached != null) {
        return SettingsOverviewDto.fromMap(
                Map<String, dynamic>.from(cached as Map))
            .toDomain();
      }
      rethrow;
    }
  }

  @override
  Future<SettingsProfile> updateProfile(UpdateProfileRequest request) async {
    final response = await _remote.updateProfile(request);
    final profile =
        SettingsProfileDto.fromMap(Map<String, dynamic>.from(response));
    await _patchCachedOverview((cache) {
      cache['profile'] = {
        'fullName': profile.fullName,
        'email': profile.email,
        'phone': profile.phone,
        'avatarUrl': profile.avatarUrl,
        'jobTitle': profile.jobTitle,
        'country': profile.country,
        'timezone': profile.timezone,
        'orgId': profile.orgId,
        'metadata': profile.metadata,
      };
    });
    return profile.toDomain();
  }

  @override
  Future<AppPreferences> updatePreferences(PreferencesUpdate update) async {
    final response = await _remote.updatePreferences(update);
    final dto =
        AppPreferencesDto.fromMap(Map<String, dynamic>.from(response));
    await _patchCachedOverview((cache) {
      cache['preferences'] = {
        'preferredCurrency': dto.currency,
        'darkMode': dto.theme.apiValue,
        'notificationsEnabled': dto.notificationsEnabled,
        'faceIdEnabled': dto.faceIdEnabled,
        'autoExportFormat': dto.exportFormat.apiValue,
        'featureFlags': dto.featureFlags,
        'availableCurrencies': dto.availableCurrencies,
      };
    });
    return dto.toDomain();
  }

  @override
  Future<DataExportJob> requestDataExport(DataExportRequest request) async {
    final response = await _remote.requestDataExport(request);
    final job = DataExportDto.fromMap(Map<String, dynamic>.from(response));
    await _patchCachedOverview((cache) {
      final exports = _readList(cache['exports']);
      exports.insert(0, {
        'id': job.id,
        'type': job.type.apiValue,
        'format': job.format.apiValue,
        'status': job.status,
        'requestedAt': job.requestedAt?.toIso8601String(),
        'completedAt': job.completedAt?.toIso8601String(),
        'downloadUrl': job.downloadUrl,
      });
      cache['exports'] = exports.take(5).toList();
    });
    return job.toDomain();
  }

  @override
  Future<AccountingConnector> connectAccounting(String provider) async {
    final response = await _remote.connectAccounting(provider);
    final dto =
        AccountingConnectorDto.fromMap(Map<String, dynamic>.from(response));
    await _patchCachedOverview((cache) {
      final connectors = _readList(cache['connectors']);
      final updated = {
        'id': dto.id,
        'provider': dto.provider,
        'status': dto.status,
        'lastSyncAt': dto.lastSyncAt?.toIso8601String(),
        'webhookUrl': dto.webhookUrl,
        'metadata': dto.metadata,
      };
      final index =
          connectors.indexWhere((entry) => '${entry['id']}' == dto.id);
      if (index >= 0) {
        connectors[index] = updated;
      } else {
        connectors.insert(0, updated);
      }
      cache['connectors'] = connectors;
    });
    return dto.toDomain();
  }

  @override
  Future<AccountingConnectorEvent> triggerConnectorSync({
    required String connectorId,
    String eventType = 'sync',
  }) async {
    final response = await _remote.triggerConnectorSync(
      connectorId: connectorId,
      eventType: eventType,
    );
    final dto = AccountingConnectorEventDto.fromMap(
        Map<String, dynamic>.from(response));
    await _patchCachedOverview((cache) {
      final log = _readList(cache['auditLog']);
      log.insert(0, {
        'id': dto.id,
        'action': 'connector_event',
        'targetType': 'accounting_connector_events',
        'severity': 'debug',
        'createdAt': dto.createdAt?.toIso8601String(),
        'payload': {
          'event': dto.eventType,
          'connectorId': dto.connectorId,
        },
      });
      cache['auditLog'] = log.take(5).toList();
    });
    return dto.toDomain();
  }

  @override
  Future<UserSessionInfo?> revokeSession(String sessionId) async {
    final response = await _remote.revokeSession(sessionId);
    if (response == null || response.isEmpty) {
      return null;
    }
    final dto = UserSessionDto.fromMap(Map<String, dynamic>.from(response));
    await _patchCachedOverview((cache) {
      final sessions = _readList(cache['sessions']);
      final updated = {
        'id': dto.id,
        'deviceName': dto.deviceName,
        'platform': dto.platform,
        'location': dto.location,
        'status': dto.status,
        'isCurrent': dto.isCurrent,
        'lastSeenAt': dto.lastSeenAt?.toIso8601String(),
      };
      final index =
          sessions.indexWhere((entry) => '${entry['id']}' == dto.id);
      if (index >= 0) {
        sessions[index] = updated;
      }
      cache['sessions'] = sessions;
    });
    return dto.toDomain();
  }

  Future<void> _patchCachedOverview(
    void Function(Map<String, dynamic> cache) transform,
  ) async {
    final cached = _cache.read<Map<dynamic, dynamic>>(
        CacheBox.core, CacheKeys.settingsOverview);
    if (cached == null) {
      return;
    }
    final payload = Map<String, dynamic>.from(cached as Map);
    transform(payload);
    await _cache.write(CacheBox.core, CacheKeys.settingsOverview, payload);
  }

  List<Map<String, dynamic>> _readList(dynamic raw) {
    if (raw is List) {
      return raw
          .map<Map<String, dynamic>>((item) => item is Map<String, dynamic>
              ? Map<String, dynamic>.from(item)
              : <String, dynamic>{})
          .toList();
    }
    return <Map<String, dynamic>>[];
  }
}
