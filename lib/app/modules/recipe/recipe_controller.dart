import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/recipe/decimal.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  RecipeModel recipe;
  final user = Get.find<SplashController>().user;
  final findIngredient = Get.find<SplashController>().findIngredient;
  final havePatry = Get.find<SplashController>().havePatry;
  final recipes = Get.find<HomeController>().listRecipes;
  final _repository = RecipeRepository();
  final _listFavorites = Get.find<SplashController>().listFavorites;
  final _listDoLater = Get.find<SplashController>().listDoLater;
  final isFavorite = false.obs;
  final isDoLater = false.obs;

  RecipeController({required this.recipe});

  @override
  void onInit(){
    isFavorite.value = _searchFavorite();
    isDoLater.value = _searchDoLater();
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
      print(e.response?.data["message"]);
      AppSnackBar.error(message:
          "Algo deu errado. Verifique sua conexão com a internet");
    }
  }

  bool _searchFavorite(){
    final index = _listFavorites.indexWhere((e) => e.id == recipe.id);
    if (index > -1) {
      return true;
    }
    return false;
  }

    bool _searchDoLater(){
    final index = _listDoLater.indexWhere((e) => e.id == recipe.id);
    if (index > -1) {
      return true;
    }
    return false;
  }

  
  void changeFavorite(){
    final find = _searchFavorite();
    if (find){
     _listFavorites.removeWhere((e) => e.id == recipe.id);
    }
    else{
      _listFavorites.insert(0, recipe);
    }
    isFavorite.value = !isFavorite.value;
    Get.find<SplashController>().saveFavorite();
  }

  void changeDoLater(){
    final find = _searchDoLater();
    if (find){
     _listDoLater.removeWhere((e) => e.id == recipe.id);
    }
    else{
      _listDoLater.insert(0, recipe);
    }
    isDoLater.value = !isDoLater.value;
    Get.find<SplashController>().saveDoLater();
  }

  String personalizeQuantity(double quantity){
    String quantityString = quantity.toStringAsFixed(0);
    final decimal = Decimal.getDecimal(quantity);
    if(decimal != 0){
      quantityString += Decimal.forFraction(decimal);
    }
    return quantityString;
  }
}
