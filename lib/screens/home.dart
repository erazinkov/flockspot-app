import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

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
          SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting another tab!',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ],
      ),
    );

    return content;
  }
}
