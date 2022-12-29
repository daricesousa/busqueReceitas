import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: AppColor.light4,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 100),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    controller.userName,
                    style: const TextStyle(fontSize: 20),
                  ),
                   Text(
                    controller.userEmail,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              )),
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return ListView(
      children: [
        ListTile(
          title: const Text("Adicionar uma receita"),
          leading: const Icon(
            MdiIcons.receiptTextPlus,
            color: AppColor.dark1,
          ),
          onTap: () {
            Get.toNamed('/create_recipe');
          },
        ),
        // ListTile(
        //   title: const Text("Restrições alimentares"),
        //   leading: const Icon(
        //     MdiIcons.foodDrumstickOff,
        //     color: AppColor.dark1,
        //   ),
        //   onTap: () {},
        // ),
        // ListTile(
        //   title: const Text("Alterar a senha"),
        //   leading: const Icon(
        //     Icons.lock,
        //     color: AppColor.dark1,
        //   ),
        //   onTap: () {},
        // ),
        ListTile(
          title: const Text("sair"),
          leading: const Icon(
            Icons.exit_to_app,
            color: AppColor.dark1,
          ),
          onTap: controller.logoutUser,
        ),
      ],
    );
  }
}
