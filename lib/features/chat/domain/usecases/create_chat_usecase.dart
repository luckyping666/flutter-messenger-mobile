import 'package:messanger/features/chat/domain/enitities/chat.dart';
import '../repositories/chat_repository.dart';


class CreateChatUseCase {
  final ChatRepository repository;

  CreateChatUseCase(this.repository);

  Future<Chat> call({required int userId}) async {
    return await repository.createChat(userId: userId);
  }
}
