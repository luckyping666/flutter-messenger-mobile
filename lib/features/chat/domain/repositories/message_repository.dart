import 'package:messanger/features/chat/domain/enitities/message.dart';


abstract class MessageRepository {
  /// Получить список сообщений в чате
  Future<List<Message>> getMessages({required int chatId});

  /// Отправить новое сообщение
  Future<Message> sendMessage({required int chatId, required int senderId, required String content});
}
