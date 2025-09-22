import '../../domain/entities/user.dart';
import '../../domain/entities/token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  /// Регистрация пользователя — возвращает UserModel
  @override
  Future<User> register({required String username, required String email, required String password}) async {
    final userModel = await remote.register(username: username, email: email, password: password);
    return userModel;
  }

  /// Логин — возвращает TokenModel и сохраняет токены локально
  @override
  Future<Token> login({required String email, required String password}) async {
    final tokenModel = await remote.login(email: email, password: password);
    await local.saveTokens(accessToken: tokenModel.accessToken, refreshToken: tokenModel.refreshToken);
    return tokenModel;
  }

  /// Обновление токена
  @override
  Future<Token> refreshToken({required String refreshToken}) async {
    final tokenModel = await remote.refreshToken(refreshToken);
    await local.saveTokens(accessToken: tokenModel.accessToken, refreshToken: tokenModel.refreshToken);
    return tokenModel;
  }

  /// Логаут — очищает локальные токены
  @override
  Future<void> logout() async {
    await local.clearTokens();
  }

  /// Получение текущего пользователя
  @override
  Future<User?> getCurrentUser() async {
    // Здесь можно использовать токен для запроса к backend
    final accessToken = await local.getAccessToken();
    if (accessToken == null) return null;

    // Пока возвращаем заглушку
    return UserModel(id: 0, username: 'Demo', email: 'demo@example.com');
  }
}
