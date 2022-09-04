import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/avaliation_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  RecipeModel recipe;
   final user=Get.find<SplashController>().user;
   final nameIngredient =Get.find<SplashController>().nameIngredient;
   final havePatry =Get.find<SplashController>().havePatry;
  bool userAvaliated = false;
  int userRating = 0;
  final _repository = RecipeRepository();

  RecipeController({required this.recipe});

  @override
  void onInit() {
    _checkUserAvaliated();
    super.onInit();
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
