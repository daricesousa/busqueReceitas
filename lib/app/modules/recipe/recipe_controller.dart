import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/recipe/decimal.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RecipeController extends GetxController {
  RecipeModel recipe;
  final user = Get.find<SplashController>().user;
  final findIngredient = Get.find<SplashController>().findIngredient;
  final havePantry = Get.find<SplashController>().havePantry;
  final recipes = Get.find<HomeController>().listRecipes;
  final _repository = RecipeRepository();
  final _listFavorites = Get.find<SplashController>().listFavorites;
  final _listDoLater = Get.find<SplashController>().listDoLater;
  final isFavorite = false.obs;
  final isDoLater = false.obs;
  final pictureError = false.obs;

  RecipeController({required this.recipe});

  @override
  void onInit() {
    isFavorite.value = _searchFavorite();
    isDoLater.value = _searchDoLater();
    super.onInit();
  }


  Future<void> newAvaliation(int star) async {
    try {
      await _repository.newAvaliation(recipeId: recipe.id, rating: star);
      final index = recipes.indexWhere((e) => e.id == recipe.id);
      recipe.avaliation.userRating = star;
      if (index >= 0) {
        recipes[index] = recipe;
      }
      AppSnackBar.success(message: "Avaliação realizada");
    } on DioError catch (e) {
      debugPrint(e.response?.data["message"]);
      AppSnackBar.error(
          message: "Algo deu errado. Verifique sua conexão com a internet");
    }
  }

  bool _searchFavorite() {
    final index = _listFavorites.indexWhere((e) => e.id == recipe.id);
    if (index > -1) {
      return true;
    }
    return false;
  }

  bool _searchDoLater() {
    final index = _listDoLater.indexWhere((e) => e.id == recipe.id);
    if (index > -1) {
      return true;
    }
    return false;
  }

  void changeFavorite() {
    final find = _searchFavorite();
    if (find) {
      _listFavorites.removeWhere((e) => e.id == recipe.id);
    } else {
      _listFavorites.insert(0, recipe);
    }
    isFavorite.value = !isFavorite.value;
    _saveFavorite();
  }

  void changeDoLater() {
    final find = _searchDoLater();
    if (find) {
      _listDoLater.removeWhere((e) => e.id == recipe.id);
    } else {
      _listDoLater.insert(0, recipe);
    }
    isDoLater.value = !isDoLater.value;
    _saveDoLater();
  }

  String personalizeQuantity(double quantity) {
    int inteiro = Decimal.inteiro(quantity);
    int decimal = Decimal.decimal(quantity);
    String quantityString = '';
    if (inteiro != 0) {
      quantityString = inteiro.toString();
    }
    if (decimal != 0) {
      if (quantityString != '') {
        quantityString += ' ';
      }
      quantityString += Decimal.forFraction(decimal);
    }
    return quantityString;
  }

  void _saveFavorite() {
    final data = _listFavorites.map((e) => e.toMap()).toList();
    GetStorage().write('favorites', data);
  }

  void _saveDoLater() {
    final data = _listDoLater.map((e) => e.toMap()).toList();
    GetStorage().write('do_later', data);
  }
}
