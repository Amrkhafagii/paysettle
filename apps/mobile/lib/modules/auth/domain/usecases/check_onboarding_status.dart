import '../repositories/auth_repository.dart';

class CheckOnboardingStatusUseCase {
  CheckOnboardingStatusUseCase(this._repository);

  final AuthRepository _repository;

  Future<bool> call() => _repository.hasCompletedOnboarding();
}
