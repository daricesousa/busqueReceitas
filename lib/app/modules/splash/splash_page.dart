import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
          Image.asset('assets/images/splash.png', height: context.height/4, width: context.height/4,),
        
      ),
    );
  }
}
