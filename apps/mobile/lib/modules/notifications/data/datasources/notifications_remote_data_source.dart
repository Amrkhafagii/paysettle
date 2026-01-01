import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';

class NotificationsRemoteDataSource {
  NotificationsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<Map<String, dynamic>> fetchFeed() async {
    try {
      final response =
          await _client.rpc<Map<String, dynamic>>('notification_feed');
      return response;
    } on PostgrestException {
      rethrow;
    }
  }

  Future<void> markAsRead(String id) async {
    await _client
        .rpc('notification_mark_read', params: {'p_notification_id': id});
  }

  Future<void> registerDevice({
    required String token,
    String? platform,
    Map<String, dynamic>? metadata,
  }) async {
    await _client.rpc('register_notification_device', params: {
      'p_token': token,
      if (platform != null) 'p_platform': platform,
      if (metadata != null) 'p_metadata': metadata,
    });
  }
}

final notificationsRemoteDataSourceProvider =
    Provider<NotificationsRemoteDataSource>((ref) {
  return NotificationsRemoteDataSource(ref.watch(supabaseClientProvider));
});
