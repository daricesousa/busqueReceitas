import 'package:busque_receitas/app/app_pages.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/utils/connect_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.theme,
      enableLog: true,
      debugShowCheckedModeBanner: false,
      initialBinding: ConnectBinding(),
      getPages: AppPages.pages,
    );
  }
}
