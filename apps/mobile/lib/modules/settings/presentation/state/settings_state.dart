import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/settings_overview.dart';

class SettingsState {
  const SettingsState({
    required this.overview,
    this.isUpdatingProfile = false,
    this.isUpdatingPreferences = false,
    this.isRequestingExport = false,
    this.isConnecting = false,
    this.revokingSessions = const <String>{},
    this.syncingConnectors = const <String>{},
  });

  factory SettingsState.initial() => const SettingsState(
        overview: AsyncValue.loading(),
      );

  final AsyncValue<SettingsOverview> overview;
  final bool isUpdatingProfile;
  final bool isUpdatingPreferences;
  final bool isRequestingExport;
  final bool isConnecting;
  final Set<String> revokingSessions;
  final Set<String> syncingConnectors;

  SettingsState copyWith({
    AsyncValue<SettingsOverview>? overview,
    bool? isUpdatingProfile,
    bool? isUpdatingPreferences,
    bool? isRequestingExport,
    bool? isConnecting,
    Set<String>? revokingSessions,
    Set<String>? syncingConnectors,
  }) {
    return SettingsState(
      overview: overview ?? this.overview,
      isUpdatingProfile: isUpdatingProfile ?? this.isUpdatingProfile,
      isUpdatingPreferences:
          isUpdatingPreferences ?? this.isUpdatingPreferences,
      isRequestingExport: isRequestingExport ?? this.isRequestingExport,
      isConnecting: isConnecting ?? this.isConnecting,
      revokingSessions: revokingSessions ?? this.revokingSessions,
      syncingConnectors: syncingConnectors ?? this.syncingConnectors,
    );
  }
}
