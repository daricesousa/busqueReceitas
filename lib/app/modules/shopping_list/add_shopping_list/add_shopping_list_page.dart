import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './add_shopping_list_controller.dart';

class AddShoppingListPage extends GetView<AddShoppingListController> {
  const AddShoppingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar a lista de compras'),
      ),
      body: Obx(() => body()),
    );
  }

  Widget body() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppFormField(
              label: "Pesquise aqui",
              onChanged: (word) {
                controller.search.value = word;
              },
            )),
        Flexible(
          child: ListView.builder(
              itemCount: controller.listNotShopping.length + 1,
              itemBuilder: (context, index) {
                if(index == controller.listNotShopping.length){
                  return AppButton(onPressed: (){
                    final ingredient = IngredientModel(id: DateTime.now().millisecondsSinceEpoch * -1, name: controller.search.value, groupId: -1);
                    controller.addShopping(ingredient);
                  }, child: const Text("Novo ingrediente"));
                }
                IngredientModel ingredient = controller.listNotShopping[index];
                return Card(
                  child: ListTile(
                    title: Text(ingredient.name),
                    // subtitle: controller.havePantry(ingredient.id)
                    // ? const Text("Você possui este item na despensa")
                    // : null,
                    trailing: controller.havePantry(ingredient.id)
                        ? const Tooltip(
                            message: "Você já possui este item na despensa",
                            child: Icon(
                              MdiIcons.fridge,
                              color: AppColor.dark1,
                            ),
                          )
                        : null,
                    onTap: () {
                      controller.addShopping(ingredient);
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }
}
