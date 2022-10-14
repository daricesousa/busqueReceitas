import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';

class ShoppingListModel {
  IngredientModel ingredient;
  RecipeModel? recipe;

  ShoppingListModel({
    required this.ingredient,
    this.recipe,
  });
}
