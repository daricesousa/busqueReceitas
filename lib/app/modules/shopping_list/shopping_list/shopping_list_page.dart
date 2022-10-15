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
      floatingActionButton: addButton(),
      body: Obx(() => body()),
    );
  }

  Widget body() {
    if (controller.shoppingList.isEmpty && controller.search.isEmpty) {
      return NoResultsPage(
          visible: false,
          title: "Nenhum item para mostrar",
          subtitle: "Ver receitas",
          onPressed: Get.back);
    }
    return ListView.builder(
        itemCount: controller.shoppingList.length + 1,
        itemBuilder: ((context, index) {
          if (index == controller.shoppingList.length) {
            return Container(
              height: 70,
            );
          }
          final item = controller.shoppingList[index];
          return itemWidget(item);
        }));
  }

  Widget itemWidget(ShoppingListModel item) {
    return Card(
      child: ListTile(
        title: Text(item.ingredient.name),
        subtitle: controller.havePantry(item.ingredient.id)
            ? const Text("Você possui este item na despensa")
            : null,
        leading: IconButton(
          icon: const Icon(Icons.check_box_outline_blank_outlined),
          onPressed: () => controller.addPantry(item),
          tooltip: "Adicionar a despensa",
        ),
        trailing: Visibility(
          visible: item.recipe != null,
          replacement: IconButton(
            icon: const Icon(
              Icons.delete,
              color: AppColor.light1,
            ),
            tooltip: "Remover da lista de compras",
            onPressed: () {
              controller.removeShoppingListUser(item.ingredient.id);
            },
          ),
          child: IconButton(
            icon: const Icon(
              MdiIcons.bookOpenVariant,
              color: AppColor.dark1,
            ),
            tooltip: "Ver receita",
            onPressed: () => Get.toNamed('/recipe', arguments: item.recipe),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return FloatingActionButton(
      backgroundColor: AppColor.dark2,
      onPressed: controller.addShopping,
      child: const Icon(
        Icons.add,
        color: AppColor.light,
      ),
    );
  }
}
