import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/widgets/chat_messages.dart';
import 'package:first_app/widgets/new_message.dart';
import 'package:flutter/material.dart';

class User {
  final String email;
  final String imageUrl;
  final String username;

  const User({
    required this.email,
    required this.imageUrl,
    required this.username,
  });

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      imageUrl: map['image_url'] ?? '',
      username: map['username'] ?? '',
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Future<List<User>> _getUsers() async {
    List<User> list = [];
    final snapshot = await FirebaseDatabase.instance.ref('users').get();
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = User.fromMap(value);
      list.add(user);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            children: const [
              Expanded(child: ChatMessages()),
              NewMessage(),
            ],
          ),
        ));
  }
}
