import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:flutter/material.dart';

class FilterRecipeModel {
  final id =  DateTime.now().millisecondsSinceEpoch;
  final TypeFilters type;
  final dynamic value;

  FilterRecipeModel({required this.type, required this.value});

  Widget widget({Color? color}){
    if(type == TypeFilters.avaliation){
      return Row(mainAxisSize: MainAxisSize.min,
        children: Stars.filter(quantity: value+1, color: color));
    }
    if(type == TypeFilters.difficulty){
      final Difficulty difficulty = value;
      return Text(difficulty.name, style: TextStyle(color: color));
    }
    final IngredientModel ingredient = value;
    return Text(ingredient.name, style: TextStyle(color: color));
  }
}

enum TypeFilters {avaliation, difficulty, ingredient}
