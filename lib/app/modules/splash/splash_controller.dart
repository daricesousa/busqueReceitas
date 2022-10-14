import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/models/user_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final listIngredients = <IngredientModel>[].obs;
  List<GroupIngredientsModel> listGroups = [];
  final listPantry = <int>[].obs;
  List<int> shoppingListUser = [];
  final listFavorites = <RecipeModel>[].obs;
  final listDoLater = <RecipeModel>[].obs;
  final _repositoryIngredient = IngredientRepository();
  final _storage = GetStorage();
  final user = Rxn<UserModel>();

  @override
  void onInit() async {
    _loadUser();
    _loadPantry();
    _loadFavorites();
    _loadDoLater();
    _loadShoppingList();
    await getIngredients();
    Get.offNamedUntil('/layout', (route) => false);
    super.onInit();
  }

  Future<void> getIngredients() async {
    try {
      await Future.wait([_getIngredients(), _getGroupsIngredients()]);
    } catch (e) {
      print("Erro ao carregar ingredientes da internet");
      await Future.wait([_loadIngredients(), _loadGroups()]);
    }
  }

  Future<void> _getGroupsIngredients() async {
    listGroups.assignAll(await _repositoryIngredient.getGroups());
  }

  Future<void> _getIngredients() async {
    listIngredients.assignAll(await _repositoryIngredient.getIngredients());
  }

  void _loadPantry() {
      final data = (_storage.read('pantry') ?? []).cast<int>();
      listPantry.assignAll(data as List<int>);
  } 

  void _loadFavorites() {
      final data = (_storage.read('favorites') ?? []) as List;
      List<RecipeModel> recipes = [];
      recipes = data.map<RecipeModel>((e)=> RecipeModel.fromMap(e)).toList();
      listFavorites.assignAll(recipes);
  } 

  void _loadDoLater() {
      final data = (_storage.read('do_later') ?? []) as List;
      List<RecipeModel> recipes = [];
      recipes = data.map<RecipeModel>((e)=> RecipeModel.fromMap(e)).toList();
      listDoLater.assignAll(recipes);
  } 

  void _loadShoppingList() {
      final data = (_storage.read('shopping_list') ?? []).cast<int>();
      shoppingListUser.assignAll(data as List<int>);
  } 

  Future<void> _loadIngredients() async {
    final data = await _storage.read('ingredients') ?? [];
    List<IngredientModel> ingredients = [];
    ingredients = data.map<IngredientModel>((i) {
      return IngredientModel.fromMap(i);
    }).toList();
    listIngredients.assignAll(ingredients);
  }

  void _loadUser() {
    final user = _storage.read('user');
    if (user != null) {
      this.user.value = UserModel.fromMap(user);
    }
  }

  Future<void> _loadGroups() async {
    final data = await _storage.read('groups') ?? [];
    List<GroupIngredientsModel> groups = [];
    groups = data.map<GroupIngredientsModel>((g) {
      return GroupIngredientsModel.fromMap(g);
    }).toList();
    listGroups.assignAll(groups);
  }

  void changeIngredient({required int ingredientId}) {
    final have = havePatry(ingredientId);
    if (have) {
      listPantry.removeWhere((i) => i == ingredientId);
    } else {
      listPantry.add(ingredientId);
    }
    Get.find<HomeController>().sortRecipes();
    _savePantry();
  }

  void _savePantry() {
    _storage.write('pantry', listPantry);
  }

  void saveFavorite() {
    final data = listFavorites.map((e) => e.toMap()).toList();
    _storage.write('favorites', data);
  }

  void saveDoLater() {
    final data = listDoLater.map((e) => e.toMap()).toList();
    _storage.write('do_later', data);
  }

  bool havePatry(int ingredientId) {
    final findIndex = listPantry.indexWhere((i) => i == ingredientId);
    return findIndex >= 0;
  }

  IngredientModel findIngredient(int id) {
    final index = listIngredients.indexWhere((i) => i.id == id);
    if(index > -1){
      return listIngredients[index];
    }
    return IngredientModel(id: id, name: "", groupId: 1, associates: []);
  }


  int missedIngredientsQuant(List<RecipeIngredientModel> listIngredients) {
    return listIngredients.fold<int>(
        0, (value, e) => havePatry(e.ingredientId) ? value : value + 1);
  }  
}
