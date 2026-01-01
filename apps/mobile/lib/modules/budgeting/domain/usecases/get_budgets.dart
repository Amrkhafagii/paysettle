import '../entities/budget.dart';
import '../repositories/budget_repository.dart';
import '../value_objects/budget_range.dart';

class GetBudgetsUseCase {
  GetBudgetsUseCase(this._repository);

  final BudgetRepository _repository;

  Future<BudgetOverview> call({required BudgetRange range}) {
    return _repository.fetchBudgets(range: range);
  }
}
