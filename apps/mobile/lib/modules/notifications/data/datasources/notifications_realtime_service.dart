import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../../domain/entities/app_notification.dart';
import '../dtos/notification_dto.dart';

class NotificationsRealtimeService {
  NotificationsRealtimeService(this._client);

  final SupabaseClient _client;
  final _controller = StreamController<AppNotification>.broadcast();
  RealtimeChannel? _channel;

  Stream<AppNotification> stream() {
    _channel ??= _client
        .channel('public:notifications')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'notifications',
          callback: (payload) {
            final record = payload.newRecord;
            if (record == null) {
              return;
            }
            final dto =
                NotificationDto.fromMap(Map<String, dynamic>.from(record));
            _controller.add(dto.toDomain());
          },
        )
        .subscribe();
    return _controller.stream;
  }

  Future<void> dispose() async {
    await _channel?.unsubscribe();
    await _controller.close();
  }
}

final notificationsRealtimeServiceProvider =
    Provider<NotificationsRealtimeService>((ref) {
  final service =
      NotificationsRealtimeService(ref.watch(supabaseClientProvider));
  ref.onDispose(service.dispose);
  return service;
});
