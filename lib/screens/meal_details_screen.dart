import 'package:flutter/material.dart';

import 'package:deliMeals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      width: 300,
      height: 200,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: constraints.maxHeight * 0.25,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('${selectedMeal.title}'),
                  background: Hero(
                    tag: selectedMeal.id,
                    child: Image.network(
                      selectedMeal.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Ingredients', style: TextStyle(fontSize: 30)),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 15.0,
                          height: 15.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            selectedMeal.ingredients[index],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: selectedMeal.ingredients.length),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Steps', style: TextStyle(fontSize: 30)),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ListTile(
                      title: Text(selectedMeal.steps[index]),
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                    ),
                  );
                }, childCount: selectedMeal.steps.length),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
