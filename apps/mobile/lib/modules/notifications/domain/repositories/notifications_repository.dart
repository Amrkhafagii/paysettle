import '../entities/app_notification.dart';

abstract class NotificationsRepository {
  Future<NotificationFeed> fetchFeed();
  Future<void> markAsRead(String notificationId);
  Future<void> registerDevice({
    required String token,
    String? platform,
    Map<String, dynamic>? metadata,
  });
}
