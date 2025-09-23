import 'package:equatable/equatable.dart';


abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadChats extends ChatEvent {}


class CreateChat extends ChatEvent {
  final int userId;

  CreateChat(this.userId);

  @override
  List<Object?> get props => [userId];
}
