import 'package:busque_receitas/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppDrawer extends StatefulWidget {
  final void Function()? logoutUser;
  final UserModel? user;

  const AppDrawer({Key? key, this.logoutUser, required this.user}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  @override
  Widget build(BuildContext context) {
    return
       Drawer(
        child: Column(
          children: [
            Visibility(
              visible: widget.user == null,
              replacement: UserAccountsDrawerHeader(
                accountName: Text(widget.user?.name ?? ""),
                accountEmail: Text(widget.user?.email?? ""),
              ),
              child: UserAccountsDrawerHeader(
                accountName: const Text("Faça login ou cadastre-se"),
                accountEmail: Text(""),
                onDetailsPressed: () {
                  Get.back();
                  Get.toNamed('/login');
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              subtitle: const Text("tela de inicio"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Receita"),
              subtitle: const Text("tela de receita"),
              onTap: () {
                Get.toNamed("/recipe");
              },
            ),
            Visibility(
              visible: widget.user != null,
              child: ListTile(
                title: const Text("Sair"),
                onTap:
                  
                    widget.logoutUser?.call
                  
                ,
              ),
            ),
          ],
        
      ),
    );
  }
}
