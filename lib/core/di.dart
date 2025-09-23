import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:messanger/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:messanger/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:messanger/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:messanger/features/auth/domain/usecases/login.dart';
import 'package:messanger/features/auth/domain/usecases/logout.dart';
import 'package:messanger/features/auth/domain/usecases/register.dart';
import 'package:messanger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messanger/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:messanger/features/chat/data/datasources/message_remote_datasource.dart';
import 'package:messanger/features/chat/data/repositories_impl/chat_repository_impl.dart';
import 'package:messanger/features/chat/data/repositories_impl/message_repository_impl.dart';
import 'package:messanger/features/chat/domain/usecases/create_chat_usecase.dart';
import 'package:messanger/features/chat/domain/usecases/get_chats_usecase.dart';
import 'package:messanger/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:messanger/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:messanger/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_bloc.dart';


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


class ChatDI {
  static Dio provideDio() {
    return Dio(BaseOptions(baseUrl: "http://192.168.0.100:8000")); // локальная сеть
  }

  // ===== Chat =====
  static ChatRepositoryImpl provideChatRepository() {
    return ChatRepositoryImpl(remote: ChatRemoteDataSource(provideDio()));
  }

  static GetChatsUseCase provideGetChatsUseCase() {
    return GetChatsUseCase(provideChatRepository());
  }

  static CreateChatUseCase provideCreateChatUseCase() {
    return CreateChatUseCase(provideChatRepository());
  }

  static ChatBloc provideChatBloc() {
    return ChatBloc(
      getChatsUseCase: provideGetChatsUseCase(),
      createChatUseCase: provideCreateChatUseCase(),
    );
  }

  // ===== Message =====
  static MessageRepositoryImpl provideMessageRepository() {
    return MessageRepositoryImpl(remote: MessageRemoteDataSource(provideDio()));
  }

  static GetMessagesUseCase provideGetMessagesUseCase() {
    return GetMessagesUseCase(provideMessageRepository());
  }

  static SendMessageUseCase provideSendMessageUseCase() {
    return SendMessageUseCase(provideMessageRepository());
  }

  static MessageBloc provideMessageBloc() {
    return MessageBloc(
      getMessagesUseCase: provideGetMessagesUseCase(),
      sendMessageUseCase: provideSendMessageUseCase(),
    );
  }
}
