import 'package:messanger/features/chat/domain/enitities/chat.dart';

abstract class ChatRepository {
  /// Получить список чатов текущего пользователя
  Future<List<Chat>> getChats();

  /// Создать новый чат с пользователем
  Future<Chat> createChat({required int userId});
}
