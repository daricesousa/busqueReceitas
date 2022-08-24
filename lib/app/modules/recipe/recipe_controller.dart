import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  RecipeModel recipe;
  SplashController splashController;

  RecipeController({required this.recipe, required this.splashController});

  IngredientModel _findIngredient(int id){
    final index = splashController.listIngredients.indexWhere((i) => i.id == id);
    return splashController.listIngredients[index];
  }

  String nameIngredient(int id){
    final ingredient = _findIngredient(id);
    return ingredient.name;
  }



  

}