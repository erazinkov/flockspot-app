import 'package:flutter/material.dart';
import 'package:first_app/widgets/main_drawer.dart';
import 'package:first_app/screens/home.dart';
import 'package:first_app/screens/flocks.dart';
import 'package:first_app/screens/filters.dart';

const kInitialFilters = {
  Filter.one: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilters = kInitialFilters;

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
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var activaPageTitle = 'flocks';
    Widget activePage = const FlocksScreen();

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
