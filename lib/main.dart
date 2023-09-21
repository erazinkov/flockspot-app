import 'package:flockspot_app/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(Colors.purple, Color.fromARGB(255, 71, 10, 83)),
      ),
    ),
  );
}
