import '../entities/user.dart';
import '../entities/token.dart';

abstract class AuthRepository {
  /// Регистрация нового пользователя
  Future<User> register({
    required String username,
    required String email,
    required String password,
  });

  /// Логин пользователя, возвращает токены
  Future<Token> login({
    required String email,
    required String password,
  });

  /// Обновление access token с использованием refresh token
  Future<Token> refreshToken({required String refreshToken});

  /// Логаут пользователя, удаление токенов
  Future<void> logout();

  /// Получение текущего пользователя (если есть токены)
  Future<User?> getCurrentUser();
}
