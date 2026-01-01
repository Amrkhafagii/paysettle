import '../repositories/auth_repository.dart';

class SetBiometricsEnabledUseCase {
  SetBiometricsEnabledUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(bool enabled) => _repository.setBiometricsEnabled(enabled);
}
