import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/core/widgets/no_results_page.dart';
import 'package:busque_receitas/app/models/shopping_list_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './shopping_list_controller.dart';

class ShoppingListPage extends GetView<ShoppingListController> {
  const ShoppingListPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de compras'),
        bottom: PreferredSize(
          preferredSize: Size(context.width, 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppFormField(
              textInputAction: TextInputAction.search,
              onChanged: (word) {
                controller.search.value = word;
              },
              label: "Pesquise aqui",
            ),
          ),
        ),
      ),
      body: Obx(() => body() ),
    );
  }

  Widget body() {
    if (controller.shoppingList.isEmpty) {
        return NoResultsPage(
            visible: false,
            title: "Nenhum item para mostrar",
            subtitle: "Ver receitas",
            onPressed: Get.back);
      }
    return ListView.builder(
        itemCount: controller.shoppingList.length,
        itemBuilder: ((context, index) {
          final item = controller.shoppingList[index];
          return itemWidget(item);
        }));
  }

  Widget itemWidget(ShoppingListModel item) {
    return Card(
      child: ListTile(
          title: Text(item.ingredient.name),
          leading: IconButton(
              icon: const Icon(Icons.check_box_outline_blank_outlined),
              onPressed: () => controller.addPantry(item)),
          trailing: IconButton(
            icon: Icon(
              MdiIcons.bookOpenVariant,
              color: AppColor.dark1,
            ),
            onPressed: () {
              Get.toNamed('/recipe', arguments: item.recipe);
            },
          )),
    );
  }
}
