import 'package:first_app/widgets/user_info/photos_list.dart';
import 'package:first_app/widgets/user_info/vibes_list.dart';
import 'package:flutter/material.dart';

import 'package:first_app/data/dummy.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});
  @override
  State<UserInfo> createState() {
    return _UserInfo();
  }
}

class _UserInfo extends State<UserInfo> {
  var activeIndex = 0;
  void selectPhoto(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = dummy;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            dummy.photos[activeIndex],
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PhotosList(
              photos: data.photos,
              selectPhoto: selectPhoto,
            ),
            Text(
              '${data.firstName} ${data.lastName}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
            ),
            VibesList(vibes: data.vibes)
          ],
        ),
      ),
    );
  }
}
