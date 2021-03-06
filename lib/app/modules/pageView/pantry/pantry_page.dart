import 'package:busque_receitas/app/core/ui/app_theme.dart';
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
      body: Obx(() => body()),
      floatingActionButton: addButton(),
    );
  }

  Widget body() {
    return ListView.builder(
        itemCount: controller.listGroupsIngredients.length,
        itemBuilder: ((context, index) {
          final group = controller.listGroupsIngredients[index];
          return groupCard(group);
        }));
  }

  Widget ingredientCard(IngredientModel ingredient) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: decoration(),
        child: Text(
          ingredient.name,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      onTap: () {
        controller.changeIngredient(ingredient, !ingredient.pantry);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Theme(
          data: AppTheme.theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: title(group.name),
            children: [
              listIngredients(
                  group.listIngredients.map((IngredientModel ingredient) {
                if (ingredient.pantry) {
                  return ingredientCard(ingredient);
                }
                return Container();
              }).toList())
            ],
          ),
        ),
      ),
    );
  }

  Widget listIngredients(List<Widget> lista) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.spaceEvenly,
          children: lista),
    );
  }

  BoxDecoration decoration({Color cor = Colors.green}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: cor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(3, 3),
          )
        ]);
  }

  Widget addButton() {
    return FloatingActionButton(
        onPressed: () {
          Get.toNamed('/ingredients');
        },
        child: const Icon(Icons.add));
  }
}
