import 'package:busque_receitas/app/modules/pageView/despensa/despensa_page.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
          children: [
            DespensaPage(),
            HomePage(),
            Container(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: controller.onPageChanged,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dining), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "")
            ]),
      ),
    );
  }


}
