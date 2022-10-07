import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
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

  RecipeController({required this.recipe});

  Future<void> newAvaliation(int star) async {
    try {
      final res =
          await _repository.newAvaliation(recipeId: recipe.id, rating: star);
      final index = recipes.indexWhere((e) => e.id == recipe.id);
      recipe.avaliation.userRating = star;
      if (index >= 0) {
        recipes[index] = recipe;
      }
      AppSnackBar.success("Avaliação realizada");
    } on DioError catch (e) {
      print(e.response?.data["message"]);
      AppSnackBar.error(
          "Algo deu errado. Verifique sua conexão com a internet");
    }
  }
}
