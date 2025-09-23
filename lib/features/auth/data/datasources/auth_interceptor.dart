import 'dart:async';
import 'package:dio/dio.dart';
import 'package:messanger/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:messanger/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource local;
  final AuthRemoteDataSource remote;
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  AuthInterceptor(this.local, this.remote);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await local.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Если токен протух
    if (err.response?.statusCode == 401) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshCompleter = Completer();

        try {
          final refreshToken = await local.getRefreshToken();
          if (refreshToken != null) {
            final newToken = await remote.refreshToken(refreshToken);
            await local.saveTokens(
              accessToken: newToken.accessToken,
              refreshToken: newToken.refreshToken,
            );
          }
          _refreshCompleter?.complete();
        } catch (e) {
          _refreshCompleter?.completeError(e);
        } finally {
          _isRefreshing = false;
        }
      }

      try {
        // Ждем, пока обновится токен
        await _refreshCompleter?.future;
        final newAccessToken = await local.getAccessToken();

        // Повторяем запрос с новым токеном
        final cloneReq = await _retryRequest(err.requestOptions, newAccessToken);
        return handler.resolve(cloneReq);
      } catch (e) {
        return handler.reject(err);
      }
    } else {
      // Другие ошибки оставляем без изменений
      return handler.reject(err);
    }
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions, String? newToken) {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        if (newToken != null) 'Authorization': 'Bearer $newToken',
      },
    );

    final dio = Dio(); // создаём новый Dio для повтора
    return dio.request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}
