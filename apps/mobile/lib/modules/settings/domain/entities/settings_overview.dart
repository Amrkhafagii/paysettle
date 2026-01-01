enum ThemePreference { system, light, dark }

ThemePreference themePreferenceFromString(String? raw) {
  switch (raw?.toLowerCase()) {
    case 'light':
      return ThemePreference.light;
    case 'dark':
      return ThemePreference.dark;
    case 'system':
    default:
      return ThemePreference.system;
  }
}

extension ThemePreferenceApi on ThemePreference {
  String get apiValue {
    switch (this) {
      case ThemePreference.system:
        return 'system';
      case ThemePreference.light:
        return 'light';
      case ThemePreference.dark:
        return 'dark';
    }
  }
}

enum DataExportFormat { csv, pdf }

DataExportFormat dataExportFormatFromString(String? raw) {
  switch (raw?.toLowerCase()) {
    case 'csv':
      return DataExportFormat.csv;
    case 'pdf':
    default:
      return DataExportFormat.pdf;
  }
}

extension DataExportFormatX on DataExportFormat {
  String get label => this == DataExportFormat.csv ? 'CSV' : 'PDF';
  String get apiValue => this == DataExportFormat.csv ? 'csv' : 'pdf';
}

enum DataExportType { wallet, journeys, budgets, full, custom }

DataExportType dataExportTypeFromString(String? raw) {
  switch (raw?.toLowerCase()) {
    case 'wallet':
      return DataExportType.wallet;
    case 'journeys':
      return DataExportType.journeys;
    case 'budgets':
      return DataExportType.budgets;
    case 'custom':
      return DataExportType.custom;
    case 'full':
    default:
      return DataExportType.full;
  }
}

extension DataExportTypeX on DataExportType {
  String get label {
    switch (this) {
      case DataExportType.wallet:
        return 'Wallet';
      case DataExportType.journeys:
        return 'Journeys';
      case DataExportType.budgets:
        return 'Budgets';
      case DataExportType.full:
        return 'Full Backup';
      case DataExportType.custom:
        return 'Custom';
    }
  }

  String get apiValue => name;
}

class SettingsProfile {
  const SettingsProfile({
    required this.fullName,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.jobTitle,
    this.country,
    this.timezone,
    this.orgId,
    this.metadata = const <String, dynamic>{},
  });

  final String fullName;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final String? jobTitle;
  final String? country;
  final String? timezone;
  final String? orgId;
  final Map<String, dynamic> metadata;

  SettingsProfile copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? jobTitle,
    String? country,
    String? timezone,
    String? orgId,
    Map<String, dynamic>? metadata,
  }) {
    return SettingsProfile(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      jobTitle: jobTitle ?? this.jobTitle,
      country: country ?? this.country,
      timezone: timezone ?? this.timezone,
      orgId: orgId ?? this.orgId,
      metadata: metadata ?? this.metadata,
    );
  }
}

class SubscriptionPlanSummary {
  const SubscriptionPlanSummary({
    this.id,
    required this.planName,
    required this.tier,
    required this.status,
    this.seats,
    this.renewsOn,
    this.expiresOn,
    this.features = const <String>[],
  });

  final String? id;
  final String planName;
  final String tier;
  final String status;
  final int? seats;
  final DateTime? renewsOn;
  final DateTime? expiresOn;
  final List<String> features;
}

class LinkedAccountSummary {
  const LinkedAccountSummary({
    required this.id,
    required this.provider,
    required this.accountName,
    required this.status,
    this.lastSyncedAt,
    this.metadata = const <String, dynamic>{},
  });

  final String id;
  final String provider;
  final String accountName;
  final String status;
  final DateTime? lastSyncedAt;
  final Map<String, dynamic> metadata;
}

class AppPreferences {
  const AppPreferences({
    required this.preferredCurrency,
    required this.darkMode,
    required this.notificationsEnabled,
    required this.faceIdEnabled,
    required this.autoExportFormat,
    this.availableCurrencies = const <String>[],
    this.featureFlags = const <String, dynamic>{},
  });

  final String preferredCurrency;
  final ThemePreference darkMode;
  final bool notificationsEnabled;
  final bool faceIdEnabled;
  final DataExportFormat autoExportFormat;
  final List<String> availableCurrencies;
  final Map<String, dynamic> featureFlags;

  AppPreferences copyWith({
    String? preferredCurrency,
    ThemePreference? darkMode,
    bool? notificationsEnabled,
    bool? faceIdEnabled,
    DataExportFormat? autoExportFormat,
    List<String>? availableCurrencies,
    Map<String, dynamic>? featureFlags,
  }) {
    return AppPreferences(
      preferredCurrency: preferredCurrency ?? this.preferredCurrency,
      darkMode: darkMode ?? this.darkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      faceIdEnabled: faceIdEnabled ?? this.faceIdEnabled,
      autoExportFormat: autoExportFormat ?? this.autoExportFormat,
      availableCurrencies: availableCurrencies ?? this.availableCurrencies,
      featureFlags: featureFlags ?? this.featureFlags,
    );
  }
}

class UserSessionInfo {
  const UserSessionInfo({
    required this.id,
    required this.deviceName,
    required this.status,
    required this.isCurrent,
    this.platform,
    this.location,
    this.lastSeenAt,
  });

  final String id;
  final String deviceName;
  final String status;
  final bool isCurrent;
  final String? platform;
  final String? location;
  final DateTime? lastSeenAt;

  UserSessionInfo copyWith({
    String? status,
    bool? isCurrent,
  }) {
    return UserSessionInfo(
      id: id,
      deviceName: deviceName,
      status: status ?? this.status,
      isCurrent: isCurrent ?? this.isCurrent,
      platform: platform,
      location: location,
      lastSeenAt: lastSeenAt,
    );
  }
}

class DataExportJob {
  const DataExportJob({
    required this.id,
    required this.type,
    required this.format,
    required this.status,
    this.requestedAt,
    this.completedAt,
    this.downloadUrl,
  });

  final String id;
  final DataExportType type;
  final DataExportFormat format;
  final String status;
  final DateTime? requestedAt;
  final DateTime? completedAt;
  final String? downloadUrl;
}

class AccountingConnector {
  const AccountingConnector({
    required this.id,
    required this.provider,
    required this.status,
    this.lastSyncAt,
    this.webhookUrl,
    this.metadata = const <String, dynamic>{},
  });

  final String id;
  final String provider;
  final String status;
  final DateTime? lastSyncAt;
  final String? webhookUrl;
  final Map<String, dynamic> metadata;
}

class AccountingConnectorEvent {
  const AccountingConnectorEvent({
    required this.id,
    required this.connectorId,
    required this.eventType,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String connectorId;
  final String eventType;
  final String status;
  final DateTime? createdAt;
}

class AuditLogEntry {
  const AuditLogEntry({
    required this.id,
    required this.action,
    required this.severity,
    this.targetType,
    this.createdAt,
    this.payload = const <String, dynamic>{},
  });

  final String id;
  final String action;
  final String severity;
  final String? targetType;
  final DateTime? createdAt;
  final Map<String, dynamic> payload;
}

class SettingsOverview {
  const SettingsOverview({
    required this.profile,
    required this.subscription,
    required this.preferences,
    this.linkedAccounts = const <LinkedAccountSummary>[],
    this.sessions = const <UserSessionInfo>[],
    this.connectors = const <AccountingConnector>[],
    this.exports = const <DataExportJob>[],
    this.auditLog = const <AuditLogEntry>[],
  });

  final SettingsProfile profile;
  final SubscriptionPlanSummary subscription;
  final AppPreferences preferences;
  final List<LinkedAccountSummary> linkedAccounts;
  final List<UserSessionInfo> sessions;
  final List<AccountingConnector> connectors;
  final List<DataExportJob> exports;
  final List<AuditLogEntry> auditLog;

  SettingsOverview copyWith({
    SettingsProfile? profile,
    SubscriptionPlanSummary? subscription,
    AppPreferences? preferences,
    List<LinkedAccountSummary>? linkedAccounts,
    List<UserSessionInfo>? sessions,
    List<AccountingConnector>? connectors,
    List<DataExportJob>? exports,
    List<AuditLogEntry>? auditLog,
  }) {
    return SettingsOverview(
      profile: profile ?? this.profile,
      subscription: subscription ?? this.subscription,
      preferences: preferences ?? this.preferences,
      linkedAccounts: linkedAccounts ?? this.linkedAccounts,
      sessions: sessions ?? this.sessions,
      connectors: connectors ?? this.connectors,
      exports: exports ?? this.exports,
      auditLog: auditLog ?? this.auditLog,
    );
  }
}
