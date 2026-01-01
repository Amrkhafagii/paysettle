import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/theme/theme_provider.dart';
import '../../domain/entities/settings_overview.dart';
import '../../domain/usecases/connect_accounting_provider.dart';
import '../../domain/usecases/get_settings_overview.dart';
import '../../domain/usecases/request_data_export.dart';
import '../../domain/usecases/revoke_session.dart';
import '../../domain/usecases/trigger_connector_sync.dart';
import '../../domain/usecases/update_settings_preferences.dart';
import '../../domain/usecases/update_settings_profile.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../../domain/value_objects/data_export_request.dart';
import '../../domain/value_objects/preferences_update.dart';
import '../../domain/value_objects/update_profile_request.dart';
import '../state/settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController({
    required GetSettingsOverviewUseCase getSettingsOverview,
    required UpdateSettingsProfileUseCase updateProfile,
    required UpdateSettingsPreferencesUseCase updatePreferences,
    required RequestDataExportUseCase requestDataExport,
    required ConnectAccountingProviderUseCase connectAccountingProvider,
    required TriggerConnectorSyncUseCase triggerConnectorSync,
    required RevokeSessionUseCase revokeSession,
    required Ref ref,
  })  : _getSettingsOverview = getSettingsOverview,
        _updateProfile = updateProfile,
        _updatePreferences = updatePreferences,
        _requestDataExport = requestDataExport,
        _connectAccountingProvider = connectAccountingProvider,
        _triggerConnectorSync = triggerConnectorSync,
        _revokeSession = revokeSession,
        _ref = ref,
        super(SettingsState.initial()) {
    load();
  }

  final GetSettingsOverviewUseCase _getSettingsOverview;
  final UpdateSettingsProfileUseCase _updateProfile;
  final UpdateSettingsPreferencesUseCase _updatePreferences;
  final RequestDataExportUseCase _requestDataExport;
  final ConnectAccountingProviderUseCase _connectAccountingProvider;
  final TriggerConnectorSyncUseCase _triggerConnectorSync;
  final RevokeSessionUseCase _revokeSession;
  final Ref _ref;

  Future<void> load() async {
    state = state.copyWith(overview: const AsyncValue.loading());
    final overview = await AsyncValue.guard(() => _getSettingsOverview());
    state = state.copyWith(overview: overview);
    overview.whenData(_applyThemePreference);
  }

  Future<void> refresh() => load();

  Future<SettingsProfile> saveProfile(UpdateProfileRequest request) async {
    state = state.copyWith(isUpdatingProfile: true);
    try {
      final profile = await _updateProfile(request);
      state = state.copyWith(
        overview: state.overview.whenData(
          (current) => current.copyWith(profile: profile),
        ),
        isUpdatingProfile: false,
      );
      return profile;
    } catch (error) {
      state = state.copyWith(isUpdatingProfile: false);
      rethrow;
    }
  }

  Future<AppPreferences> savePreferences(PreferencesUpdate update) async {
    if (update.isEmpty) {
      return state.overview.value?.preferences ??
          const AppPreferences(
            preferredCurrency: 'EGP',
            darkMode: ThemePreference.system,
            notificationsEnabled: true,
            faceIdEnabled: false,
            autoExportFormat: DataExportFormat.pdf,
          );
    }
    state = state.copyWith(isUpdatingPreferences: true);
    try {
      final preferences = await _updatePreferences(update);
      state = state.copyWith(
        overview: state.overview.whenData(
          (current) => current.copyWith(preferences: preferences),
        ),
        isUpdatingPreferences: false,
      );
      final current = state.overview.value;
      if (current != null) {
        _applyThemePreference(current.copyWith(preferences: preferences));
      }
      return preferences;
    } catch (error) {
      state = state.copyWith(isUpdatingPreferences: false);
      rethrow;
    }
  }

  Future<DataExportJob> requestExport(
      DataExportType type, DataExportFormat format) async {
    state = state.copyWith(isRequestingExport: true);
    try {
      final job = await _requestDataExport(
        DataExportRequest(type: type, format: format),
      );
      state = state.copyWith(
        overview: state.overview.whenData(
          (current) => current.copyWith(
            exports: [job, ...current.exports].take(5).toList(),
          ),
        ),
        isRequestingExport: false,
      );
      return job;
    } catch (error) {
      state = state.copyWith(isRequestingExport: false);
      rethrow;
    }
  }

  Future<AccountingConnector> connectAccounting(String provider) async {
    state = state.copyWith(isConnecting: true);
    try {
      final connector = await _connectAccountingProvider(provider);
      state = state.copyWith(
        overview: state.overview.whenData(
          (current) {
            final connectors = [...current.connectors];
            final index =
                connectors.indexWhere((entry) => entry.id == connector.id);
            if (index >= 0) {
              connectors[index] = connector;
            } else {
              connectors.insert(0, connector);
            }
            return current.copyWith(connectors: connectors);
          },
        ),
        isConnecting: false,
      );
      return connector;
    } catch (error) {
      state = state.copyWith(isConnecting: false);
      rethrow;
    }
  }

  Future<AccountingConnectorEvent> triggerConnectorSync(String connectorId,
      {String eventType = 'sync'}) async {
    final syncing = {...state.syncingConnectors, connectorId};
    state = state.copyWith(syncingConnectors: syncing);
    try {
      final event = await _triggerConnectorSync(
        connectorId: connectorId,
        eventType: eventType,
      );
      final remaining = {...state.syncingConnectors}..remove(connectorId);
      state = state.copyWith(
        overview: state.overview.whenData(
          (current) => current.copyWith(
            auditLog: [
              AuditLogEntry(
                id: event.id,
                action: 'connector_event',
                targetType: 'accounting_connector_events',
                severity: 'debug',
                createdAt: event.createdAt,
                payload: {
                  'event': event.eventType,
                  'connectorId': event.connectorId,
                },
              ),
              ...current.auditLog,
            ].take(5).toList(),
          ),
        ),
        syncingConnectors: remaining,
      );
      return event;
    } catch (error) {
      final updated = {...state.syncingConnectors}..remove(connectorId);
      state = state.copyWith(syncingConnectors: updated);
      rethrow;
    }
  }

  Future<UserSessionInfo?> revokeSession(String sessionId) async {
    final revoking = {...state.revokingSessions, sessionId};
    state = state.copyWith(revokingSessions: revoking);
    try {
      final session = await _revokeSession(sessionId);
      if (session != null) {
        state = state.copyWith(
          overview: state.overview.whenData(
            (current) {
              final sessions = current.sessions.map((entry) {
                if (entry.id == session.id) {
                  return session;
                }
                return entry;
              }).toList();
              return current.copyWith(sessions: sessions);
            },
          ),
        );
      }
      final remaining = {...state.revokingSessions}..remove(sessionId);
      state = state.copyWith(revokingSessions: remaining);
      return session;
    } catch (error) {
      final updated = {...state.revokingSessions}..remove(sessionId);
      state = state.copyWith(revokingSessions: updated);
      rethrow;
    }
  }

  void _applyThemePreference(SettingsOverview overview) {
    final mode = _mapThemePreference(overview.preferences.darkMode);
    _ref.read(themeModeProvider.notifier).state = mode;
  }

  ThemeMode _mapThemePreference(ThemePreference preference) {
    switch (preference) {
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
        return ThemeMode.dark;
      case ThemePreference.system:
      default:
        return ThemeMode.system;
    }
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(
    getSettingsOverview: ref.watch(getSettingsOverviewUseCaseProvider),
    updateProfile: ref.watch(updateSettingsProfileUseCaseProvider),
    updatePreferences: ref.watch(updateSettingsPreferencesUseCaseProvider),
    requestDataExport: ref.watch(requestDataExportUseCaseProvider),
    connectAccountingProvider:
        ref.watch(connectAccountingProviderUseCaseProvider),
    triggerConnectorSync: ref.watch(triggerConnectorSyncUseCaseProvider),
    revokeSession: ref.watch(revokeSessionUseCaseProvider),
    ref: ref,
  );
});
