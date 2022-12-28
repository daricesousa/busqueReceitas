import 'package:busque_receitas/app/core/widgets/no_results_page.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/list_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './validation_ingredients_controller.dart';

class ValidationIngredientsPage
    extends GetView<ValidationIngredientsController> {
  const ValidationIngredientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingredientes para validação',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Obx(body),
    );
  }

  Widget body() {
    if (!controller.loading.value && controller.listIngredients.isEmpty) {
      return NoResultsPage(
        title: "Nada para validar",
        subtitle: "Ver receitas",
        onPressed: Get.back,
      );
    }
    if (controller.loading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: controller.listIngredients.length,
      itemBuilder: ((context, index) {
        final ingredient = controller.listIngredients[index];
        return ListItem(
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
              width: Get.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ingredient.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(controller.nameGroup(ingredient.groupId) ?? ''),
                ],
              ),
            ),
            IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () => controller.validateIngredient(
                    ingredient: ingredient, accept: true)),
            const SizedBox(width: 20),
            IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => controller.validateIngredient(
                    ingredient: ingredient, accept: false)),
          ]),
        );
      }),
    );
  }
}
