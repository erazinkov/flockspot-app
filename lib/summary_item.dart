import 'package:flockspot_app/summary_element.dart';
import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: data['user_answer'] == data['correct_answer']
                ? Colors.blue
                : Colors.pink,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            ((data['question_index'] as int) + 1).toString(),
          ),
        ),
        Expanded(
          child: SummaryElement(data),
        )
      ],
    );
  }
}
