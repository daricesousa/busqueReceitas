import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/shopping_list/shopping_list/shopping_list_controller.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class AddShoppingListController extends GetxController {
  final _listIngredients = Get.find<SplashController>().listIngredients;
  final _shoppingList = Get.find<ShoppingListController>().shoppingList;
  havePantry(ingredientId) =>
      Get.find<SplashController>().havePantry(ingredientId);
  final search = ''.obs;

  RxList<IngredientModel> get listNotShopping {
    final list = <IngredientModel>[].obs;
    for (final ingredient in _listIngredients) {
      final index =
          _shoppingList.indexWhere((e) => e.ingredient.id == ingredient.id);
      if (index == -1) {
        list.add(ingredient);
      }
    }
    final ingredients = list
        .where((e) => e.name.toLowerCase().contains(search.value.toLowerCase()))
        .toList();
    ingredients.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    list.assignAll(ingredients);
    return list;
  }


  void addShopping(IngredientModel ingredient){
    Get.back(result: ingredient);
  }
}
