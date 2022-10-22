import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppDrawer extends StatefulWidget {
  final void Function()? logoutUser;
  final UserModel? user;

  const AppDrawer({Key? key, this.logoutUser, required this.user})
      : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Visibility(
            visible: widget.user == null,
            replacement: UserAccountsDrawerHeader(
              accountName: Text(
                widget.user?.name ?? "",
                style: const TextStyle(color: AppColor.light),
              ),
              accountEmail: Text(
                widget.user?.email ?? "",
                style: const TextStyle(color: AppColor.light),
              ),
              onDetailsPressed: (){
                Get.back();
                // Get.toNamed('/profile');
                Get.toNamed('/create_recipe');
              },
            ),
            child: UserAccountsDrawerHeader(
              accountName: const Text("Faça login ou cadastre-se",
                  style:  TextStyle(color: AppColor.light)),
              accountEmail: const Text(""),
              onDetailsPressed: () {
                Get.back();
                // Get.toNamed('/login');
                Get.toNamed('/create_recipe');
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: AppColor.dark1,
            ),
            title: const Text("Favoritos"),
            onTap: () {
              Get.back();
              Get.toNamed("/favorites");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.timer,
              color: AppColor.dark1,
            ),
            title: const Text("Fazer depois"),
            onTap: () {
              Get.back();
              Get.toNamed("/do_later");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              color: AppColor.dark1,
            ),
            title: const Text("Lista de compras"),
            onTap: () {
              Get.back();
              Get.toNamed("/shopping_list");
            },
          ),
          Visibility(
            visible: widget.user != null,
            child: ListTile(
              title: const Text("Sair"),
              onTap: widget.logoutUser?.call,
            ),
          ),
        ],
      ),
    );
  }
}
