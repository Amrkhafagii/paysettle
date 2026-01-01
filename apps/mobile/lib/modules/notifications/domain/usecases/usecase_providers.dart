import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_service.dart';
import '../../data/datasources/notifications_remote_data_source.dart';
import '../../data/repositories/notifications_repository_impl.dart';
import '../repositories/notifications_repository.dart';
import 'get_notification_feed.dart';
import 'mark_notification_read.dart';
import 'register_notification_device.dart';

final notificationsRepositoryProvider =
    Provider<NotificationsRepository>((ref) {
  return NotificationsRepositoryImpl(
    remoteDataSource: ref.watch(notificationsRemoteDataSourceProvider),
    cacheService: ref.watch(cacheServiceProvider),
  );
});

final getNotificationFeedUseCaseProvider =
    Provider<GetNotificationFeedUseCase>((ref) {
  return GetNotificationFeedUseCase(ref.watch(notificationsRepositoryProvider));
});

final markNotificationReadUseCaseProvider =
    Provider<MarkNotificationReadUseCase>((ref) {
  return MarkNotificationReadUseCase(
      ref.watch(notificationsRepositoryProvider));
});

final registerNotificationDeviceUseCaseProvider =
    Provider<RegisterNotificationDeviceUseCase>((ref) {
  return RegisterNotificationDeviceUseCase(
    ref.watch(notificationsRepositoryProvider),
  );
});
