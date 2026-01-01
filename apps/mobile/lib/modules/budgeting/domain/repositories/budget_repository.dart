import '../entities/budget.dart';
import '../entities/budget_category.dart';
import '../value_objects/budget_range.dart';
import '../value_objects/budget_request.dart';

abstract class BudgetRepository {
  Future<BudgetOverview> fetchBudgets({required BudgetRange range});

  Future<void> createBudget(BudgetRequest request);

  Future<List<BudgetCategoryOption>> fetchCategories();
}
