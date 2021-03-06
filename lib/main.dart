import 'package:busque_receitas/app/app_pages.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/utils/connect_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialBinding: ConnectBinding(),
      getPages: AppPages.pages,
    );
  }
}
