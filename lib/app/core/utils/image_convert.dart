import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

class ImageConvert {
  ImageConvert._();

  static Image base64fromImage(
      {required String base64String, double height = 120, double width = 200}) {
    try {
      final image = base64Decode(base64String);
      return Image.memory(
        image,
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    } catch (e) {
      return Image.network(
        "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png",
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    }
  }

  static Future<String> imageFromBase64({required String path}) async {
    File image = File(path);
    String base64 = base64Encode((await image.readAsBytes()));
    return base64;
  }
}
