import 'package:flockspot_app/summary_element.dart';
import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(context) {
    final isCorrectAnswer = data['user_answer'] == data['correct_answer'];
    final questionIndex = data['question_index'] as int;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isCorrectAnswer ? Colors.blue : Colors.pink,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            (questionIndex + 1).toString(),
          ),
        ),
        Expanded(
          child: SummaryElement(data),
        )
      ],
    );
  }
}
