import 'package:equatable/equatable.dart';
import 'package:messanger/features/chat/domain/enitities/message.dart';


abstract class MessageState extends Equatable {
  @override
  List<Object?> get props => [];
}


class MessageInitial extends MessageState {}


class MessageLoading extends MessageState {}


class MessageLoaded extends MessageState {
  final List<Message> messages;

  MessageLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}


class MessageError extends MessageState {
  final String message;

  MessageError(this.message);

  @override
  List<Object?> get props => [message];
}
