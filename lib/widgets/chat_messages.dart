import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
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
            child: Text('No messages found...'),
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
        // print('123');
        // print(map.values);
        // return const Center(
        //   child: Text('Something went wrong...'),
        // );
        return ListView.builder(
          itemCount: loadedMessages.length,
          itemBuilder: (context, index) {
            return Text(loadedMessages[index]['text']);
          },
        );
      },
    );
  }
}
