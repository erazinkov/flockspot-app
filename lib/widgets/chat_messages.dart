import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('messages').onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.children.isEmpty) {
          return const Center(
            child: Text(
              'No messages found...',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }
        Map<dynamic, dynamic> map =
            snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
        List<dynamic> loadedMessages = [];
        loadedMessages.clear();
        loadedMessages = map.values.toList();
        loadedMessages.sort(
          (a, b) => DateTime.parse(a['createdAt'])
              .millisecondsSinceEpoch
              .compareTo(DateTime.parse(b['createdAt']).millisecondsSinceEpoch),
        );
        loadedMessages = loadedMessages.reversed.toList();
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) {
            final chatMessage = loadedMessages[index];
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1]
                : null;
            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;
            if (nextUserIsSame) {
              return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: authenticatedUser!.uid == currentMessageUserId);
            } else {
              return MessageBubble.first(
                  userImage: chatMessage['userImage'],
                  username: chatMessage['username'],
                  message: chatMessage['text'],
                  isMe: authenticatedUser!.uid == currentMessageUserId);
            }
          },
        );
      },
    );
  }
}
