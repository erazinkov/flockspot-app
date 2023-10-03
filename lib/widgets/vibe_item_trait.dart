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
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(
          height: 6,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
      ],
    );
  }
}
