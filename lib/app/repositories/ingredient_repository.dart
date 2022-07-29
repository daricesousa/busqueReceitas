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
}
