import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/network/supabase_client_provider.dart';

class PerformanceRepository {
  PerformanceRepository(this._client);

  final SupabaseClient _client;
  final Logger _logger = Logger('PerformanceRepository');

  Future<void> logSession(Map<String, dynamic> metrics) async {
    try {
      await _client.rpc('log_performance_session', params: {
        'p_metrics': metrics,
      });
    } catch (error, stack) {
      _logger.warning('Failed to log performance session', error, stack);
    }
  }
}

final performanceRepositoryProvider = Provider<PerformanceRepository>((ref) {
  return PerformanceRepository(ref.watch(supabaseClientProvider));
});
