import '../models/chat_model.dart';
import '../models/message_model.dart';
import 'package:dio/dio.dart';


class ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSource(this.dio);

  Future<List<ChatModel>> getChats() async {
    final response = await dio.get('/chats');
    return (response.data as List)
        .map((json) => ChatModel.fromJson(json))
        .toList();
  }

  Future<ChatModel> createChat(int userId) async {
    final response = await dio.post('/chats', data: {'user_id': userId});
    return ChatModel.fromJson(response.data);
  }

  Future<List<MessageModel>> getMessages(int chatId) async {
    final response = await dio.get('/chats/$chatId/messages');
    return (response.data as List)
        .map((json) => MessageModel.fromJson(json))
        .toList();
  }

  Future<MessageModel> sendMessage(int chatId, int senderId, String content) async {
    final response = await dio.post(
      '/chats/$chatId/messages',
      data: {'sender_id': senderId, 'content': content},
    );
    return MessageModel.fromJson(response.data);
  }
}
