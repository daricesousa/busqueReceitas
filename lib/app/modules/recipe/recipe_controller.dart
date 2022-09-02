import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/avaliation_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/models/user_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  RecipeModel recipe;
  SplashController splashController;
   final user=Get.find<SplashController>().user;
  bool userAvaliated = false;
  int userRating = 0;
  final _repository = RecipeRepository();

  RecipeController({required this.recipe, required this.splashController});

  @override
  void onInit() {
    _checkUserAvaliated();
    super.onInit();
  }

  

  IngredientModel _findIngredient(int id) {
    final index =
        splashController.listIngredients.indexWhere((i) => i.id == id);
    return splashController.listIngredients[index];
  }

  String nameIngredient(int id) {
    final ingredient = _findIngredient(id);
    return ingredient.name;
  }

  void _checkUserAvaliated() {
    var index = recipe.avaliations.indexWhere(
        (AvaliationModel avaliation) => avaliation.userId == user.value?.id);
    if (index != -1) {
      userRating = recipe.avaliations[index].rating;
    }
  }

  Future<void> newAvaliation(int start) async{
    try {
      final res = await 
          _repository.newAvaliation(recipeId: recipe.id, rating: start);
      AppSnackBar.success("Avaliação realizada");
    } on DioError catch (e) {
      print(e.response?.data["message"]);
      AppSnackBar.error("Algo deu errado. Verifique sua conexão com a internet");
    } 
  }

 
}
