import 'package:counter/model/user_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.displayName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            // child: ,
            ),
      ),
    );
  }
}
