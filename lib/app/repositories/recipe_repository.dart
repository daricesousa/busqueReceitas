import 'dart:convert';

import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';

class RecipeRepository {
  final _api = Get.find<Dio>();

  Future<List<RecipeModel>> getRecipes({String? show}) async {
    final res = await _api.get('/recipes', queryParameters: {"show": show});
    final data = res.data["data"]["recipes"] as List;
    return data.map<RecipeModel>((e) => RecipeModel.fromMap(e)).toList();
  }

  Future<Map> newAvaliation({
    required int recipeId,
    required int rating,
  }) async {
    final res = await _api.put('/recipe/new-avaliation', data: {
      "rating": rating,
      "recipe": recipeId,
    });
    return res.data;
  }

  Future<Map> createRecipe({
    required String title,
    required List<Map<String, dynamic>> ingredients,
    required List<String> method,
    required String picturePath,
    required int difficulty,
    required int timeSetup,
    required int timeCooking,
    bool pictureIlustration = false,
  }) async {
    var formIngredients = jsonEncode({"list": ingredients});
    var formMethod = jsonEncode({"list": method});
    final data = FormData.fromMap({
      "title": title,
      "ingredients": formIngredients,
      "method": formMethod,
      "picture":
          await MultipartFile.fromFile(picturePath, filename: 'busqueReceitas'),
      "difficulty": difficulty,
      "picture_ilustration": pictureIlustration,
      "time_setup": timeSetup,
      "time_cooking": timeCooking,
    });
    final res = await _api.post('/recipe/create', data: data);
    return res.data;
  }

  Future<Map> validateRecipe({
    required int id,
    required bool accept,
  }) async{
    final res = await _api.put("/validate/recipe", data: {"id": id, "accept": accept});
    return res.data;
  }
}
