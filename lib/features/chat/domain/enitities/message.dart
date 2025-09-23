import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int id;
  final int chatId;
  final int senderId;
  final String content;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, chatId, senderId, content, createdAt];
}
