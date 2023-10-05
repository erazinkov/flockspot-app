import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting another tab!',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ],
      ),
    );

    if (title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
