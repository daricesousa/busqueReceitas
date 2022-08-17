import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class AddIngredientsController extends GetxController {
  final listIngredients = <IngredientModel>[].obs;
  final SplashController splashController;

  AddIngredientsController({required this.splashController});

  @override
  void onInit() {
    getIngredients();
    sortIngredients();
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

  void sortIngredients() {
    listIngredients.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }

  void changeIngredient(int index) {
    listIngredients[index].pantry = !listIngredients[index].pantry;
    listIngredients[index] = listIngredients[index];
    splashController.changeIngredient(ingredientId: listIngredients[index].id);
  }

  // void search(String word) {
  //  if (word.length < 3) {
  //    listIngredients.assignAll(listIngredientsMain);
  //  } else {
  //    var itens = listIngredients.where((IngredientModel ingredient) =>
  //        ingredient.name.toUpperCase().contains(word.toUpperCase()));
  //    listIngredients.assignAll(itens.toList());
  //  }

}
