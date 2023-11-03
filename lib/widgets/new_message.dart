import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/api_service.dart';
import 'package:flutter/material.dart';

class User {
  final String email;
  final String image_url;
  final String username;

  const User({
    required this.email,
    required this.image_url,
    required this.username,
  });

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      image_url: map['image_url'] ?? '',
      username: map['username'] ?? '',
    );
  }
}

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  final List<User> list = [];

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final snapshot = await FirebaseDatabase.instance.ref('users').get();
    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final user = User.fromMap(value);

      list.add(user);
    });

    final userOne = list.firstWhere((e) => e.email == user.email);

    FirebaseDatabase.instance.ref('messages').push().set({
      'text': enteredMessage,
      'createdAt': DateTime.now().toString(),
      'userId': user.uid,
      'username': userOne.username,
      'userImage': userOne.image_url,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelStyle: const TextStyle(color: Colors.white, fontSize: 16),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              labelText: 'Send a message...',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              border: const OutlineInputBorder().copyWith(
                borderSide: const BorderSide(),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
          )),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: _submitMessage,
            child: Image.asset('assets/images/new_message.png'),
          ),
          // IconButton(onPressed: _submitMessage, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
