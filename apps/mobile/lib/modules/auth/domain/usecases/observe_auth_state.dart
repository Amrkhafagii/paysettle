import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class ObserveAuthStateUseCase {
  ObserveAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  Stream<AuthSession?> call() => _repository.authStateChanges();
}
