import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryElement extends StatelessWidget {
  const SummaryElement(this.data, {super.key});

  final Map<String, Object> data;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['question'] as String,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(
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
    );
  }
}
