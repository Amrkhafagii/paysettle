import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../src/core/cache/cache_service.dart';
import '../../data/datasources/budget_remote_data_source.dart';
import '../../data/repositories/budget_repository_impl.dart';
import '../repositories/budget_repository.dart';
import 'create_budget.dart';
import 'get_budget_categories.dart';
import 'get_budgets.dart';

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepositoryImpl(
    remoteDataSource: ref.watch(budgetRemoteDataSourceProvider),
    cacheService: ref.watch(cacheServiceProvider),
  );
});

final getBudgetsUseCaseProvider = Provider<GetBudgetsUseCase>((ref) {
  return GetBudgetsUseCase(ref.watch(budgetRepositoryProvider));
});

final createBudgetUseCaseProvider = Provider<CreateBudgetUseCase>((ref) {
  return CreateBudgetUseCase(ref.watch(budgetRepositoryProvider));
});

final getBudgetCategoriesUseCaseProvider =
    Provider<GetBudgetCategoriesUseCase>((ref) {
  return GetBudgetCategoriesUseCase(ref.watch(budgetRepositoryProvider));
});
