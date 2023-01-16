import 'dart:io';

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key, required this.height, required this.width, required this.fit, required this.image})
      : super(key: key);
  final double height;
  final double width;
  final BoxFit fit;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(image, fit: fit)),
    );
  }
}
