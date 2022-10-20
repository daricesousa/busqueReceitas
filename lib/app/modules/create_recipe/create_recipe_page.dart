import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/core/widgets/app_select.dart';
import 'package:busque_receitas/app/core/widgets/app_drop.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './create_recipe_controller.dart';

class CreateRecipePage extends GetView<CreateRecipeController> {
  const CreateRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar uma receita'),
      ),
      body: Obx(() => body(context)),
    );
  }

  Widget body(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        AppFormField(
          label: "Título",
          controller: controller.title,
        ),
        const SizedBox(height: 30),
        titleWidget(
          context: context,
          title: "Ingredientes",
          addFunction: controller.newIngredient,
          removeFunction: controller.removeIngredient,
        ),
        ...List.generate(controller.listIngredient.length, (index) {
          return ingredientWidget(index);
        }),
        const SizedBox(height: 30),
        titleWidget(
          context: context,
          title: "Modo de preparo",
          addFunction: controller.newMethod,
          removeFunction: controller.removeMethod,
        ),
        ...List.generate(
            controller.listMethod.length,
            (index) => methodWidget(
                  index: index,
                  onChange: (e) =>
                      controller.onChangeMethod(index: index, text: e),
                )).toList(),
        const SizedBox(height: 30),
        const Text("Imagem", style: TextStyle(fontSize: 20)),
        const SizedBox(height: 5),
        GestureDetector(
            child: Container(
              decoration: AppTheme.boxDecoration(color: AppColor.light),
              height: context.width / 2,
              child: const Icon(
                Icons.hide_image,
                size: 50,
                color: AppColor.dark1,
              ),
            ),
            onTap: () {}),
        const SizedBox(height: 30),
        difficultyWidget(context),
        const SizedBox(height: 30),
        AppButton(
            onPressed: () {
              final res = controller.confirmar();
              print(res);
            },
            child: const Text("Confirmar")),
      ],
    );
  }

  Widget titleWidget({
    required BuildContext context,
    required String title,
    required Function() addFunction,
    required Function() removeFunction,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: context.width / 3 * 2,
          child: Text(title, style: const TextStyle(fontSize: 20)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: AppButton(
              onPressed: addFunction,
              child: const Icon(
                Icons.add,
                color: AppColor.dark2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: AppButton(
              onPressed: removeFunction,
              child: const Icon(
                Icons.remove,
                color: AppColor.dark2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget ingredientWidget(int index) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: AppSelect<IngredientModel>(
              label: controller.listIngredient[index]?.name ?? "Ingrediente",
              items: controller.listAllIngredients,
              titleItem: (e) => e.name,
              onChange: (i) =>
                  controller.onChangeIngredient(ingredient: i, index: index)),
        ),
        const SizedBox(width: 5),
        Expanded(
            flex: 3,
            child: AppFormField(
              label: "Quantidade",
              textInputType: TextInputType.number,
              onChanged: (e) =>
                  controller.onChangeQuantity(quantity: e, index: index),
            )),
        const SizedBox(width: 5),
        Expanded(
            flex: 3,
            child: AppDrop<String>(
              label: controller.listMeasurer[index] ?? "Medida",
              list: controller.listDropMeasurer,
              onChange: (i) {
                controller.onChangeMeasurer(measurer: i, index: index);
              },
            )),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget methodWidget({
    required int index,
    required void Function(String) onChange,
  }) {
    return AppFormField(
      maxLines: 3,
      label: "Passo ${index + 1}",
      onChanged: onChange,
    );
  }

  Widget difficultyWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.width / 2,
          child: const Text("Dificuldade", style: TextStyle(fontSize: 20)),
        ),
        Expanded(
            child: AppDrop<Difficulty>(
          label: controller.difficulty.value?.name ?? "Dificuldade",
          list: controller.listDropDifficulty,
          onChange: controller.onChangeDifficulty,
        ))
      ],
    );
  }
}
