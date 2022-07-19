import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppDrawer extends StatefulWidget {
  final void Function()? onTap;

  const AppDrawer({Key? key, this.onTap}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            
            accountName: Text("Faça login ou cadastre-se"),
            accountEmail: Text(""),
            onDetailsPressed: (){
              Get.back();
              Get.toNamed('/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Inicio"),
            subtitle: const Text("tela de inicio"),
            onTap: () {},
          ),
         
        ],
      ),
    );
  }
}
