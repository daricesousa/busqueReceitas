
import 'package:busque_receitas/app/modules/pageView/home/widgets/app_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Container(),
      drawer: AppDrawer(onTap: () {}),

    );
  }
}
