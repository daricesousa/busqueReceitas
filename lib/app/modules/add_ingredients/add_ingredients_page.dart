import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'add_ingredients_controller.dart';

class AddIngredientsPage extends GetView<AddIngredientsController> {
  const AddIngredientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Obx(body));
  }

  Widget body() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppFormField(
              label: "Pesquise aqui",
              onChanged: (word) {
                controller.search(word);
              },
            )),
        Flexible(
          child: ListView.builder(
              itemCount: controller.listIngredients.length,
              itemBuilder: (context, index) {
                IngredientModel ingredient = controller.listIngredients[index];
                return Card(
                  child: ListTile(
                    leading: Visibility(
                        visible: ingredient.pantry,
                        replacement:
                            const Icon(Icons.check_box_outline_blank_outlined),
                        child: const Icon(Icons.check_box)),
                    title: Text(ingredient.name),
                    onTap: () => controller.changeIngredient(index),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
