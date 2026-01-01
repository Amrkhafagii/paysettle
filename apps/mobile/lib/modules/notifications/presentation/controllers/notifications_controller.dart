import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/notifications_realtime_service.dart';
import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/get_notification_feed.dart';
import '../../domain/usecases/mark_notification_read.dart';
import '../../domain/usecases/register_notification_device.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../state/notification_state.dart';

class NotificationsController extends StateNotifier<NotificationState> {
  NotificationsController({
    required GetNotificationFeedUseCase getFeed,
    required MarkNotificationReadUseCase markRead,
    required RegisterNotificationDeviceUseCase registerDevice,
    required NotificationsRealtimeService realtimeService,
  })  : _getFeed = getFeed,
        _markRead = markRead,
        _registerDevice = registerDevice,
        _realtimeService = realtimeService,
        super(NotificationState.initial()) {
    load();
    _connectRealtime();
    _registerRealtimeDevice();
  }

  final GetNotificationFeedUseCase _getFeed;
  final MarkNotificationReadUseCase _markRead;
  final RegisterNotificationDeviceUseCase _registerDevice;
  final NotificationsRealtimeService _realtimeService;

  StreamSubscription<AppNotification>? _subscription;

  Future<void> load() async {
    state = state.copyWith(feed: const AsyncValue.loading());
    final result = await AsyncValue.guard(_getFeed);
    state = state.copyWith(feed: result);
  }

  Future<void> refresh() => load();

  Future<void> markAsRead(String id) async {
    await _markRead(id);
    final current = state.feed.valueOrNull;
    if (current == null) {
      return;
    }
    final now = DateTime.now();
    state = state.copyWith(
      feed: AsyncValue.data(
        NotificationFeed(
          newItems: current.newItems
              .map((item) => item.id == id ? item.copyWith(readAt: now) : item)
              .toList(),
          earlierItems: current.earlierItems
              .map((item) => item.id == id ? item.copyWith(readAt: now) : item)
              .toList(),
        ),
      ),
    );
  }

  void _connectRealtime() {
    _subscription = _realtimeService.stream().listen((notification) {
      final current = state.feed.valueOrNull ??
          const NotificationFeed(newItems: [], earlierItems: []);
      final updated = NotificationFeed(
        newItems: [notification, ...current.newItems],
        earlierItems: current.earlierItems,
      );
      state = state.copyWith(
        feed: AsyncValue.data(updated),
        isRealtimeConnected: true,
      );
    });
  }

  Future<void> _registerRealtimeDevice() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      return;
    }
    await _registerDevice(
      token: 'realtime-$userId',
      platform: 'supabase_realtime',
      metadata: const {'channel': 'realtime'},
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, NotificationState>((ref) {
  return NotificationsController(
    getFeed: ref.watch(getNotificationFeedUseCaseProvider),
    markRead: ref.watch(markNotificationReadUseCaseProvider),
    registerDevice: ref.watch(registerNotificationDeviceUseCaseProvider),
    realtimeService: ref.watch(notificationsRealtimeServiceProvider),
  );
});
