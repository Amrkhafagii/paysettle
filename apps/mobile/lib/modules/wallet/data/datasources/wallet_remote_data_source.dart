import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../../domain/entities/wallet_overview.dart';
import '../dtos/wallet_overview_dto.dart';

class WalletRemoteDataSource {
  WalletRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<WalletOverviewDto?> fetchOverview({required WalletTimeframe timeframe}) async {
    try {
      final response = await _client.rpc<List<dynamic>>(
        'wallet_overview',
        params: {'p_timeframe': timeframe.rpcValue},
      );
      if (response.isEmpty) {
        return null;
      }
      final payload = response.first;
      if (payload is Map<String, dynamic>) {
        return WalletOverviewDto.fromMap(payload);
      }
      return null;
    } on PostgrestException {
      rethrow;
    }
  }

  Future<List<WalletCounterparty>> fetchHistory({WalletDirection? direction}) async {
    try {
      final params = <String, dynamic>{
        if (direction != null) 'p_direction': direction.name,
      };
      final response = await _client.rpc<List<dynamic>>(
        'wallet_transaction_history',
        params: params.isEmpty ? null : params,
      );
      if (response.isEmpty) {
        return const [];
      }
      return response
          .whereType<Map<String, dynamic>>()
          .map((entry) => WalletCounterparty(
                transactionId: '${entry['transaction_id'] ?? entry['transactionId']}',
                contactId: entry['contact_id']?.toString(),
                journeyId: entry['journey_id']?.toString(),
                name: '${entry['contact_name'] ?? entry['contactName'] ?? 'Unassigned'}',
                amount: walletDtoToDouble(entry['amount']),
                status: '${entry['status'] ?? 'open'}',
                direction: direction ?? _parseDirection(entry['direction']),
                issueDate:
                    walletDtoParseDate(entry['issue_date'] ?? entry['issueDate']),
                dueDate:
                    walletDtoParseDate(entry['due_date'] ?? entry['dueDate']),
              ))
          .toList(growable: false);
    } on PostgrestException {
      rethrow;
    }
  }

  WalletDirection _parseDirection(dynamic raw) {
    final value = '${raw ?? ''}'.toLowerCase();
    return value == 'pay' ? WalletDirection.pay : WalletDirection.collect;
  }
}

final walletRemoteDataSourceProvider = Provider<WalletRemoteDataSource>((ref) {
  return WalletRemoteDataSource(ref.watch(supabaseClientProvider));
});
