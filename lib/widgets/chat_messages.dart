import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = snapshot.data!.docs;
          if (!snapshot.hasData || chatDocs.isEmpty) {
            return Center(
              child: Text('No messages found.'),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred. Please try again later.'),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.only(
                bottom: 40,
                left: 13,
                right: 13,
                top: 10
            ),
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) {
              final chatMessage = chatDocs[index].data();
              final nextChatMessage = index + 1 < chatDocs.length
                  ? chatDocs[index + 1].data()
                  : null;
             final currenMessageUserId = chatMessage['userId'];
             final nextMessageUserId = nextChatMessage != null
                  ? nextChatMessage['userId']
                  : null;
             final nextIsSameUser = currenMessageUserId == nextMessageUserId;
              if (nextIsSameUser) {
                return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: FirebaseAuth.instance.currentUser!.uid ==
                      chatMessage['userId'],
                );
              } else {
                return MessageBubble.first(
                  userImage: chatMessage['userImage'],
                  username: chatMessage['username'],
                  message: chatMessage['text'],
                  isMe: FirebaseAuth.instance.currentUser!.uid ==
                      chatMessage['userId'],
                );

              }
            },

          );
        }
    );
  }
}
