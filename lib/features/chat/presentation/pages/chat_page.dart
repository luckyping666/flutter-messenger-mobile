import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:messanger/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:messanger/features/chat/presentation/bloc/chat/chat_event.dart';
import 'package:messanger/features/chat/presentation/bloc/chat/chat_state.dart';
import 'package:messanger/features/chat/presentation/widgets/message_tile.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          else if (state is ChatLoaded) {
          
            if (state.chats.isEmpty) {
              return const Center(child: Text("No chats yet"));
            }
          
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                
                final chat = state.chats[index];
                final formattedTime = DateFormat.Hm().format(chat.updatedAt);

                return GestureDetector(
                  
                  onTap: () {
                    Navigator.pushNamed(context, "/chat", arguments: chat.id);
                  },
                  
                  child: MessageTile(
                    name: "Chat with User ${chat.user2Id}", // пока заглушка
                    message: chat.lastMessage,
                    time: formattedTime,
                  ),

                );
              },
            );
          } 
          
          else if (state is ChatError) {
            return Center(child: Text(state.message));
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}