import '../repositories/notifications_repository.dart';

class RegisterNotificationDeviceUseCase {
  RegisterNotificationDeviceUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<void> call({
    required String token,
    String? platform,
    Map<String, dynamic>? metadata,
  }) {
    return _repository.registerDevice(
      token: token,
      platform: platform,
      metadata: metadata,
    );
  }
}
