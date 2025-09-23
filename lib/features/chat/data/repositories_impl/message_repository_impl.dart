import 'package:messanger/features/chat/domain/enitities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/chat_remote_datasource.dart';


class MessageRepositoryImpl implements MessageRepository {
  final ChatRemoteDataSource remote;

  MessageRepositoryImpl(this.remote);

  @override
  Future<List<Message>> getMessages({required int chatId}) async {
    final messages = await remote.getMessages(chatId);
    return messages;
  }

  @override
  Future<Message> sendMessage({
    required int chatId,
    required int senderId,
    required String content,
  }) async {
    final message = await remote.sendMessage(chatId, senderId, content);
    return message;
  }
}
