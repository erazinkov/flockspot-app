import 'dart:ffi';

import 'package:first_app/models/vibe.dart';
import 'package:flutter/material.dart';

class VibeBoardItem extends StatelessWidget {
  const VibeBoardItem({
    super.key,
    required this.vibe,
    this.showCloseIcon = false,
  });

  final Vibe vibe;
  final bool showCloseIcon;

  @override
  Widget build(BuildContext context) {
    Widget content = const Row(children: [
      SizedBox(
        width: 8,
      ),
      Icon(Icons.multiple_stop)
    ]);
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 4, right: 8, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: showCloseIcon
            ? Theme.of(context).colorScheme.onSecondary
            : Color.fromRGBO(255, 255, 255, 0.5),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          vibe.name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 24,
              fontWeight: FontWeight.w400),
        ),
        if (showCloseIcon) content,
      ]),
      // if (showCloseIcon) content,
    );
  }
}
