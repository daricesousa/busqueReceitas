import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';

class AppFilter {
  AppFilter._();

  static bool filter(
      {required List<FilterRecipeModel> filters, required RecipeModel recipe}) {
    for (FilterRecipeModel filter in filters) {
      switch (filter.type) {
        case TypeFilters.word:
          return _filterWord(recipe, filter.value);
        case TypeFilters.avaliation:
          return _filterAvaliation(recipe, filter.value);
        case TypeFilters.difficulty:
          return _filterDifficulty(recipe, filter.value);
        case TypeFilters.ingredient:
          return _filterIngredient(recipe, filter.value);
      }
    }

    return true;
  }

  static bool _filterWord(RecipeModel recipe, String word) {
    if (recipe.title.toLowerCase().contains(word.toLowerCase())) {
      return true;
    }
    return false;
  }

  static bool _filterDifficulty(RecipeModel recipe, Difficulty difficulty) {
    if (recipe.difficulty == difficulty) {
      return true;
    }
    return false;
  }

  static bool _filterAvaliation(RecipeModel recipe, int rating) {
    if (recipe.rating >= rating) {
      return true;
    }
    return false;
  }

  static bool _filterIngredient(
      RecipeModel recipe, List<IngredientModel> listIngredientsFind) {
    for (IngredientModel ingredientFind in listIngredientsFind) {
      bool have = false;
      for (final ingredient in recipe.listIngredients) {
        if (ingredient.ingredientId == ingredientFind.id) {
          have = true;
        }
      }
      if (have == false) {
        return false;
      }
    }
    return true;
  }
}
