import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});
  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
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
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Text(
                          data['question'] as String,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          data['user_answer'] as String,
                          style: GoogleFonts.lato(
                            color: Colors.pink,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          data['correct_answer'] as String,
                          style: GoogleFonts.lato(
                            color: Colors.blueAccent,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
