import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> execute({
    required String username,
    required String email,
    required String password,
  }) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
