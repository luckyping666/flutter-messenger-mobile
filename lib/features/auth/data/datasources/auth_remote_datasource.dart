import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/token_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<TokenModel> login({required String email, required String password}) async {
    final response = await dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return TokenModel.fromJson(response.data);
  }

  Future<UserModel> register({required String username, required String email, required String password}) async {
    final response = await dio.post('/auth/register', data: {
      'username': username,
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response.data);
  }

  Future<TokenModel> refreshToken(String refreshToken) async {
    final response = await dio.post('/auth/refresh', data: {
      'refresh_token': refreshToken,
    });
    return TokenModel.fromJson(response.data);
  }
}
