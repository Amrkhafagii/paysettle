import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailUseCase {
  SignInWithEmailUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({required String email, required String password}) {
    return _repository.signInWithEmail(email: email, password: password);
  }
}
