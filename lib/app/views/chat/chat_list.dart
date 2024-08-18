import 'package:flutter/material.dart';

import '../../../controllers/controllers.dart';
import 'chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.user, required this.controller});

  final UserDataController user;
  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              controller: controller,
              user: user,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: const Text("Chat"),
      ),
    );
  }
}
