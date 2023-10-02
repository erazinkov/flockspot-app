import 'dart:convert';

import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/meal.dart';
import 'package:first_app/screens/categories.dart';
import 'package:first_app/screens/filters.dart';
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
      await http.get(Uri.parse('http://localhost:3000/api/users/1'));

  if (response.statusCode == 200) {
    print(response);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
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

class _TabsScreen extends State<TabsScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
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

  @override
  Widget build(BuildContext context) {
    final availableUsers = dummyUsers.where((user) {
      if (_selectedFilters[Filter.photo]! && user.photo == '') {
        return false;
      }
      return true;
    }).toList();

    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteState,
      availableMeals: availableMeals,
    );
    var activaPageTitle = 'Categories';
    if (_selectedPageIndex == 2) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteState,
      );
      activaPageTitle = 'Your Favorites';
    }

    if (_selectedPageIndex == 1) {
      activePage = UsersScreen(users: availableUsers);
      // activePage = FutureBuilder<User>(
      //   future: futureUser,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return Text((snapshot.data!.id).toString());
      //     } else if (snapshot.hasError) {
      //       return Text('${snapshot.error}');
      //     }
      //     return const CircularProgressIndicator();
      //   },
      // );
      activaPageTitle = 'Users';
    }

    if (_selectedPageIndex == 0) {
      activePage = HomeScreen();
      activaPageTitle = 'Home';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activaPageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.set_meal),
          //   label: 'Categories',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.star),
          //   label: 'Favorites',
          // ),
        ],
      ),
    );
  }
}
