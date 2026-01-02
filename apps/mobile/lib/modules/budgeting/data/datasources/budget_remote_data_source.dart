import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../src/core/network/supabase_client_provider.dart';
import '../../domain/entities/budget.dart';
import '../../domain/value_objects/budget_request.dart';
import '../dtos/budget_category_dto.dart';
import '../dtos/budget_dto.dart';

class BudgetRemoteDataSource {
  BudgetRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<BudgetDto>> fetchBudgets(DateTime month) async {
    try {
      final response = await _client.rpc<List<dynamic>>(
        'budget_progress',
        params: {'p_month': month.toIso8601String()},
      );
      return response
          .whereType<Map<String, dynamic>>()
          .map(BudgetDto.fromMap)
          .toList(growable: false);
    } on PostgrestException {
      rethrow;
    }
  }

  Future<void> createBudget(BudgetRequest request) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const PostgrestException(
        message: 'Not authenticated',
        code: '401',
      );
    }
    final payload = {
      'owner_id': userId,
      'label': request.label,
      'category_id': request.categoryId,
      'amount': request.amount,
      'currency': request.currency,
      'threshold_percent': request.thresholdPercent,
      'recurrence': request.recurrence.rpcValue,
    };
    await _client.from('budget_rules').insert(payload);
  }

  Future<void> evaluateAlerts(DateTime month) async {
    try {
      await _client.rpc('evaluate_budget_alerts', params: {
        'p_month': month.toIso8601String(),
      });
    } on PostgrestException {
      rethrow;
    }
  }

  Future<List<BudgetCategoryDto>> fetchCategories() async {
    try {
      final response = await _client
          .from('categories')
          .select('id,label,icon,color,kind')
          .order('label')
          .limit(100);
      return response
          .whereType<Map<String, dynamic>>()
          .map(BudgetCategoryDto.fromMap)
          .toList(growable: false);
    } on PostgrestException {
      rethrow;
    }
  }
}

final budgetRemoteDataSourceProvider = Provider<BudgetRemoteDataSource>((ref) {
  return BudgetRemoteDataSource(ref.watch(supabaseClientProvider));
});
