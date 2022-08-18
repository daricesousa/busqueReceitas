import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class AddIngredientsController extends GetxController {
  final _listIngredients = <IngredientModel>[].obs;
  final SplashController splashController;
  final search = ''.obs;

  AddIngredientsController({required this.splashController});

  List<IngredientModel> get listIngredients {
    return _listIngredients
        .where((e) => e.name.toLowerCase().contains(search.value.toLowerCase()))
        .toList();
  }

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
      } else {
        ingredient.pantry = false;
      }
      elements.add(ingredient);
    }
    _listIngredients.assignAll(elements);
  }

  void sortIngredients() {
    _listIngredients.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
  }

  void changeIngredient(int ingredientId) {
    final index = _listIngredients.indexWhere((e) => e.id == ingredientId);
    _listIngredients[index].pantry = !_listIngredients[index].pantry;
    _listIngredients[index] = _listIngredients[index];
    splashController.changeIngredient(ingredientId: _listIngredients[index].id);
  }
}
