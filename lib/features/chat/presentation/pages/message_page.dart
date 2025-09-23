import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/theme.dart';
import 'package:messanger/features/chat/domain/enitities/chat.dart';
import 'package:messanger/features/chat/domain/enitities/message.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_event.dart';
import 'package:messanger/features/chat/presentation/bloc/message/message_state.dart';

class ChatPage extends StatefulWidget {
  final Chat chat; // чат, который открывается

  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Загружаем все сообщения этого чата
    BlocProvider.of<MessageBloc>(context)
        .add(LoadMessages(chatId: widget.chat.id));
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    BlocProvider.of<MessageBloc>(context).add(SendMessage(
      chatId: widget.chat.id,
      content: content,
      senderId: widget.chat.user1Id, // или текущий пользователь
    ));

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
              "Chat with User ${widget.chat.user2Id}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageLoading) {
                  return Center(child: CircularProgressIndicator());
                } 
                
                else if (state is MessageLoaded) {
                  final messages = state.messages;
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSender = message.senderId == widget.chat.user1Id;
                      return _buildMessageBubble(message, isSender);
                    },
                  );
                } 
                
                else if (state is MessageError) {
                  return Center(
                      child: Text(state.message,
                          style: TextStyle(color: Colors.red)));
                }
                
                return SizedBox.shrink();
              },
            ),
          ),
          _buildMessageInput(),
        ],
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
            onTap: _sendMessage,
          ),
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
}
