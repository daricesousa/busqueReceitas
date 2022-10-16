import 'package:busque_receitas/app/modules/pageView/home/home_page.dart';
import 'package:busque_receitas/app/modules/pageView/pantry/pantry_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './layout_controller.dart';

class LayoutPage extends GetView<LayoutController> {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: PageView(
          onPageChanged: controller.onPageChangedIcon,
          controller: controller.pageController,
          children: const [
            PantryPage(),
            HomePage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: controller.onPageChanged,
            items: const [
              BottomNavigationBarItem(icon: Icon(MdiIcons.fridge), label: "Despensa"),
              BottomNavigationBarItem(icon: Icon(Icons.dining), label: "Receitas"),
            ]),
      ),
    );
  }


}
