import 'package:messanger/features/auth/domain/entities/user.dart';
import 'package:messanger/features/auth/domain/repositories/auth_repository.dart';

class RegisterParams {
  final String username;
  final String email;
  final String password;

  RegisterParams({
    required this.username,
    required this.email,
    required this.password,
  });
}

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<User> call(RegisterParams params) async {
    return await repository.register(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}