import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PantryController extends GetxController {
  final listGroupsIngredients = <GroupIngredientsModel>[].obs;
  List<IngredientModel> _listIngredients = [];
  final repository = IngredientRepository();

  @override
  void onInit() {
    inicialize();
    super.onInit();
  }

  Future<void> inicialize() async {
    await Future.wait([_getIngredients(), _getGroupsIngredients()]);
    _aggregateIngredients();
  }

  Future<void> _getGroupsIngredients() async {
    try {
      listGroupsIngredients.assignAll(await repository.getGroups());
    } on DioError {
      print("Erro ao carregar groups");
    }
  }

  Future<void> _getIngredients() async {
    try {
      _listIngredients = await repository.getIngredients();
    } on DioError {
      print("Erro ao carregar ingredientes");
    }
  }

  void _aggregateIngredients() {
    List<GroupIngredientsModel> ingredients = [...listGroupsIngredients];
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

  void changeIngredient(IngredientModel ingredient) {
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
          .pantry = ingredient.pantry;
    }
  }
}
