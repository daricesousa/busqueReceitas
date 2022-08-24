import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
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
      return Obx(() => listGroupsEmpty());
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
      {required IngredientModel ingredient, Color color = Colors.green}) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: AppTheme.boxDecoration(color: color),
        child: Text(
          ingredient.name,
          style: const TextStyle(fontSize: 18, color: Colors.white),
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
                    fontSize: 23,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget groupCard(GroupIngredientsModel group) {
    final listIngredientsInGroup = controller.ingredientsInGroup(group);
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
                  listIngredientsInGroup.map((IngredientModel ingredient) {
                if (controller.havePatry(ingredient.id)) {
                  return ingredientCard(ingredient: ingredient);
                }
                return ingredientCard(
                    ingredient: ingredient, color: Colors.grey);
              }).toList())
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
      visible: controller.listIngredients.isEmpty,
      replacement: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/ingredients');
          },
          child: const Icon(Icons.add)),
      child: Container(),
    );
  }

  Widget listGroupsEmpty() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Conecte-se a internet",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          Container(height: 10),
          AppButton(
            label: "Tentar novamente",
            visible: controller.visibleRefrash.value,
            onPressed: controller.refrashPage,
          ),
        ]);
  }
}
