import 'package:first_app/widgets/user_info/vibe.dart';
import 'package:flutter/material.dart';

class VibesList extends StatelessWidget {
  const VibesList({super.key, required this.vibes});
  final List<String> vibes;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ...vibes.map((vibe) {
            return Vibe(text: vibe);
          })
        ],
      ),
    );
  }
}
