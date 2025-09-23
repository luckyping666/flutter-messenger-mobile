import '../entities/token.dart';
import '../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase({required this.repository});

  Future<Token> execute(String refreshToken) async {
    return await repository.refreshToken(refreshToken: refreshToken);
  }
}
