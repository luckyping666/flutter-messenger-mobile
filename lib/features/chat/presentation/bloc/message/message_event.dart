import 'package:equatable/equatable.dart';


abstract class MessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoadMessages extends MessageEvent {
  final int chatId;

  LoadMessages(this.chatId);

  @override
  List<Object?> get props => [chatId];
}


class SendMessage extends MessageEvent {
  final int chatId;
  final int senderId;
  final String content;

  SendMessage({required this.chatId, required this.senderId, required this.content});

  @override
  List<Object?> get props => [chatId, senderId, content];
}
