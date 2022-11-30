import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ValidationLayoutController extends GetxController {
  final index = 0.obs;
  final pageController = PageController(initialPage: 0);
  final listIngredients = <IngredientModel>[].obs;
  final loadingIngredient = false.obs;

@override
void onInit(){
  _getIngredients();
  super.onInit();
}

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int i) {
    pageController.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    onPageChangedIcon(i);
  }

  onPageChangedIcon(int index) {
    this.index.value = index;
  }


   Future<void> _getIngredients() async {
    loadingIngredient.value = true;
    try {
      final repositoryIngredient = IngredientRepository();
      listIngredients.assignAll(
          await repositoryIngredient.getIngredients(show: 'invalid'));
      loadingIngredient.value = false;
    } catch (e) {
      print(e);
      loadingIngredient.value = false;
    }
  }
}