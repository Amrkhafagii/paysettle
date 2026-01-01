import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationFeedUseCase {
  GetNotificationFeedUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<NotificationFeed> call() {
    return _repository.fetchFeed();
  }
}
