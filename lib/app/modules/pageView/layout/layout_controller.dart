import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  final index = 0.obs;
  final pageController = PageController();

  @override

  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int i) {
    pageController.animateToPage(i,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
    onPageChangedIcon(i);
  }

  onPageChangedIcon(int index) {
    this.index.value = index;
  }
}
