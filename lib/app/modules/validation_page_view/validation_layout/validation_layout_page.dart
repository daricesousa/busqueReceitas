import 'package:busque_receitas/app/modules/validation_page_view/validation_ingredients/validation_ingredients_page.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_recipes/validation_recipes_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './validation_layout_controller.dart';

class ValidationLayoutPage extends GetView<ValidationLayoutController> {
  const ValidationLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          onPageChanged: controller.onPageChangedIcon,
          controller: controller.pageController,
          children: const [
            ValidationIngredientsPage(),
            ValidationRecipesPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: controller.onPageChanged,
            items: const [
              BottomNavigationBarItem(icon: Icon(MdiIcons.carrot), label: "Validação de ingredientes"),
              BottomNavigationBarItem(icon: Icon(MdiIcons.noodles), label: "Validação de receitas"),
            ]),
      ),
    );
  }


}