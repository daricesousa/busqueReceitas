import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/app_filter.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final _listRecipes = <RecipeModel>[].obs;
  final _repository = RecipeRepository();
  final visibleRefrash = false.obs; 
  final user = Get.find<SplashController>().user;
  final havePatry = Get.find<SplashController>().havePatry;
  final TextEditingController searchController = TextEditingController();
  final search = ''.obs;
  List<FilterRecipeModel> listFilters = [];

  List<RecipeModel> get listRecipes {
    return _listRecipes.where((e) {
      return AppFilter.filter(filters: listFilters, recipe: e, word: search.value);
    }).toList();
  }

  @override
  void onInit() {
    getRecipes();
    super.onInit();
  }

  Future<void> getRecipes() async {
    try {
      visibleRefrash.value = true;
      _listRecipes.assignAll(await _repository.getRecipes());
      visibleRefrash.value = false;
      sortRecipes();
    } catch (e) {
      visibleRefrash.value = false;
      print(e);
      print("erro ao carregar receitas");
    }
  }

  void goPageRecipe(RecipeModel recipe) {
    Get.focusScope?.unfocus();
    Get.toNamed('/recipe', arguments: recipe);
  }

  void logoutUser() {
    Get.back();
    Get.find<SplashController>().user.value = null;
    GetStorage().remove('user');
    Get.find<Dio>().options.headers = {};
    AppSnackBar.success(message: "Usuário deslogado");
  }

  int missedIngredients(List<RecipeIngredientModel> listIngredients) {
    return listIngredients.fold<int>(
        0, (value, e) => havePatry(e.ingredientId) ? value : value + 1);
  }

  void sortRecipes() {
    _listRecipes.sort((RecipeModel a, RecipeModel b) {
      final missedA = missedIngredients(a.listIngredients);
      final missedB = missedIngredients(b.listIngredients);
      if (missedA == missedB) {
        return a.avaliation.ratingAverage > b.avaliation.ratingAverage ? 0 : 1;
      }
      return missedA < missedB ? 0 : 1;
    });
  }


  void clearFilters(){
    searchController.clear();
    listFilters.clear();
    search.value = '';
    Get.focusScope?.unfocus();

  }
}
