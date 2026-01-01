import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/budget.dart';
import '../../domain/entities/budget_category.dart';
import '../../domain/usecases/create_budget.dart';
import '../../domain/usecases/get_budget_categories.dart';
import '../../domain/usecases/get_budgets.dart';
import '../../domain/usecases/usecase_providers.dart';
import '../../domain/value_objects/budget_range.dart';
import '../../domain/value_objects/budget_request.dart';
import '../state/budgeting_state.dart';

class BudgetingController extends StateNotifier<BudgetingState> {
  BudgetingController({
    required GetBudgetsUseCase getBudgets,
    required CreateBudgetUseCase createBudget,
    required GetBudgetCategoriesUseCase getCategories,
  })  : _getBudgets = getBudgets,
        _createBudget = createBudget,
        _getCategories = getCategories,
        super(BudgetingState.initial()) {
    _loadAll();
  }

  final GetBudgetsUseCase _getBudgets;
  final CreateBudgetUseCase _createBudget;
  final GetBudgetCategoriesUseCase _getCategories;

  Future<void> _loadAll() async {
    await Future.wait([
      loadBudgets(range: state.range),
      loadCategories(),
    ]);
  }

  Future<void> loadBudgets({BudgetRange? range}) async {
    final targetRange = range ?? state.range;
    state = state.copyWith(
      range: targetRange,
      overview: const AsyncValue.loading(),
    );
    final result =
        await AsyncValue.guard(() => _getBudgets(range: targetRange));
    state = state.copyWith(overview: result);
  }

  Future<void> loadCategories() async {
    if (state.categories is AsyncData<List<BudgetCategoryOption>>) {
      return;
    }
    final result = await AsyncValue.guard(_getCategories);
    state = state.copyWith(categories: result);
  }

  Future<void> refresh() => loadBudgets(range: state.range);

  void selectRange(BudgetRange range) {
    if (range == state.range) {
      return;
    }
    loadBudgets(range: range);
  }

  Future<void> createBudget(BudgetRequest request) async {
    state = state.copyWith(isCreating: true);
    try {
      await _createBudget(request);
      await loadBudgets(range: state.range);
    } finally {
      state = state.copyWith(isCreating: false);
    }
  }
}

final budgetingControllerProvider =
    StateNotifierProvider<BudgetingController, BudgetingState>((ref) {
  return BudgetingController(
    getBudgets: ref.watch(getBudgetsUseCaseProvider),
    createBudget: ref.watch(createBudgetUseCaseProvider),
    getCategories: ref.watch(getBudgetCategoriesUseCaseProvider),
  );
});
