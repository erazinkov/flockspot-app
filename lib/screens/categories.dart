import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your category'),
      ),
      body: GridView(
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
              return CategoryGridItem(category: category);
            },
          )
          // for (final category in availableCategories)
          //   CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
