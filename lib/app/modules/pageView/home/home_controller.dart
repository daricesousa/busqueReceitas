import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/models/user_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {

  final listRecipes = <RecipeModel>[].obs;
  final repository = RecipeRepository();
   final visibleRefrash = false.obs;

  @override
  void onInit() {
    getRecipes();
    super.onInit();
  }

  UserModel? getUser(){
    return Get.find<SplashController>().user;
  }

  Future<void> getRecipes()async {
    try{
      visibleRefrash.value = true;
      listRecipes.assignAll(await repository.getRecipes());
      visibleRefrash.value = false;
    }
    catch(e){
      visibleRefrash.value = false;
      print("erro ao carregar receitas");
    }
  }

  void goPageRecipe(RecipeModel recipe){
    Get.toNamed('/recipe', arguments: recipe);
  }

  void logoutUser(){
  print("sair");
    Get.back();
    Get.find<SplashController>().user = null;
    GetStorage().remove('user');
    Get.find<Dio>().options.headers = {};
    AppSnackBar.success("Usuário deslogado");
  }






}