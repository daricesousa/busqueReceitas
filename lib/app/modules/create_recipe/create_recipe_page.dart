import 'dart:io';
import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/core/utils/enum_home_appliance.dart';
import 'package:busque_receitas/app/core/utils/enum_recipe_type.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/core/widgets/app_select.dart';
import 'package:busque_receitas/app/core/widgets/app_drop.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/create_recipe/widgets/time_widget.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/list_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        ),
        ...List.generate(controller.listIngredientCreate.length, (index) {
          return ingredientWidget(
            index: index,
            remove: () => controller.removeIngredient(index),
          );
        }),
        const SizedBox(height: 30),
        titleWidget(
          context: context,
          title: "Modo de preparo",
          addFunction: controller.newMethod,
        ),
        ...List.generate(
            controller.listMethod.length,
            (index) => methodWidget(
                  index: index,
                  remove: () => controller.removeMethod(index),
                )).toList(),
        const SizedBox(height: 30),
        ...image(context),
        const SizedBox(height: 30),
        difficultyWidget(context),
        const SizedBox(height: 30),
        const SizedBox(height: 10),
        timeSetup(context),
        const SizedBox(height: 10),
        timeCooking(context),
        const SizedBox(height: 30),
        accept(),
        const SizedBox(height: 30),
        ...controller.errors.map((e) => error(e ?? '')).toList(),
        const SizedBox(height: 10),
        AppButton(
            visible: controller.loading.value,
            onPressed: () {
              controller.validations();
            },
            child: const Text("Confirmar")),
      ],
    );
  }

  List<Widget> image(BuildContext context) {
    return [
      const Text("Imagem", style: TextStyle(fontSize: 20)),
      const SizedBox(height: 5),
      GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                decoration: AppTheme.boxDecoration(color: AppColor.light),
                height: context.width / 2,
                child: controller.image.value != null
                    ? Image.file(
                        File(controller.image.value!.path),
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.hide_image,
                        size: 50, color: AppColor.dark1)),
          ),
          onTap: () async {
            await controller.getImage(context);
          }),
      ListItem(
        padding: 7,
        leading: Icon(
          controller.pictureIlustration.value
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: AppColor.dark1,
        ),
        text: "Imagem meramente ilustrativa",
        onTap: () {
          controller.pictureIlustration.value =
              !controller.pictureIlustration.value;
        },
      )
    ];
  }

  Widget titleWidget({
    required BuildContext context,
    required String title,
    required Function() addFunction,
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
      ],
    );
  }

  Widget ingredientWidget({required int index, void Function()? remove}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: AppSelect<IngredientModel>(
                  label:
                      controller.listIngredientCreate[index].ingredient?.name ??
                          "Ingrediente",
                  items: controller.listAllIngredients,
                  titleItem: (e) => e.name,
                  onChange: (i) => controller.onChangeIngredient(
                      ingredient: i, index: index)),
            ),
            const SizedBox(width: 5),
            Expanded(
                flex: 3,
                child: AppFormField(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  controller: controller.listIngredientCreate[index].quantity,
                  labelFontSize: 14,
                  label: "Quantidade",
                  textInputType: TextInputType.number,
                )),
            const SizedBox(width: 5),
            Expanded(
                flex: 3,
                child: AppDrop<String>(
                  label: controller.listIngredientCreate[index].measurer ??
                      "Medida",
                  list: controller.listDropMeasurer,
                  onChange: (i) {
                    controller.onChangeMeasurer(measurer: i, index: index);
                  },
                )),
            const SizedBox(width: 5),
          ],
        ),
        GestureDetector(
          onTap: remove,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Remover",
              style: TextStyle(color: AppColor.light1),
            ),
          ),
        )
      ],
    );
  }

  
  Widget methodWidget({
    required int index,
    void Function()? remove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        AppFormField(
          controller: controller.listMethod[index],
          maxLines: 3,
          label: "Passo ${index + 1}",
        ),
        GestureDetector(
          onTap: remove,
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Remover",
              style: TextStyle(color: AppColor.light1),
            ),
          ),
        )
      ],
    );
  }

  Widget difficultyWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.width / 3,
          child: const Text("Esforço", style: TextStyle(fontSize: 20)),
        ),
        Expanded(
            child: AppDrop<Difficulty>(
          label: controller.difficulty.value?.name ?? "Esforço",
          list: controller.listDropDifficulty,
          onChange: controller.onChangeDifficulty,
        ))
      ],
    );
  }

  Widget timeSetup(BuildContext context) {
    return TimeWidget(
      icon: MdiIcons.chefHat,
      context: context,
      title: "Tempo de preparo",
      appDrop: AppDrop<String>(
        label: controller.timeSetup.value ?? "Tempo",
        list: controller.listDropTime,
        onChange: controller.onChangeTimeSetup,
      ),
    );
  }

  Widget timeCooking(BuildContext context){
    return TimeWidget(
          icon: MdiIcons.gasBurner,
          context: context,
          title: "Tempo de cozimento",
          appDrop: AppDrop<String>(
            label: controller.timeCooking.value ?? "Tempo",
            list: controller.listDropTime,
            onChange: controller.onChangeTimeCooking,
          ),
        );
  }
  Widget accept(){
    return ListItem(
          padding: 7,
          leading: Icon(
            controller.aceppetedTerm.value
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: AppColor.dark1,
          ),
          text: "Li e aceito o termo de responsabilidade",
          onTap: () {
            controller.aceppetedTerm.value = !controller.aceppetedTerm.value;
          },
        );
  }

  Widget error(String text) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.red,
          ),
        ),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: AppColor.red)),
      ],
    );
  }

  Widget wrap(List<Widget> list) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Wrap(
          spacing: 2,
          runSpacing: 2,
          alignment: WrapAlignment.spaceEvenly,
          children: list),
    );
  }

  Widget card(
      {required String title,
      Color? color,
      Color? textColor,
      void Function()? onTap}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(5),
              decoration: AppTheme.boxDecoration(
                color: color,
              ),
              child: Text(
                title,
                style: TextStyle(color: textColor),
              )),
        ));
  }
}
