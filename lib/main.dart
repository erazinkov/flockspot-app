import 'package:first_app/screens/tabs.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.black,
  primary: Colors.black,
  onPrimary: const Color.fromRGBO(255, 255, 255, 0.5),
  onPrimaryContainer: Colors.white,
  onSecondary: Colors.white,
  onSecondaryContainer: Colors.white,
  surface: Colors.black,
  onSurface: Colors.amber,
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: kColorScheme.primary,
        appBarTheme: const AppBarTheme().copyWith(
          titleTextStyle: const TextStyle().copyWith(
            color: kColorScheme.onPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: true,
          backgroundColor: kColorScheme.primary,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: kColorScheme.primary,
          selectedItemColor: kColorScheme.onPrimaryContainer,
          unselectedItemColor: kColorScheme.onPrimary,
        ),
      ),
      home: const TabsScreen(),
    );
  }
}
