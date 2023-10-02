import 'package:first_app/widgets/vibe_item.dart';
import 'package:flutter/material.dart';

class Vibes extends StatelessWidget {
  const Vibes({super.key, required this.vibes});
  final List<String> vibes;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: [
        ...vibes.map((vibe) {
          return VibeItem(title: vibe);
        })
      ],
    );
  }
}
