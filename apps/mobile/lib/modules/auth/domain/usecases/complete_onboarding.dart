import '../repositories/auth_repository.dart';

class CompleteOnboardingUseCase {
  CompleteOnboardingUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.markOnboardingComplete();
}
