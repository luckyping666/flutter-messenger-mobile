
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:messanger/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:messanger/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:messanger/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:messanger/features/auth/domain/usecases/login.dart';
import 'package:messanger/features/auth/domain/usecases/logout.dart';
import 'package:messanger/features/auth/domain/usecases/register.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_bloc.dart';

class DI {
  // Data sources
  static AuthRemoteDataSource provideAuthRemoteDataSource() {
    final dio = Dio(BaseOptions(baseUrl: "http://192.168.0.14:8000"));
    return AuthRemoteDataSource(dio);
  }

   static AuthLocalDataSource provideAuthLocalDataSource() {
    final storage = const FlutterSecureStorage();
    return AuthLocalDataSource(storage);
  }

  // Repository
  static AuthRepositoryImpl provideAuthRepository() {
    return AuthRepositoryImpl(
      remote: provideAuthRemoteDataSource(),
      local: provideAuthLocalDataSource(),
    );
  }

  // UseCases
  static RegisterUseCase provideRegisterUseCase() {
    return RegisterUseCase(repository: provideAuthRepository());
  }

  static LoginUseCase provideLoginUseCase() {
    return LoginUseCase(repository: provideAuthRepository());
  }

  static LogoutUseCase provideLogoutUseCase() {
    return LogoutUseCase(repository: provideAuthRepository());
  }

  // Bloc
  static AuthBloc provideAuthBloc() {
    return AuthBloc(
      registerUseCase: provideRegisterUseCase(),
      loginUseCase: provideLoginUseCase(),
      logoutUseCase: provideLogoutUseCase(),
    );
  }
}
