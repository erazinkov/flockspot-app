import 'package:first_app/widgets/user/user.dart';
import 'package:flutter/material.dart';

class FlockSpot extends StatefulWidget {
  @override
  State<FlockSpot> createState() {
    return _FlockSpot();
  }
}

class _FlockSpot extends State<FlockSpot> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: UserInfo()),
    );
  }
}
