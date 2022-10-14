import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class DoLaterController extends GetxController {
final listDoLater = Get.find<SplashController>().listDoLater;
  missedIngredientsQuant(listIngredients) =>
      Get.find<SplashController>().missedIngredientsQuant(listIngredients);

  void goPageRecipe(RecipeModel recipe) {
    Get.toNamed('/recipe', arguments: recipe);
  }

}