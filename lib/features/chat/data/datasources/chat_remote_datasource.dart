import 'package:dio/dio.dart';
import '../models/chat_model.dart';

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
}
