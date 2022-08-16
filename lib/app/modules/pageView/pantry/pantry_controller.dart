import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PantryController extends GetxController {
  final listGroupsIngredients = <GroupIngredientsModel>[].obs;
  List<IngredientModel> _listIngredients = [];
  final repository = IngredientRepository();

  @override
  void onInit() async {
    try {
      await _getIngredientsNet();
      _aggregateIngredients();
      _saveIngredients();
    } catch (e) {
      print("Erro ao obter ingredientes da internet");
      _loadIngredients();
    }
    super.onInit();
  }

  Future<void> _getIngredientsNet() async {
    await Future.wait([_getIngredients(), _getGroupsIngredients()]);
  }

  Future<void> _getGroupsIngredients() async {
    listGroupsIngredients.assignAll(await repository.getGroups());
    throw ("erro");
  }

  Future<void> _getIngredients() async {
    _listIngredients = await repository.getIngredients();
  }

  void _aggregateIngredients() {
    List<GroupIngredientsModel> ingredients = [...listGroupsIngredients];
    print(_listIngredients);
    for (var ingrediente in _listIngredients) {
      final groupId = ingrediente.groupId;
      final index = ingredients.indexWhere(
        (GroupIngredientsModel group) => group.id == groupId,
      );
      if (index >= 0) {
        ingredients[index].listIngredients.add(ingrediente);
      }
    }
    listGroupsIngredients.assignAll(ingredients);
  }

  Future<void> _loadIngredients() async {
    print("carregando");
    final storage = GetStorage();
    final data = await storage.read('groups') ?? [];
    List<GroupIngredientsModel> newList = [];
    newList = data.map<GroupIngredientsModel>((g) {
      return GroupIngredientsModel.fromMap(g);
    }).toList();
    listGroupsIngredients.assignAll(newList);
  }

  void _saveIngredients() {
    print("salvando");
    final storage = GetStorage();
    final listJson = listGroupsIngredients.map((g) {
      return g.toMap();
    }).toList();
    storage.write('groups', listJson);
   
  }

  void changeIngredient(IngredientModel ingredient, bool pantry) {
    final indexGroup = listGroupsIngredients.indexWhere(
      (GroupIngredientsModel group) => group.id == ingredient.groupId,
    );
    if (indexGroup >= 0) {
      GroupIngredientsModel group = listGroupsIngredients[indexGroup];
      final indexIngredient = group.listIngredients.indexWhere(
        (IngredientModel ingredientFind) => ingredientFind.id == ingredient.id,
      );
      listGroupsIngredients[indexGroup]
          .listIngredients[indexIngredient]
          .pantry = pantry;
      listGroupsIngredients[indexGroup] = listGroupsIngredients[indexGroup];
    }
  }
}
