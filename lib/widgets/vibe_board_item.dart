import 'package:first_app/models/vibe.dart';
import 'package:flutter/material.dart';

class VibeBoardItem extends StatelessWidget {
  const VibeBoardItem({
    super.key,
    required this.vibe,
    this.isSelected = false,
  });

  final Vibe vibe;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Widget content = Row(children: [
      const SizedBox(
        width: 8,
      ),
      isSelected ? const Icon(Icons.close) : const Icon(Icons.check),
    ]);
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 4, right: 8, bottom: 4),
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              vibe.background ?? 'https://via.placeholder.com/600/91c952',
            )),
        borderRadius: BorderRadius.circular(12),
        color: isSelected
            ? Theme.of(context).colorScheme.onSecondary
            : Color.fromARGB(126, 151, 151, 151),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          vibe.name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.w400),
        ),
        content,
      ]),
    );
  }
}
