import 'package:flutter/material.dart';

import 'package:deliMeals/dummy_data.dart';

import 'package:deliMeals/models/meal.dart';
import 'package:deliMeals/screens/category_meals_screen.dart';
import 'package:deliMeals/screens/filters_sreen.dart';
import 'package:deliMeals/screens/meal_details_screen.dart';
import 'package:deliMeals/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toogleFavorite(String meailId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == meailId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == meailId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.pinkAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline2: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        '/meal-details': (ctx) =>
            MealDetailScreen(_toogleFavorite, _isMealFavorite),
        '/filters': (ctx) => FiltersScreen(_setFilters, _filters),
      },
    );
  }
}
