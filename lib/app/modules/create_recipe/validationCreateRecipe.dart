import 'dart:io';

import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/create_recipe/ingredient_create_recipe_model.dart';
import 'package:flutter/material.dart';

class ValidationCreateRecipe {
  ValidationCreateRecipe._();

  static title(String title) {
    if (title == '') {
      return 'Preencha o título';
    }
    if (title.length < 3) {
      return 'O título deve ter no mínimo 3 caracteres';
    }
  }

  static difficulty(Difficulty? difficulty) {
    if (difficulty == null) {
      return 'Preencha a dificuldade';
    }
  }

  static image(File? image) {
    if (image == null) {
      return "Adicione uma imagem";
    }
  }

  static method(List<TextEditingController> listMethod) {
    if (listMethod.isEmpty) {
      return "Preencha o modo de preparo";
    }

    for (var index = 0; index < listMethod.length; index += 1) {
      if (listMethod[index].text == '') {
        return "Passo não preenchido";
      }
    }
  }

  static ingredient(IngredientModel? ingredient) {
    if (ingredient == null) {
      return "Ingrediente não preenchido";
    }
  }

  static measurer({required String? measurer, required String nameIngredient}) {
    if (measurer == null) {
      return "Medida do ingrediente $nameIngredient não preechida";
    }
  }

  static quantity({required String quantity, required String nameIngredient}) {
    final quantityDouble = double.tryParse(quantity);
    if (quantityDouble == null || quantityDouble <= 0) {
      return "Quantidade do ingrediente $nameIngredient inválida";
    }
  }

  static listIngredient(List<IngredientCreateRecipeModel?> listIngredient) {
    if (listIngredient.isEmpty) {
      return "Preencha os ingredientes";
    }
  }

  static timeSetup(String? time) {
    if (time == null) {
      return "Seleciona o tempo de preparo";
    }
  }

  static timeCooking(String? time) {
    if (time == null) {
      return "Seleciona o tempo de cozimento";
    }
  }
}
