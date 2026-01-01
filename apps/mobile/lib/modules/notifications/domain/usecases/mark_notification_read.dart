import '../repositories/notifications_repository.dart';

class MarkNotificationReadUseCase {
  MarkNotificationReadUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<void> call(String notificationId) {
    return _repository.markAsRead(notificationId);
  }
}
