import 'package:messanger/features/chat/domain/enitities/message.dart';
import '../repositories/message_repository.dart';


class GetMessagesUseCase {
  final MessageRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<Message>> call({required int chatId}) async {
    return await repository.getMessages(chatId: chatId);
  }
}
