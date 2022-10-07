import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class FilterRecipeModel {
  final id =  DateTime.now().millisecondsSinceEpoch;
  final TypeFilters type;
  final Widget title;
  final dynamic value;
  final word = '';
  final avaliation = -1;
  final difficulty = Difficulty.easy;
  List<IngredientModel> ingredient = [];

  FilterRecipeModel({required this.type, required this.title, required this.value});
}

enum TypeFilters { avaliation, difficulty, ingredient }
