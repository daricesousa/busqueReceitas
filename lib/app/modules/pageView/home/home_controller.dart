import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final listRecipes = <RecipeModel>[].obs;
  final repository = RecipeRepository();

  @override
  void onInit() {
    getRecipes();
    super.onInit();
  }

  Future<void> getRecipes()async {
    try{
      listRecipes.assignAll(await repository.getRecipes());
    }
    catch(e){
      print("erro ao carregar receitas");
    }
  }




}