import 'package:flutter/material.dart';

class Vibe extends StatelessWidget {
  const Vibe({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: StadiumBorder(),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ));
  }
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.all(4),
  //     child: Container(
  //       padding: EdgeInsets.all(8),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: Text(text),
  //     ),
  //   );
  // }
}
