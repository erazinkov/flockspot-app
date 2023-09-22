import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flockspot_app/data/questions.dart';
import 'package:flockspot_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  final Function() restartQuiz;

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 234, 199, 240),
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: restartQuiz,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              label: Text(
                style: GoogleFonts.lato(
                  color: Color.fromARGB(255, 242, 186, 252),
                  fontSize: 24,
                ),
                'Restart Quiz',
              ),
            )
          ],
        ),
      ),
    );
  }
}
