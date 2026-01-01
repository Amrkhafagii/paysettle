import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_keys.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';
import '../dtos/notification_dto.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl({
    required NotificationsRemoteDataSource remoteDataSource,
    required CacheService cacheService,
  })  : _remoteDataSource = remoteDataSource,
        _cacheService = cacheService;

  final NotificationsRemoteDataSource _remoteDataSource;
  final CacheService _cacheService;

  @override
  Future<NotificationFeed> fetchFeed() async {
    try {
      final response = await _remoteDataSource.fetchFeed();
      final feed = _mapFeed(response);
      await _cacheService.write(CacheBox.core, CacheKeys.notificationsFeed, {
        'new': feed.newItems
            .map((item) => NotificationDto(
                  id: item.id,
                  type: item.type,
                  severity: item.severity,
                  title: item.title,
                  body: item.body,
                  createdAt: item.createdAt,
                  readAt: item.readAt,
                  topic: item.topic,
                  actionLabel: item.actionLabel,
                  actionUrl: item.actionUrl,
                  metadata: item.metadata,
                  payload: item.payload,
                ).toJson())
            .toList(growable: false),
        'earlier': feed.earlierItems
            .map((item) => NotificationDto(
                  id: item.id,
                  type: item.type,
                  severity: item.severity,
                  title: item.title,
                  body: item.body,
                  createdAt: item.createdAt,
                  readAt: item.readAt,
                  topic: item.topic,
                  actionLabel: item.actionLabel,
                  actionUrl: item.actionUrl,
                  metadata: item.metadata,
                  payload: item.payload,
                ).toJson())
            .toList(growable: false),
      });
      return feed;
    } catch (_) {
      final cached = _cacheService.read<Map<dynamic, dynamic>>(
          CacheBox.core, CacheKeys.notificationsFeed);
      if (cached == null) {
        rethrow;
      }
      final normalized = cached.map<String, dynamic>(
          (key, value) => MapEntry(key.toString(), value));
      return _mapFeed(normalized);
    }
  }

  @override
  Future<void> markAsRead(String notificationId) {
    return _remoteDataSource.markAsRead(notificationId);
  }

  @override
  Future<void> registerDevice({
    required String token,
    String? platform,
    Map<String, dynamic>? metadata,
  }) {
    return _remoteDataSource.registerDevice(
      token: token,
      platform: platform,
      metadata: metadata,
    );
  }

  NotificationFeed _mapFeed(Map<String, dynamic> payload) {
    final newItems = (payload['new'] as List? ?? const [])
        .whereType<Map>()
        .map((entry) => NotificationDto.fromMap(entry.cast<String, dynamic>()))
        .map((dto) => dto.toDomain())
        .toList(growable: false);
    final earlierItems = (payload['earlier'] as List? ?? const [])
        .whereType<Map>()
        .map((entry) => NotificationDto.fromMap(entry.cast<String, dynamic>()))
        .map((dto) => dto.toDomain())
        .toList(growable: false);
    return NotificationFeed(newItems: newItems, earlierItems: earlierItems);
  }
}
