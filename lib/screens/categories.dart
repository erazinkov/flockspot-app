import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/category.dart';
import 'package:first_app/screens/meals.dart';
import 'package:first_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
                onToggleFavorite: onToggleFavorite,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        ...availableCategories.map(
          (category) {
            return CategoryGridItem(
              category: category,
              onSelectCategory: () => _selectCategory(context, category),
            );
          },
        )
        // for (final category in availableCategories)
        //   CategoryGridItem(category: category),
      ],
    );
  }
}
