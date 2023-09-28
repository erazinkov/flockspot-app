import 'package:first_app/widgets/user/photos.dart';
import 'package:flutter/material.dart';

const List<String> data = [
  '111',
  '222',
  '333',
  '111',
  '222',
  '333',
];

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});
  @override
  State<UserInfo> createState() {
    return _UserInfo();
  }
}

class _UserInfo extends State<UserInfo> {
  var activeIndex = 0;
  void switchPhoto(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Photos(
              photos: data,
              switchPhoto: switchPhoto,
            ),
            Text('User name and location. Active photo index: $activeIndex'),
            Text('List of vides.'),
          ],
        ),
      ),
    );
  }
}
