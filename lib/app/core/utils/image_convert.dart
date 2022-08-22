import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

class ImageConvert {
  ImageConvert._();

  static Image base64fromImage(
      {required String base64String, double height = 120, double width = 200}) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }

  static Future<String> imageFromBase64({required String path}) async {
    File image = File(path);
    String base64 = base64Encode((await image.readAsBytes()));
    return base64;
  }
}
