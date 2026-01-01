import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../../domain/value_objects/insights_range.dart';
import '../dtos/insights_dashboard_dto.dart';

class InsightsRemoteDataSource {
  InsightsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<InsightsDashboardDto> fetchDashboard({
    required InsightsRange range,
    bool forceRefresh = false,
  }) async {
    try {
      final response = await _client.rpc<Map<String, dynamic>>(
        'insights_dashboard',
        params: {
          'p_timeframe': range.rpcValue,
          'p_force_refresh': forceRefresh,
        },
      );
      return InsightsDashboardDto.fromMap(response);
    } on PostgrestException {
      rethrow;
    }
  }
}

final insightsRemoteDataSourceProvider =
    Provider<InsightsRemoteDataSource>((ref) {
  return InsightsRemoteDataSource(ref.watch(supabaseClientProvider));
});
