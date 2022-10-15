import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/models/shopping_list_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class ShoppingListController extends GetxController {
  final _shoppingList = <ShoppingListModel>[].obs;
  final _shoppingListUser = Get.find<SplashController>().shoppingListUser;
  final _listDoLater = Get.find<SplashController>().listDoLater;
  havePantry(ingredientId) =>
      Get.find<SplashController>().havePantry(ingredientId);
  _findIngredient(ingredientId) =>
      Get.find<SplashController>().findIngredient(ingredientId);
  _saveShoppingList() => Get.find<SplashController>().saveShoppingList();
  final search = ''.obs;

  @override
  void onInit() {
    ever(_listDoLater, (v) => _shoppingList.assignAll([]));
    super.onInit();
  }

  List<ShoppingListModel> get shoppingList {
    _getItensInlistDoLater();
    _getItensInListUser();
    List<ShoppingListModel> list = [..._shoppingList];
    list.sort((a, b) {
      return a.ingredient.name
          .toLowerCase()
          .compareTo(b.ingredient.name.toLowerCase());
    });
    list = list
        .where((e) => e.ingredient.name.contains(search.value.toLowerCase()))
        .toList();
    return list;
  }

  void _getItensInlistDoLater() {
    for (final recipe in _listDoLater) {
      final ingredientsId = _missedIngredients(recipe);
      for (final ingredientId in ingredientsId) {
        _addShoppingList(ingredientId: ingredientId, recipe: recipe);
      }
    }
  }

  void _getItensInListUser() {
    for (final ingredientId in _shoppingListUser) {
      _addShoppingList(ingredientId: ingredientId);
    }
  }

  void removeShoppingListUser(ingredientId) {
    _shoppingListUser.removeWhere((e) => e == ingredientId);
    _shoppingList.removeWhere((e) => e.ingredient.id == ingredientId);
    _saveShoppingList();
  }


  List<int> _missedIngredients(RecipeModel recipe) {
    List<int> list = [];
    for (final ingredient in recipe.listIngredients) {
      if (!havePantry(ingredient.ingredientId)) {
        list.add(ingredient.ingredientId);
      }
    }
    return list;
  }

  bool _searchInShoppingList(int ingredientId) {
    final index =
        _shoppingList.indexWhere((e) => e.ingredient.id == ingredientId);
    if (index == -1) {
      return false;
    }
    return true;
  }

  void addPantry(ShoppingListModel item) {
    if (!havePantry(item.ingredient.id)) {
      Get.find<SplashController>()
          .ingredientPantry(ingredientId: item.ingredient.id);
    }
    if (item.recipe == null) {
      removeShoppingListUser(item.ingredient.id);
    }
    else{
    _shoppingList.removeWhere((e) => e == item);
    }
    AppSnackBar.success(
        message: "${item.ingredient.name} adicionado à despensa");
  }

  void _addShoppingList({required int ingredientId, RecipeModel? recipe}) {
    if (!_searchInShoppingList(ingredientId)) {
      final ingredient = _findIngredient(ingredientId);
      final itemShopping =
          ShoppingListModel(ingredient: ingredient, recipe: recipe);
      _shoppingList.add(itemShopping);
    }
  }

  void addShopping() async {
    final ingredient = await Get.toNamed('/add_shopping');
    _shoppingListUser.add(ingredient.id);
    _saveShoppingList();
    _shoppingList.assignAll([]);
  }
}
