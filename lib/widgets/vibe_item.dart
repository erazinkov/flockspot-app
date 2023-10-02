import 'package:first_app/widgets/vibe_item_traits.dart';
import 'package:flutter/material.dart';

class VibeItem extends StatelessWidget {
  const VibeItem({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return VibeItemTrait();
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
