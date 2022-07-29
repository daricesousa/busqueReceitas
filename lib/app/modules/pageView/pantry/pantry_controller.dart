import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PantryController extends GetxController {
  final listGroupsIngredients = <GroupIngredientsModel>[].obs;
  List<IngredientModel> listIngredients = [];
  final repository = IngredientRepository();

  @override
  void onInit() {
    inicialize();
    super.onInit();
  }

  Future<void> inicialize() async {
    await Future.wait([getIngredients(), getGroupsIngredients()]);
    aggregateIngredients();
  }

  Future<void> getGroupsIngredients() async {
    try {
      listGroupsIngredients.assignAll(await repository.getGroups());
    } on DioError catch (e) {
      print("Erro ao carregar groups");
    }
  }

  Future<void> getIngredients() async {
    try {
      listIngredients = await repository.getIngredients();
    } on DioError catch (e) {
      print(e.response?.data["message"] ?? "Erro ao carregar ingredientes");
    }
  }

  void aggregateIngredients() {
    List<GroupIngredientsModel> ingredients = [...listGroupsIngredients];
    for (var ingrediente in listIngredients) {
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
}
