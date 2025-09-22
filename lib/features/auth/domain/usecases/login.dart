import '../entities/token.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Token> execute({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
