import 'dart:io';
import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/create_recipe/validationCreateRecipe.dart';
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
  final errors = <String?>[].obs;

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
    listIngredient.add(IngredientModel(id: 1, name: 'name', groupId: 2, associates: []));
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

  String? validations() {
    errors.assignAll([
      ValidationCreateRecipe.title(title.text),
      ValidationCreateRecipe.difficulty(difficulty.value),
      ValidationCreateRecipe.image(image.value),
      ValidationCreateRecipe.listIngredient(listIngredient),
      ValidationCreateRecipe.method(listMethod),
    ]);

    String? ingredientErro;
    for (var index = 0;
        index < listIngredient.length && ingredientErro == null;
        index += 1) {
      ingredientErro = ValidationCreateRecipe.ingredient(listIngredient[index]);
      print(ingredientErro);
      ingredientErro = ingredientErro ??
          ValidationCreateRecipe.quantity(
            quantity: listQuantity[index].text,
            nameIngredient: listIngredient[index]!.name,
          );
          
      ingredientErro = ingredientErro ??
          ValidationCreateRecipe.measurer(
            measurer: listMeasurer[index],
            nameIngredient: listIngredient[index]!.name,
          );

    }
    errors.add(ingredientErro);
    errors.removeWhere((e) => e == null);
    print(errors);

  }
}
