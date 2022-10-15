import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/widgets/erro_page.dart';
import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'pantry_controller.dart';

class PantryPage extends GetView<PantryController> {
  const PantryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despensa'),
        centerTitle: true,
      ),
      body: body(),
      floatingActionButton: addButton(),
    );
  }

  Widget body() {
    if (controller.splashController.listGroups.isEmpty) {
      return Obx(() => ErroPage(
            visible: controller.visibleRefrash.value,
            onPressed: controller.refrashPage,
          ));
    }
    return ListView.builder(
        itemCount: controller.splashController.listGroups.length,
        itemBuilder: ((context, index) {
          final group = controller.splashController.listGroups[index];
          return Obx(() {
            return groupCard(group);
          });
        }));
  }

  Widget ingredientCard(
      {required IngredientModel ingredient, Color color = AppColor.dark1}) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: AppTheme.boxDecoration(color: color),
        child: Text(
          ingredient.name,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      onTap: () {
        controller.changeIngredient(ingredient: ingredient);
      },
    );
  }

  Widget title(String nome) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: Text(nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget groupCard(GroupIngredientsModel group) {
    final ingredientInGroup = controller.ingredientsInGroup(group);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Theme(
          data: AppTheme.theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: title(group.name),
            children: [
              listIngredients(
                ingredientInGroup.map(
                  (IngredientModel ingredient) {
                    if (controller.havePantry(ingredient.id)) {
                      return ingredientCard(ingredient: ingredient);
                    }
                    return ingredientCard(
                        ingredient: ingredient, color: Colors.grey);
                  },
                ).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listIngredients(List<Widget> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.spaceEvenly,
          children: list),
    );
  }

  Widget addButton() {
    return Visibility(
      visible: controller.splashController.listIngredients.isEmpty,
      replacement: FloatingActionButton(
          backgroundColor: AppColor.dark2,
          onPressed: () {
            Get.toNamed('/add_pantry');
          },
          child: const Icon(
            Icons.add,
            color: AppColor.light,
          )),
      child: Container(),
    );
  }
}
