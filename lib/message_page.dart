import 'package:flutter/material.dart';
import 'package:messanger/core/theme.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

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
      body: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(5.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildRecentContact("Viktor", context),
                _buildRecentContact("Alexey", context),
                _buildRecentContact("Roman", context),
                _buildRecentContact("Vladislav", context),
                _buildRecentContact("Fedor", context),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: DefaultColors.messageListPage),
              child: ListView(
                children: [
                  _buildMessegeTile("Victor", "Hello bro, wsp?", "00:12"),
                  _buildMessegeTile("Roman", "Hello bro, yo", "08:43"),
                  _buildMessegeTile("Sergey", "52 52 52", "09:52"),
                  _buildMessegeTile("Borya", "Crocodilo Bombardiro", "11:10"),
                  _buildMessegeTile("Alfred", "Sosal?", "13:13"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessegeTile(String name, String message, String time) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage("https://via.placeholder.com/150"),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: TextStyle(color: Colors.grey),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(time, style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildRecentContact(String name, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 5),
          Text(name, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}