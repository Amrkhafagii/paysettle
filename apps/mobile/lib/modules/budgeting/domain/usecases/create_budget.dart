import '../repositories/budget_repository.dart';
import '../value_objects/budget_request.dart';

class CreateBudgetUseCase {
  CreateBudgetUseCase(this._repository);

  final BudgetRepository _repository;

  Future<void> call(BudgetRequest request) {
    return _repository.createBudget(request);
  }
}
