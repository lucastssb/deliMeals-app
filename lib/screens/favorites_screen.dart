import 'package:flutter/material.dart';

import 'package:deliMeals/widgets/meal_item.dart';

import 'package:deliMeals/models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/empty.png'),
                Text(
                  'You have no favorites yet...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                  id: favoriteMeals[index].id,
                  title: favoriteMeals[index].title,
                  imageUrl: favoriteMeals[index].imageUrl,
                  duration: favoriteMeals[index].duration,
                  complexity: favoriteMeals[index].complexity,
                  affordability: favoriteMeals[index].affordability);
            },
            itemCount: favoriteMeals.length,
          );
  }
}
