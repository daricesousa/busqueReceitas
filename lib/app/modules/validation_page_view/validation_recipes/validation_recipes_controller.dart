import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_layout/validation_layout_controller.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ValidationRecipesController extends GetxController {
  final loading = false.obs;
  final listRecipes = <RecipeModel>[].obs;
  final _repositoryRecipe = RecipeRepository();
  final _listIngredientsNotValidate =
      Get.find<ValidationLayoutController>().listIngredients;

  @override
  void onInit() async {
    await _getRecipes();
    super.onInit();
  }

  Future<void> _getRecipes() async {
    try {
      loading.value = true;
      listRecipes
          .assignAll(await _repositoryRecipe.getRecipes(show: 'invalid'));
    } on DioError catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }

  Future<void> validateRecipe({
    required RecipeModel recipe,
    required bool accept,
  }) async {
    try {
      Map? data;
      data = await _validateIngredient(recipe.listIngredients);
      data =
          await _repositoryRecipe.validateRecipe(id: recipe.id, accept: accept);
      AppSnackBar.success(message: data["message"]);
      listRecipes.remove(recipe);
    } on DioError catch (e) {
      print(e);
      AppSnackBar.error(message: e.response?.data["message"]);
    }
  }

  void goPageRecipe(RecipeModel recipe) {
    Get.toNamed('/recipe_validation', arguments: recipe);
  }

  Future<Map?> _validateIngredient(
      List<RecipeIngredientModel> ingredientsRecipe) async {
    Map? data;
    final repositoryIngredient = IngredientRepository();
    for (RecipeIngredientModel ingredient in ingredientsRecipe) {
      final index = _listIngredientsNotValidate
          .indexWhere((e) => e.id == ingredient.ingredientId);
      if (index >= 0) {
        data = await repositoryIngredient.validateIngredient(
            id: ingredient.ingredientId, accept: true);
        _listIngredientsNotValidate.removeAt(index);
      }
    }
    return data;
  }
}
