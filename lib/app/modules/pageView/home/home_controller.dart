import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final _listRecipes = <RecipeModel>[].obs;
  final _repository = RecipeRepository();
  final visibleRefrash = false.obs; 
  final user = Get.find<SplashController>().user;
  final havePatry = Get.find<SplashController>().havePatry;
  final search = ''.obs;
  final listPantry = Get.find<SplashController>().listPantry;

  List<RecipeModel> get listRecipes {
    return _listRecipes.where((e) {
      if (e.title.toLowerCase().contains(search.value.toLowerCase())) {
        return true;
      }
      // for (var pass in e.method) {
      //   if (pass.toLowerCase().contains(search.value.toLowerCase())) {
      //     return true;
      //   }
      // }
     return false;
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
      print("erro ao carregar receitas");
    }
  }

  void goPageRecipe(RecipeModel recipe) {
    Get.toNamed('/recipe', arguments: recipe);
  }

  void logoutUser() {
    print("sair");
    Get.back();
    Get.find<SplashController>().user.value = null;
    GetStorage().remove('user');
    Get.find<Dio>().options.headers = {};
    AppSnackBar.success("Usuário deslogado");
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
        return a.rating > b.rating ? 0 : 1;
      }
      return missedA < missedB ? 0 : 1;
    });
  }

  void filterNivel(Difficulty difficulty){
   
  }





}
