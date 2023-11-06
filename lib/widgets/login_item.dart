import 'package:flutter/material.dart';
import 'dart:ui';

class LoginItem extends StatelessWidget {
  const LoginItem({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onSelectItem,
  });

  final String label;
  final String iconPath;
  final void Function(String identifier) onSelectItem;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: GestureDetector(
          onTap: () {
            onSelectItem(label);
          },
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.2),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Image(
              image: AssetImage(iconPath),
              color: null,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}
