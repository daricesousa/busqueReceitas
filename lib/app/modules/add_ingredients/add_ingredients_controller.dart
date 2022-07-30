import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/pageView/pantry/pantry_controller.dart';
import 'package:get/get.dart';

class AddIngredientsController extends GetxController {
  final listIngredients = <IngredientModel>[].obs;
  final List<IngredientModel> listIngredientsMain = [];
  final PantryController pantryController;

  AddIngredientsController({required this.pantryController});

  @override
  void onInit() {
    getIngredients();
    sortIngredients();
    listIngredientsMain.assignAll(listIngredients.value);
    super.onInit();
  }

  void getIngredients() {
    for (GroupIngredientsModel group
        in pantryController.listGroupsIngredients) {
      for (IngredientModel ingredient in group.listIngredients) {
        listIngredients.add(ingredient);
      }
    }
  }

  void sortIngredients() {
    listIngredients.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }

  void changeIngredient(int index) {
    listIngredients[index].pantry = !listIngredients[index].pantry;
    listIngredients[index] = listIngredients[index];
    pantryController.changeIngredient(listIngredients[index]);
  }

  void search(String word) {
    if (word.length < 3) {
      listIngredients.assignAll(listIngredientsMain);
    } else {
      var itens = listIngredients.where((IngredientModel ingredient) =>
          ingredient.name.toUpperCase().contains(word.toUpperCase()));
      listIngredients.assignAll(itens.toList());
    }
  }
}
