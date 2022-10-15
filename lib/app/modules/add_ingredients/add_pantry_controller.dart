import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class AddPantryController extends GetxController {
  final _listIngredients = Get.find<SplashController>().listIngredients;
  final search = ''.obs;
  havePantry(id) => Get.find<SplashController>().havePatry(id);

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

  @override
  void onInit() {
    super.onInit();
  }

  void changeIngredient(int ingredientId) {
    final index = _listIngredients.indexWhere((e) => e.id == ingredientId);
    _listIngredients[index] = _listIngredients[index];
    Get.find<SplashController>().changeIngredient(ingredientId: _listIngredients[index].id);
  }
}
