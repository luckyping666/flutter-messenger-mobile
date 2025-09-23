import 'package:dio/dio.dart';
import '../models/message_model.dart';

class MessageRemoteDataSource {
  final Dio dio;
  MessageRemoteDataSource(this.dio);

  Future<List<MessageModel>> getMessages(int chatId) async {
    final response = await dio.get('/messages/chat/$chatId');
    
    print(response.data);
    
    return (response.data as List)
        .map((json) => MessageModel.fromJson(json))
        .toList();
  }

  Future<MessageModel> sendMessage(int chatId, int senderId, String content) async {
    final response = await dio.post(
      '/messages',
      data: {'chat_id': chatId, 'content': content},
    );
    return MessageModel.fromJson(response.data);
  }
}
