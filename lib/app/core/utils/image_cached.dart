import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ImageCached extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Function(dynamic)? asError;

  const ImageCached(
    this.imageUrl, {
    Key? key,
    this.height = 120,
    this.width = 200,
    this.asError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => SkeletonLine(
        style: SkeletonLineStyle(
            height: height,
            width: width,
            borderRadius: BorderRadius.circular(8)),
      ),
      errorWidget: (context, url, error) {
        asError?.call(error);
        return const Icon(Icons.hide_image);
      },
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
