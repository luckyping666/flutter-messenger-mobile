import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/theme.dart';
import 'package:messanger/features/chat/domain/enitities/message.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_event.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_state.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final int chatId;
  final TextEditingController _controller = TextEditingController();
  final int currentUserId = 4; // заменить на реальный ID пользователя

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    chatId = ModalRoute.of(context)!.settings.arguments as int;

    // Загружаем сообщения чата
    context.read<MessageBloc>().add(LoadMessages(chatId: chatId));
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    context.read<MessageBloc>().add(
      SendMessage(
        chatId: chatId,
        content: content,
        senderId: currentUserId,
      ),
    );

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
            SizedBox(width: 10),
            Text(
              "Chat #$chatId",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MessageLoaded) {
                  final messages = state.messages;
                  if (messages.isEmpty) {
                    return Center(
                      child: Text("No messages yet.", style: TextStyle(color: Colors.grey)),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSender = message.senderId == currentUserId;
                      return _buildMessageBubble(message, isSender);
                    },
                  );
                } else if (state is MessageError) {
                  return Center(
                    child: Text(state.message, style: TextStyle(color: Colors.red)),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          _buildMessageInput(), // подключаем поле ввода
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: isSender ? 30 : 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSender ? DefaultColors.senderMessage : DefaultColors.receiverMessage,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message.content, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: DefaultColors.sendMessageInput,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            child: Icon(Icons.camera_alt, color: Colors.grey),
            onTap: () {},
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            child: Icon(Icons.send, color: Colors.grey),
            onTap: _sendMessage, // отправка сообщения
          ),
        ],
      ),
    );
  }
}
