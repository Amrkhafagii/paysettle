import '../repositories/auth_repository.dart';

class SendPasswordResetUseCase {
  SendPasswordResetUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(String email) => _repository.sendPasswordReset(email);
}
