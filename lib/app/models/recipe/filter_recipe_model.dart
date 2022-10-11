import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class FilterRecipeModel {
  final id =  DateTime.now().millisecondsSinceEpoch;
  final TypeFilters type;
  final Widget title;
  final dynamic value;
  List<IngredientModel> ingredient = [];

  FilterRecipeModel({required this.type, required this.title, required this.value});
}

enum TypeFilters { avaliation, difficulty, ingredient;
  
}
