import 'package:messanger/features/chat/domain/enitities/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';


class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remote;

  ChatRepositoryImpl({required this.remote});

  @override
  Future<List<Chat>> getChats() async {
    final chats = await remote.getChats();
    return chats;
  }

  @override
  Future<Chat> createChat({required int userId}) async {
    final chat = await remote.createChat(userId);
    return chat;
  }
}
