import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    required this.answerText,
    required this.onTap,
    super.key,
  });
  final void Function() onTap;
  final String answerText;
  @override
  Widget build(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        backgroundColor: const Color.fromARGB(255, 87, 39, 176),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      onPressed: onTap,
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
