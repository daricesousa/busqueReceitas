import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  final UserModel? user;

  const AppDrawer({Key? key, required this.user}) : super(key: key);

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
                "Olá, ${widget.user?.name}",
                style: const TextStyle(color: AppColor.light, fontSize: 20),
              ),
              accountEmail: const Text(
                "Ver perfil",
                style: TextStyle(color: AppColor.light),
              ),
              onDetailsPressed: () {
                Get.back();
                Get.toNamed('/profile');
              },
            ),
            child: UserAccountsDrawerHeader(
              accountName: const SizedBox(
                height: 20,
                child: Text("Faça login ou cadastre-se",
                    style: TextStyle(color: AppColor.light)),
              ),
              accountEmail: const Text(""),
              onDetailsPressed: () {
                Get.back();
                Get.toNamed('/login');
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
           ListTile(
            leading: const Icon(
              Icons.add,
              color: AppColor.dark1,
            ),
            title: const Text("Cadastrar receita"),
            onTap: () {
              if (widget.user == null){
                AppSnackBar.error(message: "Faça login para cadastrar receitas");
              }
              else{
              Get.back();
              Get.toNamed('/create_recipe');
              }
            },
          ),
          widget.user?.rule == "admin"
              ? ListTile(
                  leading: const Icon(
                    Icons.check,
                    color: AppColor.dark1,
                  ),
                  title: const Text("Validações"),
                  onTap: () {
                    Get.back();
                    Get.toNamed("/validation_layout");
                  },
                )
              : const SizedBox(),
          ListTile(
            leading: const Icon(
              Icons.checklist,
              color: AppColor.dark2,
            ),
            title: const Text("Avalie o app",style: TextStyle(color: AppColor.dark2),),
            onTap: () {
              Get.back();
              launchUrl(
                Uri.parse("https://forms.gle/dD8Vib8zP9KbGK276"),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ],
      ),
    );
  }
}
