import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/features/chat/domain/usecases/create_chat_usecase.dart';
import 'package:messanger/features/chat/domain/usecases/get_chats_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatsUseCase;
  final CreateChatUseCase createChatUseCase;

  ChatBloc({
    required this.getChatsUseCase,
    required this.createChatUseCase,
  }) : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<CreateChat>(_onCreateChat);
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final chats = await getChatsUseCase.call();
      emit(ChatLoaded(chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onCreateChat(CreateChat event, Emitter<ChatState> emit) async {
    try {
      await createChatUseCase.call(userId: event.userId);
      final chats = await getChatsUseCase.call();
      emit(ChatLoaded(chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
