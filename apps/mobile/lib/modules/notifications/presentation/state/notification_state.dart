import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_notification.dart';

class NotificationState {
  const NotificationState({
    required this.feed,
    required this.isRealtimeConnected,
  });

  factory NotificationState.initial() => NotificationState(
      feed: const AsyncValue.loading(), isRealtimeConnected: false);

  final AsyncValue<NotificationFeed> feed;
  final bool isRealtimeConnected;

  NotificationState copyWith({
    AsyncValue<NotificationFeed>? feed,
    bool? isRealtimeConnected,
  }) {
    return NotificationState(
      feed: feed ?? this.feed,
      isRealtimeConnected: isRealtimeConnected ?? this.isRealtimeConnected,
    );
  }
}
