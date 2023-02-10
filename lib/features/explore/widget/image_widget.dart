import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/ui/widgets/cachedImage.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.fit,
      required this.image,
      required this.imageType})
      : super(key: key);
  final double height;
  final double width;
  final BoxFit fit;
  final String image;
  final String imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageType == "file"
              ? Image.file(File(image), fit: fit)
              : CachedImage(
                  imageUrl: image,
                  fit: fit,
                )),
    );
  }
}
