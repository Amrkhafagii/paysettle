import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_box.dart';
import '../../../../src/core/cache/cache_keys.dart';
import '../../../../src/core/cache/cache_service.dart';
import '../../domain/entities/budget.dart';
import '../../domain/entities/budget_category.dart';
import '../../domain/repositories/budget_repository.dart';
import '../../domain/value_objects/budget_range.dart';
import '../../domain/value_objects/budget_request.dart';
import '../datasources/budget_remote_data_source.dart';
import '../dtos/budget_category_dto.dart';
import '../dtos/budget_dto.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  BudgetRepositoryImpl({
    required BudgetRemoteDataSource remoteDataSource,
    required CacheService cacheService,
  })  : _remoteDataSource = remoteDataSource,
        _cacheService = cacheService;

  final BudgetRemoteDataSource _remoteDataSource;
  final CacheService _cacheService;

  @override
  Future<BudgetOverview> fetchBudgets({required BudgetRange range}) async {
    final monthStart = range.resolveStart(DateTime.now());
    final cacheKey = '${CacheKeys.budgetOverview}_${range.name}';

    try {
      await _remoteDataSource.evaluateAlerts(monthStart);
      final payload = await _remoteDataSource.fetchBudgets(monthStart);
      await _cacheService.write(
        CacheBox.core,
        cacheKey,
        payload.map((dto) => dto.toJson()).toList(growable: false),
      );
      final summaries =
          payload.map((dto) => dto.toDomain()).toList(growable: false);
      return _buildOverview(summaries, monthStart);
    } catch (_) {
      final cached =
          _cacheService.read<List<dynamic>>(CacheBox.core, cacheKey) ??
              const [];
      if (cached.isNotEmpty) {
        final summaries = cached
            .whereType<Map>()
            .map((entry) => BudgetDto.fromMap(entry.cast<String, dynamic>()))
            .map((dto) => dto.toDomain())
            .toList(growable: false);
        return _buildOverview(summaries, monthStart);
      }
      rethrow;
    }
  }

  @override
  Future<void> createBudget(BudgetRequest request) {
    return _remoteDataSource.createBudget(request);
  }

  @override
  Future<List<BudgetCategoryOption>> fetchCategories() async {
    try {
      final response = await _remoteDataSource.fetchCategories();
      await _cacheService.write(
        CacheBox.core,
        CacheKeys.budgetCategories,
        response.map((dto) => dto.toJson()).toList(growable: false),
      );
      return response.map((dto) => dto.toDomain()).toList(growable: false);
    } catch (_) {
      final cached = _cacheService.read<List<dynamic>>(
          CacheBox.core, CacheKeys.budgetCategories);
      if (cached == null) {
        rethrow;
      }
      return cached
          .whereType<Map>()
          .map((entry) =>
              BudgetCategoryDto.fromMap(entry.cast<String, dynamic>()))
          .map((dto) => dto.toDomain())
          .toList(growable: false);
    }
  }

  BudgetOverview _buildOverview(
      List<BudgetSummary> budgets, DateTime monthStart) {
    if (budgets.isEmpty) {
      final periodEnd = DateTime(monthStart.year, monthStart.month + 1, 0);
      return BudgetOverview(
        periodStart: monthStart,
        periodEnd: periodEnd,
        totalLimit: 0,
        totalSpent: 0,
        remaining: 0,
        warningCount: 0,
        criticalCount: 0,
        budgets: const [],
      );
    }
    final totalLimit =
        budgets.fold<double>(0, (sum, item) => sum + item.amount);
    final totalSpent = budgets.fold<double>(0, (sum, item) => sum + item.spent);
    final periodStart = budgets.first.periodStart;
    final periodEnd = budgets.first.periodEnd;
    return BudgetOverview(
      periodStart: periodStart,
      periodEnd: periodEnd,
      totalLimit: totalLimit,
      totalSpent: totalSpent,
      remaining: totalLimit - totalSpent,
      warningCount: budgets
          .where((budget) => budget.status == BudgetStatus.warning)
          .length,
      criticalCount: budgets
          .where((budget) => budget.status == BudgetStatus.exceeded)
          .length,
      budgets: budgets,
    );
  }
}
