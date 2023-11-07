import 'package:first_app/models/vibe.dart';
import 'package:flutter/material.dart';

class VibeItem extends StatelessWidget {
  const VibeItem({
    super.key,
    required this.vibe,
  });

  final Vibe vibe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.network(
            vibe.background.toString(),
            errorBuilder: (context, exception, stackTrace) {
              return const Text('');
            },
          ).image,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          vibe.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        ),
      ]),
    );
  }
}
