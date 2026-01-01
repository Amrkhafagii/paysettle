import '../../../../src/core/utils/parsing.dart';
import '../../domain/entities/app_notification.dart';

class NotificationDto {
  NotificationDto({
    required this.id,
    required this.type,
    required this.severity,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.readAt,
    required this.topic,
    required this.actionLabel,
    required this.actionUrl,
    required this.metadata,
    required this.payload,
  });

  factory NotificationDto.fromMap(Map<String, dynamic> map) {
    return NotificationDto(
      id: '${map['id']}',
      type: _parseType(map['type'] ?? map['notification_type']),
      severity: _parseSeverity(map['severity']),
      title: '${map['title'] ?? ''}',
      body: '${map['body'] ?? ''}',
      createdAt: parseDateTime(map['createdAt'] ?? map['created_at']) ??
          DateTime.now(),
      readAt: parseDateTime(map['readAt'] ?? map['read_at']),
      topic: map['topic']?.toString(),
      actionLabel: map['actionLabel']?.toString(),
      actionUrl: map['actionUrl']?.toString(),
      metadata: _coerceMap(map['metadata']),
      payload: _coerceMap(map['ctaPayload']),
    );
  }

  final String id;
  final AppNotificationType type;
  final NotificationSeverity severity;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime? readAt;
  final String? topic;
  final String? actionLabel;
  final String? actionUrl;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? payload;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'severity': severity.name,
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'topic': topic,
      'actionLabel': actionLabel,
      'actionUrl': actionUrl,
      'metadata': metadata,
      'ctaPayload': payload,
    };
  }

  AppNotification toDomain() {
    return AppNotification(
      id: id,
      type: type,
      severity: severity,
      title: title,
      body: body,
      createdAt: createdAt,
      readAt: readAt,
      topic: topic,
      actionLabel: actionLabel,
      actionUrl: actionUrl,
      metadata: metadata,
      payload: payload,
    );
  }

  static AppNotificationType _parseType(Object? raw) {
    final value = raw?.toString().toLowerCase();
    return AppNotificationType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => AppNotificationType.system,
    );
  }

  static NotificationSeverity _parseSeverity(Object? raw) {
    final value = raw?.toString().toLowerCase();
    return NotificationSeverity.values.firstWhere(
      (severity) => severity.name == value,
      orElse: () => NotificationSeverity.info,
    );
  }

  static Map<String, dynamic>? _coerceMap(Object? raw) {
    if (raw is Map<String, dynamic>) {
      return raw;
    }
    if (raw is Map) {
      return normalizeMap(raw);
    }
    return null;
  }
}
