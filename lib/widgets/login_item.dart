import 'package:flutter/material.dart';
import 'dart:ui';

class LoginItem extends StatelessWidget {
  const LoginItem(
      {super.key,
      required this.label,
      required this.iconPath,
      required this.onSelectItem});

  final String label;
  final String iconPath;
  final void Function(String identifier) onSelectItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 130 / 160,
        child: ClipRect(
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
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(iconPath),
                      color: null,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      label,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.3),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
