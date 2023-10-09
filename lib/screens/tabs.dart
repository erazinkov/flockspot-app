import 'dart:convert';

import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/meal.dart';
import 'package:first_app/screens/categories.dart';
import 'package:first_app/screens/filters.dart';
import 'package:first_app/screens/flocks.dart';
import 'package:first_app/screens/home.dart';
import 'package:first_app/screens/meals.dart';
import 'package:first_app/screens/settings.dart';
import 'package:first_app/screens/users.dart';
import 'package:first_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

const kInitialSettings = {
  Setting.one: false,
  Setting.two: false,
  Setting.three: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 1;

  Map<Setting, bool> _selectedSettings = kInitialSettings;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'settings') {
      final result = await Navigator.of(context).push<Map<Setting, bool>>(
        MaterialPageRoute(
          builder: (ctx) => SettingsScreen(
            currentSettings: _selectedSettings,
          ),
        ),
      );
      setState(() {
        _selectedSettings = result ?? kInitialSettings;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var activaPageTitle = 'home';
    Widget activePage = const HomeScreen();

    switch (_selectedPageIndex) {
      case 0:
        activePage = const HomeScreen();
        activaPageTitle = 'home'.toUpperCase();
      case 1:
        activePage = const FlocksScreen();
        activaPageTitle = 'your flocks'.toUpperCase();
      case 2:
        activePage = const HomeScreen();
        activaPageTitle = 'chat'.toUpperCase();
      default:
        activePage = const HomeScreen();
        activaPageTitle = 'Home'.toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activaPageTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: ImageIcon(
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                const AssetImage('assets/icons/settings.png'),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/home.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/flocks.png'),
            ),
            label: 'Your Flocks',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/chat.png'),
            ),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
