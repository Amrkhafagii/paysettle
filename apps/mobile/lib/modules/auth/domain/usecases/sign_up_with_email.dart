import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailUseCase {
  SignUpWithEmailUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call(
      {required String name, required String email, required String password}) {
    return _repository.signUpWithEmail(
        name: name, email: email, password: password);
  }
}
