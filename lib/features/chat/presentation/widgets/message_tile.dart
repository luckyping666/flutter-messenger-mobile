import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const MessageTile({super.key, required this.message, required this.time, required this.name});

  @override
  Widget build(BuildContext context) {
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
}