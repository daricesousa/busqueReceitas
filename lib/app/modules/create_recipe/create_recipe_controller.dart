import 'dart:io';
import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:camera_with_files/camera_with_files.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRecipeController extends GetxController {
  final listAllIngredients = Get.find<SplashController>().listIngredients;
  List<DropdownMenuItem<String>> listDropMeasurer = [];
  List<DropdownMenuItem<Difficulty>> listDropDifficulty = [];
  final listIngredient = <IngredientModel?>[].obs;
  final listMeasurer = <String?>[].obs;
  final listQuantity = <TextEditingController>[].obs;
  final listMethod = <TextEditingController>[].obs;
  final difficulty = Rxn<Difficulty?>();
  final title = TextEditingController();
  final image = Rxn<File?>();

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
    listQuantity.add(TextEditingController());
  }

  void removeIngredient(int index) {
    listQuantity.removeAt(index);
    listMeasurer.removeAt(index);
    listIngredient.removeAt(index);
  }

  void newMethod() {
    listMethod.add(TextEditingController());
  }

  void removeMethod(int index) {
    listMethod.removeAt(index);
  }

  Future<void> getImage(BuildContext context) async {
    final res = await Get.to<List<File>>(CameraApp(isMultiple: true));
    if (res != null && res.isNotEmpty) {
      image.value = res[0];
    }
  }

  String? confirm() {
    if (title.text == '') {
      return "Preencha o título";
    }
    if (listIngredient.isEmpty) {
      return "Preencha os ingredientes";
    }

    if (listMethod.isEmpty) {
      return "Preencha o modo de preparo";
    }

    if (difficulty.value == null) {
      return "Preencha a dificuldade";
    }
    if (image.value == null) {
      return "Adicione uma imagem";
    }

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
      final quantityDouble = double.tryParse(quantity.text);
      if (quantityDouble == null || quantityDouble <= 0) {
        return "Quantidade do ingrediente ${ingredient.name} inválida";
      }
    }

    for (var index = 0; index < listMethod.length; index += 1) {
      if (listMethod[index].text == '') {
        return "Passo não preenchido";
      }
    }
  }
}
