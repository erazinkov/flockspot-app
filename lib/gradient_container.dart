import 'package:flockspot_app/styled_text.dart';
import 'package:flutter/material.dart';

const startAligment = Alignment.topLeft;
const endAligment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Color.fromARGB(255, 0, 38, 68),
          ],
        ),
      ),
      child: const Center(
        child: StyledText('Hello World!!!'),
      ),
    );
  }
}
