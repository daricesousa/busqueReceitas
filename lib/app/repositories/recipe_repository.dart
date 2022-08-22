import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RecipeRepository{
  final _api = Get.find<Dio>();

  Future<List<RecipeModel>> getRecipes() async{
    final res = await _api.get('/recipes');
    final data = res.data["data"]["recipes"] as List;
    return data.map<RecipeModel> ((e) => RecipeModel.fromMap(e)).toList();
  }
}