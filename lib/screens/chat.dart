import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Chat Screen'),
        actions: [
          IconButton(
            icon:  Icon(
              Icons.exit_to_app,
              color:  Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
                FirebaseAuth.instance.signOut();

            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Chat Screen!'),
      ),
    );
  }
}
