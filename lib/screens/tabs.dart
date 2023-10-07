import 'dart:convert';

import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/meal.dart';
import 'package:first_app/screens/categories.dart';
import 'package:first_app/screens/filters.dart';
import 'package:first_app/screens/flocks.dart';
import 'package:first_app/screens/home.dart';
import 'package:first_app/screens/meals.dart';
import 'package:first_app/screens/users.dart';
import 'package:first_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
  Filter.photo: false,
};

Future<User> fetchUser() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:3000/api/users/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

// List<User> users = [];

Future fetchUsers() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/users'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List results = jsonDecode(response.body) as List;
    final users = results.map((e) => User.fromJson(e)).toList();
    return users;
    // return List<User>.from(v);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

var availableUsers = [...dummyUsers];

class _TabsScreen extends State<TabsScreen> {
  late Future<User> futureUser;
  late Future futureUsers;
  @override
  void initState() {
    super.initState();
    // futureUser = fetchUser();
    // futureUsers = fetchUsers();
  }

  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _toggleMealFavoriteState(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite.');
    }
  }

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

  void _removeFlock(User user) {
    final flockIndex = availableUsers.indexOf(user);
    setState(() {
      availableUsers.remove(user);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Flock deleted.'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              availableUsers.insert(flockIndex, user);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var activaPageTitle = 'Home';
    Widget activePage = HomeScreen();

    switch (_selectedPageIndex) {
      case 0:
        activePage = HomeScreen();
        activaPageTitle = 'Home'.toUpperCase();
      case 1:
        activePage = FlocksScreen(
          users: availableUsers,
          onRemove: (user) {
            _removeFlock(user);
          },
        );
        activaPageTitle = 'your flocks'.toUpperCase();
      case 2:
        activePage = HomeScreen();
        activaPageTitle = 'Chat';
      case 3:
        activePage = HomeScreen();
        activaPageTitle = 'User';
      default:
        activePage = HomeScreen();
        activaPageTitle = 'Home'.toUpperCase();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activaPageTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const ImageIcon(
                size: 32,
                color: Colors.white,
                AssetImage('assets/icons/settings.png'),
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
