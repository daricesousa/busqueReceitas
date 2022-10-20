import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRecipeController extends GetxController {
  final listAllIngredients = Get.find<SplashController>().listIngredients;
  List<DropdownMenuItem<String>> listDropMeasurer = [];
  List<DropdownMenuItem<Difficulty>> listDropDifficulty = [];
  final listIngredient = <IngredientModel?>[].obs;
  final listMeasurer = <String?>[].obs;
  final List<double?> listQuantity = [];
  final listMethod = <String?>[].obs;
  final difficulty = Rxn<Difficulty?>();
  final title = TextEditingController();

  @override
  void onInit() {
    _getListDropMeasurer();
    _getListDifficulty();
    newIngredient();
    newMethod();
    super.onInit();
  }

  void onChangeIngredient(
      {required IngredientModel ingredient, required int index}) {
    listIngredient[index] = ingredient;
  }

  void onChangeMeasurer({required String? measurer, required int index}) {
    listMeasurer[index] = measurer;
  }

  void onChangeQuantity({required String? quantity, required int index}) {
    if (quantity != null) {
      listQuantity[index] = double.tryParse(quantity);
    }
  }

  void onChangeMethod({required String? text, required int index}) {
    listMethod[index] = text;
  }

  void onChangeDifficulty(Difficulty? difficulty) {
    this.difficulty.value = difficulty;
  }

  void _getListDropMeasurer() {
    final listMeasurer = [
      "grama",
      "quilo",
      "mililitro",
      "litro",
      "unidade",
      "colher de sopa",
      "xícara de chá (240ml)",
      "copo (200 ml)"
    ];
    final listDisplay = ["g", "kg", "ml", "L", "uni", "col", "xíc", "cp"];
    List.generate(listMeasurer.length, (index) {
      final item = DropdownMenuItem<String>(
        value: listDisplay[index],
        child: Text(listMeasurer[index]),
      );
      listDropMeasurer.add(item);
    });
  }

  void _getListDifficulty() {
    final list = Difficulty.values.map((difficulty) {
      return DropdownMenuItem(
        value: difficulty,
        child: Text(difficulty.name),
      );
    }).toList();
    listDropDifficulty.assignAll(list);
  }

  void newIngredient() {
    listIngredient.add(null);
    listMeasurer.add(null);
    listQuantity.add(null);
  }

  void removeIngredient() {
    if (listIngredient.isNotEmpty) {
      listIngredient.removeLast();
      listMeasurer.removeLast();
      listQuantity.removeLast();
    }
  }

  void newMethod() {
    listMethod.add(null);
  }

  void removeMethod() {
    if (listMethod.isNotEmpty) {
      listMethod.removeLast();
    }
  }

  String? confirmar() {
    if (title.text == '') {
      return "Preencha o título";
    }
    if (listIngredient.isEmpty) {
      return "Preencha os ingredientes";
    }
    if (difficulty.value == null) {
      return "Preencha a dificuldade";
    }
    // if(sem foto){
    //   return "adicione uma imagem";
    // }

    for (var index = 0; index < listIngredient.length; index += 1) {
      final ingredient = listIngredient[index];
      final measurer = listMeasurer[index];
      final quantity = listQuantity[index];
      if (ingredient == null) {
        return "Ingrediente não preenchido";
      }
      if (measurer == null) {
        return "Medida do ingrediente ${ingredient.name} não preechida";
      }
      if (quantity == null || quantity <= 0) {
        return "Quantidade do ingrediente ${ingredient.name} inválida";
      }
    }

    // for (var index = 0; index < listMethod.length; index += 1) {
    //   if (listMethod[index] == null) {
    //     listMethod.removeAt(index);
    //   }
    // }

    if (listMethod.isEmpty) {
      return "Preencha o modo de preparo";
    }
  }
}
