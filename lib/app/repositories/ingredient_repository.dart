import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/ingredient_model.dart';

class IngredientRepository {
  final _api = Get.find<Dio>();

  Future<List<IngredientModel>> getIngredients({String? show}) async {
    final res = await _api.get("/ingredients", queryParameters: {"show": show});
    final data = res.data["data"]["ingredients"] as List;
    final ingredients =
        data.map<IngredientModel>((e) => IngredientModel.fromMap(e)).toList();
    _saveIngredients(data);
    return ingredients;
  }

  Future<List<GroupIngredientsModel>> getGroups() async {
    final res = await _api.get("/groups");
    final data = res.data["data"]["groups"] as List;
    final groups = data
        .map<GroupIngredientsModel>((e) => GroupIngredientsModel.fromMap(e))
        .toList();
    await _saveGroups(data);
    return groups;
  }

  Future<void> _saveIngredients(List data) async {
    await GetStorage().write('ingredients', data);
  }

  Future<void> _saveGroups(List data) async {
    await GetStorage().write('groups', data);
  }

  Future<Map> createIngredient({
    required String name,
    required int groupId,
  }) async {
    final res = await _api
        .post("/new-ingredient", data: {"name": name, "group": groupId});
    return res.data;
  }

  Future<Map> validateIngredient({
    required  int id,
    required bool accept,
  })async {
    final res = await _api.put('/validate/ingredient', data: {"id": id, "accept": accept});
    return res.data;
  }

}
