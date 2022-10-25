import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RecipeRepository {
  final _api = Get.find<Dio>();

  Future<List<RecipeModel>> getRecipes() async {
    final res = await _api.get('/recipes');
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
    // required picture,
    required int difficulty,
  })async{
    final res = await _api.post('/recipe/create', data: {
      "title": title,
      "ingredients": {"list": ingredients},
      "method": method,
      "picture": 'picture',
      "difficulty": difficulty,
    });
    return res.data;
  }
}
