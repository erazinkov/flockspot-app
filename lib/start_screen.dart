import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          const Text(
            style: TextStyle(
              color: Color.fromARGB(255, 242, 186, 252),
              fontSize: 24,
            ),
            'Learn Flutter the fun way!',
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: startQuiz,
            icon: const Icon(
              Icons.arrow_right,
            ),
            label: const Text(
              style: TextStyle(
                color: Color.fromARGB(255, 242, 186, 252),
                fontSize: 24,
              ),
              'Start quiz',
            ),
          )
        ],
      ),
    );
  }
}
