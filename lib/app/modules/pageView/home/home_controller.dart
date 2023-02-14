import 'package:busque_receitas/app/core/widgets/app_avaliation.dart';
import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/app_filter.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final _listRecipes = <RecipeModel>[].obs;
  final _repository = RecipeRepository();
  final visibleRefrash = false.obs;
  final user = Get.find<SplashController>().user;
  final TextEditingController searchController = TextEditingController();
  final search = ''.obs;
  List<FilterRecipeModel> listFilters = [];
  final _listFiltersObs = <FilterRecipeModel>[].obs;

  @override
  void onInit() async {
    
    await Future.wait([
      getRecipes(),
      loadIngredients(),
    ]);
    super.onInit();
  }

  @override
  void onReady() {
    _loadDateInitial();
    super.onReady();
  }

  void _loadDateInitial() {
    final dateString =
        (GetStorage().read('date_initial') ?? "");
      final date = DateTime.tryParse(dateString) ?? DateTime.now();
    final now = DateTime.now();
    final dif = now.difference(date);
    if (dif.inMinutes > 20) {
      Get.dialog(const AppAvaliation());
    } else {
      GetStorage().write('date_initial', date.toString());
    }
  }

  Future<void> loadIngredients() async {
    await Get.find<SplashController>().getIngredients();
  }

  missedIngredientsQuant(listIngredients) =>
      Get.find<SplashController>().missedIngredientsQuant(listIngredients);

  List<RecipeModel> get listRecipes {
    return _listRecipes.where((e) {
      return AppFilter.filter(
          filters: _listFiltersObs, recipe: e, word: search.value);
    }).toList();
  }

  void filter() {
    _listFiltersObs.assignAll(listFilters);
  }

  Future<void> getRecipes() async {
    if (visibleRefrash.value == false) {
      try {
        visibleRefrash.value = true;
        _listRecipes.assignAll(await _repository.getRecipes());
        sortRecipes();
      } on DioError catch (e) {
        try {
          AppSnackBar.error(message: e.response?.data["message"]);
        } catch (e) {
          AppSnackBar.error(message: "Erro de conexão");
        }
      } finally {
        visibleRefrash.value = false;
      }
    }
  }

  void goPageRecipe(RecipeModel recipe) {
    Get.focusScope?.unfocus();
    Get.toNamed('/recipe', arguments: recipe);
  }

  void sortRecipes() {
    _listRecipes.sort((RecipeModel a, RecipeModel b) {
      final missedA = missedIngredientsQuant(a.listIngredients);
      final missedB = missedIngredientsQuant(b.listIngredients);
      if (missedA == missedB) {
        return a.avaliation.ratingAverage > b.avaliation.ratingAverage ? 0 : 1;
      }
      return missedA < missedB ? 0 : 1;
    });
  }

  void removeFilter(int id) {
    listFilters.removeWhere((e) => e.id == id);
    filter();
  }

  void clearFilters() {
    searchController.clear();
    listFilters.clear();
    search.value = '';
    Get.focusScope?.unfocus();
    filter();
  }
}
