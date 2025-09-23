import 'package:messanger/features/chat/domain/enitities/message.dart';
import '../repositories/message_repository.dart';


class SendMessageUseCase {
  final MessageRepository repository;

  SendMessageUseCase(this.repository);

  Future<Message> call({
    required int chatId,
    required int senderId,
    required String content,
  }) async {
    return await repository.sendMessage(
      chatId: chatId,
      senderId: senderId,
      content: content,
    );
  }
}
