import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final listRecipes = <RecipeModel>[].obs;
  final repository = RecipeRepository();
   final visibleRefrash = false.obs;

  @override
  void onInit() {
    getRecipes();
    super.onInit();
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






}