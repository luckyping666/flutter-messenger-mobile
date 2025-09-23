import 'package:equatable/equatable.dart';
import 'package:messanger/features/auth/domain/entities/token.dart';
import 'package:messanger/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthTokenReceived extends AuthState {
  final Token token;

  AuthTokenReceived({required this.token});

  @override
  List<Object?> get props => [token];
}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
