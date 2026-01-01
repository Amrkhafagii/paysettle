import '../entities/budget_category.dart';
import '../repositories/budget_repository.dart';

class GetBudgetCategoriesUseCase {
  GetBudgetCategoriesUseCase(this._repository);

  final BudgetRepository _repository;

  Future<List<BudgetCategoryOption>> call() {
    return _repository.fetchCategories();
  }
}
