import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class PantryController extends GetxController {
  SplashController splashController;
  final listIngredients = <IngredientModel>[].obs;

  PantryController({required this.splashController});

  @override
  void onInit() async {
    getIngredients();
    super.onInit();
  }

  void getIngredients() {
    List<IngredientModel> elements = [];
    for (IngredientModel ingredient in splashController.listIngredients) {
      if (splashController.havePatry(ingredient.id)) {
        ingredient.pantry = true;
      }
       else{
        ingredient.pantry = false;
      }
      elements.add(ingredient);
    }
    listIngredients.assignAll(elements);
  }

  void changeIngredient({required IngredientModel ingredient}) {
    splashController.changeIngredient(ingredientId: ingredient.id);
    getIngredients();
  }

  bool havePatry(int ingredientId) {
    return splashController.havePatry(ingredientId);
  }
}
