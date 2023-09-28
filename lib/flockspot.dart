import 'package:first_app/widgets/user_info.dart';
import 'package:flutter/material.dart';

class FlockSpot extends StatefulWidget {
  @override
  State<FlockSpot> createState() {
    return _FlockSpot();
  }
}

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class _FlockSpot extends State<FlockSpot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
      ),
      home: Scaffold(body: UserInfo()),
      themeMode: ThemeMode.dark,
    );
  }
}
