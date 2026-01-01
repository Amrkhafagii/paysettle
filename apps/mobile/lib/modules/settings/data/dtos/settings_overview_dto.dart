import '../../domain/entities/settings_overview.dart';

class SettingsOverviewDto {
  SettingsOverviewDto({
    required this.profile,
    required this.subscription,
    required this.preferences,
    required this.linkedAccounts,
    required this.sessions,
    required this.connectors,
    required this.exports,
    required this.auditLog,
  });

  factory SettingsOverviewDto.fromMap(Map<String, dynamic> map) {
    final profileMap = _castMap(map['profile']);
    final subscriptionMap = _castMap(map['subscription']);
    final preferencesMap = _castMap(map['preferences']);

    return SettingsOverviewDto(
      profile: SettingsProfileDto.fromMap(profileMap),
      subscription: SubscriptionPlanDto.fromMap(subscriptionMap),
      preferences: AppPreferencesDto.fromMap(preferencesMap),
      linkedAccounts: _castList(map['linkedAccounts'])
          .map(LinkedAccountDto.fromMap)
          .toList(growable: false),
      sessions: _castList(map['sessions'])
          .map(UserSessionDto.fromMap)
          .toList(growable: false),
      connectors: _castList(map['connectors'])
          .map(AccountingConnectorDto.fromMap)
          .toList(growable: false),
      exports: _castList(map['exports'])
          .map(DataExportDto.fromMap)
          .toList(growable: false),
      auditLog: _castList(map['auditLog'])
          .map(AuditLogDto.fromMap)
          .toList(growable: false),
    );
  }

  final SettingsProfileDto profile;
  final SubscriptionPlanDto subscription;
  final AppPreferencesDto preferences;
  final List<LinkedAccountDto> linkedAccounts;
  final List<UserSessionDto> sessions;
  final List<AccountingConnectorDto> connectors;
  final List<DataExportDto> exports;
  final List<AuditLogDto> auditLog;

  SettingsOverview toDomain() => SettingsOverview(
        profile: profile.toDomain(),
        subscription: subscription.toDomain(),
        preferences: preferences.toDomain(),
        linkedAccounts: linkedAccounts.map((dto) => dto.toDomain()).toList(),
        sessions: sessions.map((dto) => dto.toDomain()).toList(),
        connectors: connectors.map((dto) => dto.toDomain()).toList(),
        exports: exports.map((dto) => dto.toDomain()).toList(),
        auditLog: auditLog.map((dto) => dto.toDomain()).toList(),
      );
}

class SettingsProfileDto {
  SettingsProfileDto({
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

  factory SettingsProfileDto.fromMap(Map<String, dynamic> map) {
    return SettingsProfileDto(
      fullName: '${map['fullName'] ?? 'PaySettle Member'}',
      email: '${map['email'] ?? ''}',
      phone: map['phone']?.toString(),
      avatarUrl: map['avatarUrl']?.toString(),
      jobTitle: map['jobTitle']?.toString(),
      country: map['country']?.toString(),
      timezone: map['timezone']?.toString(),
      orgId: map['orgId']?.toString(),
      metadata: _castMap(map['metadata']),
    );
  }

  final String fullName;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final String? jobTitle;
  final String? country;
  final String? timezone;
  final String? orgId;
  final Map<String, dynamic> metadata;

  SettingsProfile toDomain() => SettingsProfile(
        fullName: fullName,
        email: email,
        phone: phone,
        avatarUrl: avatarUrl,
        jobTitle: jobTitle,
        country: country,
        timezone: timezone,
        orgId: orgId,
        metadata: metadata,
      );
}

class SubscriptionPlanDto {
  SubscriptionPlanDto({
    this.id,
    required this.planName,
    required this.tier,
    required this.status,
    this.seats,
    this.renewsOn,
    this.expiresOn,
    this.features = const <String>[],
  });

  factory SubscriptionPlanDto.fromMap(Map<String, dynamic> map) {
    return SubscriptionPlanDto(
      id: map['planId']?.toString(),
      planName: '${map['planName'] ?? 'Starter'}',
      tier: '${map['tier'] ?? 'Free'}',
      status: '${map['status'] ?? 'trial'}',
      seats: map['seats'] == null ? null : _parseInt(map['seats']),
      renewsOn: _parseDate(map['renewsOn']),
      expiresOn: _parseDate(map['expiresOn']),
      features: _castList(map['features'])
          .map((value) => value.toString())
          .toList(growable: false),
    );
  }

  final String? id;
  final String planName;
  final String tier;
  final String status;
  final int? seats;
  final DateTime? renewsOn;
  final DateTime? expiresOn;
  final List<String> features;

  SubscriptionPlanSummary toDomain() => SubscriptionPlanSummary(
        id: id,
        planName: planName,
        tier: tier,
        status: status,
        seats: seats,
        renewsOn: renewsOn,
        expiresOn: expiresOn,
        features: features,
      );
}

class AppPreferencesDto {
  AppPreferencesDto({
    required this.currency,
    required this.theme,
    required this.notificationsEnabled,
    required this.faceIdEnabled,
    required this.exportFormat,
    required this.availableCurrencies,
    required this.featureFlags,
  });

  factory AppPreferencesDto.fromMap(Map<String, dynamic> map) {
    return AppPreferencesDto(
      currency: '${map['preferredCurrency'] ?? 'EGP'}',
      theme: themePreferenceFromString(map['darkMode']?.toString()),
      notificationsEnabled:
          map['notificationsEnabled'] is bool ? map['notificationsEnabled'] as bool : true,
      faceIdEnabled:
          map['faceIdEnabled'] is bool ? map['faceIdEnabled'] as bool : false,
      exportFormat: dataExportFormatFromString(map['autoExportFormat']?.toString()),
      availableCurrencies: _castList(map['availableCurrencies'])
          .map((value) => value.toString())
          .toList(growable: false),
      featureFlags: _castMap(map['featureFlags']),
    );
  }

  final String currency;
  final ThemePreference theme;
  final bool notificationsEnabled;
  final bool faceIdEnabled;
  final DataExportFormat exportFormat;
  final List<String> availableCurrencies;
  final Map<String, dynamic> featureFlags;

  AppPreferences toDomain() => AppPreferences(
        preferredCurrency: currency,
        darkMode: theme,
        notificationsEnabled: notificationsEnabled,
        faceIdEnabled: faceIdEnabled,
        autoExportFormat: exportFormat,
        availableCurrencies: availableCurrencies,
        featureFlags: featureFlags,
      );
}

class LinkedAccountDto {
  LinkedAccountDto({
    required this.id,
    required this.provider,
    required this.accountName,
    required this.status,
    this.lastSyncedAt,
    this.metadata = const <String, dynamic>{},
  });

  factory LinkedAccountDto.fromMap(Map<String, dynamic> map) {
    return LinkedAccountDto(
      id: '${map['id'] ?? ''}',
      provider: '${map['provider'] ?? 'unknown'}',
      accountName: '${map['accountName'] ?? 'Account'}',
      status: '${map['status'] ?? 'connected'}',
      lastSyncedAt: _parseDate(map['lastSyncedAt']),
      metadata: _castMap(map['metadata']),
    );
  }

  final String id;
  final String provider;
  final String accountName;
  final String status;
  final DateTime? lastSyncedAt;
  final Map<String, dynamic> metadata;

  LinkedAccountSummary toDomain() => LinkedAccountSummary(
        id: id,
        provider: provider,
        accountName: accountName,
        status: status,
        lastSyncedAt: lastSyncedAt,
        metadata: metadata,
      );
}

class UserSessionDto {
  UserSessionDto({
    required this.id,
    required this.deviceName,
    required this.status,
    required this.isCurrent,
    this.platform,
    this.location,
    this.lastSeenAt,
  });

  factory UserSessionDto.fromMap(Map<String, dynamic> map) {
    return UserSessionDto(
      id: '${map['id'] ?? ''}',
      deviceName: '${map['deviceName'] ?? 'Device'}',
      platform: map['platform']?.toString(),
      location: map['location']?.toString(),
      status: '${map['status'] ?? 'active'}',
      isCurrent: map['isCurrent'] is bool ? map['isCurrent'] as bool : false,
      lastSeenAt: _parseDate(map['lastSeenAt']),
    );
  }

  final String id;
  final String deviceName;
  final String? platform;
  final String? location;
  final String status;
  final bool isCurrent;
  final DateTime? lastSeenAt;

  UserSessionInfo toDomain() => UserSessionInfo(
        id: id,
        deviceName: deviceName,
        platform: platform,
        location: location,
        status: status,
        isCurrent: isCurrent,
        lastSeenAt: lastSeenAt,
      );
}

class DataExportDto {
  DataExportDto({
    required this.id,
    required this.type,
    required this.format,
    required this.status,
    this.requestedAt,
    this.completedAt,
    this.downloadUrl,
  });

  factory DataExportDto.fromMap(Map<String, dynamic> map) {
    return DataExportDto(
      id: '${map['id'] ?? ''}',
      type: dataExportTypeFromString(map['type']?.toString()),
      format: dataExportFormatFromString(map['format']?.toString()),
      status: '${map['status'] ?? 'queued'}',
      requestedAt: _parseDate(map['requestedAt']),
      completedAt: _parseDate(map['completedAt']),
      downloadUrl: map['downloadUrl']?.toString(),
    );
  }

  final String id;
  final DataExportType type;
  final DataExportFormat format;
  final String status;
  final DateTime? requestedAt;
  final DateTime? completedAt;
  final String? downloadUrl;

  DataExportJob toDomain() => DataExportJob(
        id: id,
        type: type,
        format: format,
        status: status,
        requestedAt: requestedAt,
        completedAt: completedAt,
        downloadUrl: downloadUrl,
      );
}

class AccountingConnectorDto {
  AccountingConnectorDto({
    required this.id,
    required this.provider,
    required this.status,
    this.lastSyncAt,
    this.webhookUrl,
    this.metadata = const <String, dynamic>{},
  });

  factory AccountingConnectorDto.fromMap(Map<String, dynamic> map) {
    return AccountingConnectorDto(
      id: '${map['id'] ?? ''}',
      provider: '${map['provider'] ?? 'connector'}',
      status: '${map['status'] ?? 'disconnected'}',
      lastSyncAt: _parseDate(map['lastSyncAt']),
      webhookUrl: map['webhookUrl']?.toString(),
      metadata: _castMap(map['metadata']),
    );
  }

  final String id;
  final String provider;
  final String status;
  final DateTime? lastSyncAt;
  final String? webhookUrl;
  final Map<String, dynamic> metadata;

  AccountingConnector toDomain() => AccountingConnector(
        id: id,
        provider: provider,
        status: status,
        lastSyncAt: lastSyncAt,
        webhookUrl: webhookUrl,
        metadata: metadata,
      );
}

class AccountingConnectorEventDto {
  AccountingConnectorEventDto({
    required this.id,
    required this.connectorId,
    required this.eventType,
    required this.status,
    this.createdAt,
  });

  factory AccountingConnectorEventDto.fromMap(Map<String, dynamic> map) {
    return AccountingConnectorEventDto(
      id: '${map['id'] ?? ''}',
      connectorId: '${map['connector_id'] ?? map['connectorId'] ?? ''}',
      eventType: '${map['event_type'] ?? map['eventType'] ?? 'sync'}',
      status: '${map['status'] ?? 'queued'}',
      createdAt: _parseDate(map['created_at'] ?? map['createdAt']),
    );
  }

  final String id;
  final String connectorId;
  final String eventType;
  final String status;
  final DateTime? createdAt;

  AccountingConnectorEvent toDomain() => AccountingConnectorEvent(
        id: id,
        connectorId: connectorId,
        eventType: eventType,
        status: status,
        createdAt: createdAt,
      );
}

class AuditLogDto {
  AuditLogDto({
    required this.id,
    required this.action,
    required this.severity,
    this.targetType,
    this.createdAt,
    this.payload = const <String, dynamic>{},
  });

  factory AuditLogDto.fromMap(Map<String, dynamic> map) {
    return AuditLogDto(
      id: '${map['id'] ?? ''}',
      action: '${map['action'] ?? ''}',
      severity: '${map['severity'] ?? 'info'}',
      targetType: map['targetType']?.toString(),
      createdAt: _parseDate(map['createdAt']),
      payload: _castMap(map['payload']),
    );
  }

  final String id;
  final String action;
  final String severity;
  final String? targetType;
  final DateTime? createdAt;
  final Map<String, dynamic> payload;

  AuditLogEntry toDomain() => AuditLogEntry(
        id: id,
        action: action,
        targetType: targetType,
        severity: severity,
        createdAt: createdAt,
        payload: payload,
      );
}

Map<String, dynamic> _castMap(dynamic raw) {
  if (raw is Map<String, dynamic>) {
    return raw;
  }
  if (raw is Map) {
    return raw.map((key, value) => MapEntry(key.toString(), value));
  }
  return <String, dynamic>{};
}

List<Map<String, dynamic>> _castList(dynamic raw) {
  if (raw is List) {
    return raw
        .where((element) => element != null)
        .map((item) => _castMap(item))
        .toList(growable: false);
  }
  return const [];
}

int? _parseInt(dynamic value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}

DateTime? _parseDate(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  final raw = value.toString();
  if (raw.isEmpty) {
    return null;
  }
  return DateTime.tryParse(raw);
}
