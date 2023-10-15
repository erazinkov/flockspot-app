import 'package:first_app/models/vibe.dart';
import 'package:flutter/material.dart';

class VibeItem extends StatelessWidget {
  const VibeItem({super.key, required this.vibe});

  final Vibe vibe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Text(
        vibe.name,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 34,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
