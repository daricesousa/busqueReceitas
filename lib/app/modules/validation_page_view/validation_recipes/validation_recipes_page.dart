import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './validation_recipes_controller.dart';

class ValidationRecipesPage extends GetView<ValidationRecipesController> {
    
    const ValidationRecipesPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Validação de receitas', style: TextStyle(fontSize: 18),), centerTitle: true),
            body: Container(),
        );
    }
}