import '../../domain/enitities/chat.dart';


class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.user1Id,
    required super.user2Id,
    required super.lastMessage,
    required super.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      user1Id: json['user1_id'],
      user2Id: json['user2_id'],
      lastMessage: json['last_message'] ?? '',
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user1_id': user1Id,
        'user2_id': user2Id,
        'last_message': lastMessage,
        'updated_at': updatedAt.toIso8601String(),
      };
}
