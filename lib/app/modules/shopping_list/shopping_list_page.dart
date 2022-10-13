import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './shopping_list_controller.dart';

class ShoppingListPage extends GetView<ShoppingListController> {
    
    const ShoppingListPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Lista de compras'),),
            body: body(),
        );
    }


    Widget body(){
      return Container();
    }
}