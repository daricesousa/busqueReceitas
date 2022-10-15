import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/pageView/pantry/pantry_controller.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class AddPantryController extends GetxController {
  final _listIngredients = Get.find<SplashController>().listIngredients;
  final search = ''.obs;
  havePantry(id) => Get.find<SplashController>().havePantry(id);
 

  AddPantryController();

  List<IngredientModel> get listIngredients {
    final ingredients = _listIngredients
        .where((e) => e.name.toLowerCase().contains(search.value.toLowerCase()))
        .toList();
    ingredients.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return ingredients;
  }


  void changeIngredient(IngredientModel ingredient) {
    Get.find<PantryController>().changeIngredient(ingredient: ingredient);
  }
}
