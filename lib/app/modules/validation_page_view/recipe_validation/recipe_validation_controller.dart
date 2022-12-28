import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/recipe/decimal.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_layout/validation_layout_controller.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_recipes/validation_recipes_controller.dart';
import 'package:get/get.dart';

class RecipeValidationController extends GetxController {
  RecipeModel recipe;
  final pictureError = false.obs;
  final findIngredient = Get.find<SplashController>().findIngredient;
  final _listIngredientsNotValidate =
      Get.find<ValidationLayoutController>().listIngredients;
  final validateRecipe = Get.find<ValidationRecipesController>().validateRecipe;

  RecipeValidationController({required this.recipe});

   String personalizeQuantity(double quantity){
    int inteiro = Decimal.inteiro(quantity);
    int decimal = Decimal.decimal(quantity);
    String quantityString = '';
    if(inteiro != 0){
      quantityString = inteiro.toString();
    }
    if(decimal != 0){
      if(quantityString!= ''){
        quantityString+= ' ';
      }
      quantityString += Decimal.forFraction(decimal);
    }
    return quantityString;
  }

  bool validate(int ingredientId){
    final index = _listIngredientsNotValidate.indexWhere((e) => e.id == ingredientId);
    if(index>=0) return false;
    return true;
  }

}