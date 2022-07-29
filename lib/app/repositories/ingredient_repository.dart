import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/ingredient_model.dart';

class IngredientRepository {
  final _api = Get.find<Dio>();

  Future<List<IngredientModel>> getIngredients() async {
    final res = await _api.get("/ingredients");
    final data = res.data["data"]["ingredients"] as List;
    return data.map<IngredientModel>((e) => IngredientModel.fromMap(e)).toList();
  }


  Future<List<GroupIngredientsModel>> getGroups() async {
    final res = await _api.get("/groups");
    final data = res.data["data"]["groups"] as List;
    return data.map<GroupIngredientsModel>((e) => GroupIngredientsModel.fromMap(e)).toList();
  }

}
