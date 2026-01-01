import '../repositories/auth_repository.dart';

class GetBiometricsEnabledUseCase {
  GetBiometricsEnabledUseCase(this._repository);

  final AuthRepository _repository;

  Future<bool> call() => _repository.isBiometricsEnabled();
}
