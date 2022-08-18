import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './recipe_controller.dart';

class RecipePage extends GetView<RecipeController> {
    
    const RecipePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Bolo de chocolate'),),
            body: Container(),
        );
    }
}