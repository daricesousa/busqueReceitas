
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterRecipeController extends GetxController {
  final _listPantry = Get.find<SplashController>().listPantry;
  final _findIngredient = Get.find<SplashController>().findIngredient;
  final _listFilters = Get.find<HomeController>().listFilters;
  
  List<IngredientModel> get listIngredientsPantry{
    final list = _listIngredientsPantry();
    list.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return list;
  }

  List<IngredientModel> _listIngredientsPantry() {
    List<IngredientModel> list = [];
    for (int ingredientId in _listPantry) {
      list.add(_findIngredient(ingredientId));
    }
    return list;
  }

  void changeCard(
      {required TypeFilters type,
      required Widget title,
      required dynamic value}) {
    if (searchFilter(value: value)){
      _removeFilter(value);
    }
    else{
      if(type == TypeFilters.avaliation){
        _listFilters.removeWhere((e) => e.type == TypeFilters.avaliation);
      }
    _createFilter(type: type, title: title, value: value);
    }

  }

  bool searchFilter({required dynamic value}) {
    final index = _listFilters.indexWhere((e) => e.value == value);
    if (index > -1) {
      return true;
    }
    return false;
  }

  void _createFilter({
    required TypeFilters type,
    required Widget title,
    required dynamic value,
  }) {
    final filter = FilterRecipeModel(title: title, type: type, value: value);
    _listFilters.add(filter);
  }

  void _removeFilter(dynamic value) {
    _listFilters.removeWhere((e) => e.value == value);

  }

  void clearFilters(BuildContext context){
    Get.back();
    Get.find<HomeController>().clearFilters();
  }

  void filter(){
     Get.back();
     Get.find<HomeController>().getRecipes();
  }
}
