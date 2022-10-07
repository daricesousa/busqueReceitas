import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';

class AppFilter {
  AppFilter._();

  static bool filter(
      {required List<FilterRecipeModel> filters,
      required RecipeModel recipe,
      required String word}) {
    if (word != '' &&
        !recipe.title.toLowerCase().contains(word.toLowerCase())) {
      return false;
    }
    int difficulty = 0;
    for (FilterRecipeModel filter in filters) {
      switch (filter.type) {
        case TypeFilters.avaliation:
          if (!_filterAvaliation(recipe, filter.value)) {
            return false;
          }
          break;
        case TypeFilters.difficulty:
          if (difficulty == 0) {
            difficulty = -1;
          }
          if (_filterDifficulty(recipe, filter.value)) {
            difficulty = 1;
          }
          break;
        case TypeFilters.ingredient:
          if (!_filterIngredient(recipe, filter.value)) {
            return false;
          }
          break;
      }
    }
    if(difficulty == -1){
      return false;
    }
    return true;
  }

  static bool _filterDifficulty(RecipeModel recipe, Difficulty difficulty) {
    if (recipe.difficulty == difficulty) {
      return true;
    }
    return false;
  }

  static bool _filterAvaliation(RecipeModel recipe, int rating) {
    if (recipe.avaliation.ratingAverage >= rating) {
      return true;
    }
    return false;
  }

  static bool _filterIngredient(
    RecipeModel recipe,
    IngredientModel ingredientFind,
  ) {
    bool have = false;
    for (final ingredient in recipe.listIngredients) {
      if (ingredient.ingredientId == ingredientFind.id) {
        have = true;
      }
    }
    return have;
  }
}
