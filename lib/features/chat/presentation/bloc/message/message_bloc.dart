import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:messanger/features/chat/domain/usecases/send_message_usecase.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  MessageBloc({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(MessageInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<MessageState> emit) async {
    emit(MessageLoading());
    try {
      final messages = await getMessagesUseCase.call(chatId: event.chatId);
      emit(MessageLoaded(messages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<MessageState> emit) async {
    try {
      await sendMessageUseCase.call(
        chatId: event.chatId,
        senderId: event.senderId,
        content: event.content,
      );
      final messages = await getMessagesUseCase.call(chatId: event.chatId);
      emit(MessageLoaded(messages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
