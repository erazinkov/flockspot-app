import 'package:flutter/material.dart';

const String kInitialDescription = 'Vibe description...';

class VibeItemTrait extends StatelessWidget {
  const VibeItemTrait({super.key, this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          description ?? kInitialDescription,
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),
        const SizedBox(
          width: 6,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        )
      ],
    );
  }
}
