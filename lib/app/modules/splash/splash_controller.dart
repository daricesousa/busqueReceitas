import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final listIngredients = <IngredientModel>[].obs;
  List<GroupIngredientsModel> listGroups = [];
  final listPantry = <int>[].obs;
  final _repository = IngredientRepository();
  final _storage = GetStorage();

  @override
  void onReady() async {
    try {
      await getIngredientsNet();
      saveIngredients();
      saveGroups();

    } catch (e) {
      print("Erro ao obter ingredientes da internet");
      await _loadIngredientsPhone();
    }
    Get.offNamedUntil('/layout', (route) => false);
    super.onReady();
  }

  Future<void> getIngredientsNet() async {
    await Future.wait(
        [_getIngredients(), _getGroupsIngredients(), _loadPantry()]);
  }

  Future<void> _loadIngredientsPhone() async {
    await Future.wait([_loadIngredients(), _loadGroups()]);
  }

  Future<void> _getGroupsIngredients() async {
    listGroups.assignAll(await _repository.getGroups());
  }

  Future<void> _getIngredients() async {
    listIngredients.assignAll(await _repository.getIngredients());
  }

  void saveIngredients() {
    print("salvando");
    final ingredients = listIngredients.map((i) {
      return i.toMap();
    }).toList();
    _storage.write('ingredients', ingredients);
  }

  void saveGroups() {
    final groups = listGroups.map((g) {
      return g.toMap();
    }).toList();
    _storage.write('groups', groups);
  }

  Future<void> _loadPantry() async {
    try {
      final data = (await _storage.read('pantry') ?? []).cast<int>();
      listPantry.assignAll(data as List<int>);
    } catch (e) {
      print(e);
      print("Erro ao carregar despensa");
    }
  }

  Future<void> _loadIngredients() async {
    final data = await _storage.read('ingredients') ?? [];
    List<IngredientModel> ingredients = [];
    ingredients = data.map<IngredientModel>((i) {
      return IngredientModel.fromMap(i);
    }).toList();
    listIngredients.assignAll(ingredients);
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
    _savePantry();
  }

  void _savePantry() {
    _storage.write('pantry', listPantry);
  }

  bool havePatry(int ingredientId) {
    final findIndex = listPantry.indexWhere((i) => i == ingredientId);
    if (findIndex < 0) {
      return false;
    } else {
      return true;
    }
  }
}
