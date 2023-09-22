import 'package:flockspot_app/data/questions.dart';
import 'package:flockspot_app/questions_screen.dart';
import 'package:flockspot_app/results_screen.dart';
import 'package:flockspot_app/start_screen.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      if (selectedAnswers.length == questions.length) {
        activeScreen = StartScreen(switchScreen);
        selectedAnswers = [];
      } else {
        activeScreen = QuestionsScreen(
          onSelectAnswer: chooseAnswer,
        );
      }
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswers: selectedAnswers,
          restartQuiz: switchScreen,
        );
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 67, 12, 77),
                Colors.purple,
              ],
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
