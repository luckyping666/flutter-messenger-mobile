import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final int id;
  final int user1Id;
  final int user2Id;
  final String lastMessage;
  final DateTime updatedAt;

  const Chat({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.lastMessage,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, user1Id, user2Id, lastMessage, updatedAt];
}
