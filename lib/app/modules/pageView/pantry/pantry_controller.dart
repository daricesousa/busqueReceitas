import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class PantryController extends GetxController {
  SplashController splashController;
  final listIngredients = <IngredientModel>[].obs;
  final visibleRefrash = false.obs;

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
      } else {
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

  Future<void> refrashPage() async {
    try {
      visibleRefrash.value = true;
      await splashController.getIngredients();
      Get.offNamedUntil('/layout', (route) => false);
    } catch (e) {
      visibleRefrash.value = false;
    }
  }

  List<IngredientModel> ingredientsInGroup(GroupIngredientsModel group) {
    final list = splashController.listIngredients
        .where((i) => i.groupId == group.id)
        .toList();
    return list;
  }
}
