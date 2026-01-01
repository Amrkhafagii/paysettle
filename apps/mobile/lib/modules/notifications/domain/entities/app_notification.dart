import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

enum AppNotificationType { budget, payment, reminder, insight, system }

enum NotificationSeverity { info, success, warning, critical }

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required AppNotificationType type,
    required NotificationSeverity severity,
    required String title,
    required String body,
    required DateTime createdAt,
    DateTime? readAt,
    String? topic,
    String? actionLabel,
    String? actionUrl,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? payload,
  }) = _AppNotification;
}

@freezed
class NotificationFeed with _$NotificationFeed {
  const factory NotificationFeed({
    required List<AppNotification> newItems,
    required List<AppNotification> earlierItems,
  }) = _NotificationFeed;

  const NotificationFeed._();

  List<AppNotification> get all => [...newItems, ...earlierItems];
}
