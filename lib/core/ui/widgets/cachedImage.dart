import 'package:cached_network_image/cached_network_image.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icons.dart';

class CachedImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  double? height;
  double? width;
  CachedImage({Key? key, this.height, this.width, required this.imageUrl, required this.fit}) : super(key: key);

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: widget.fit,
        height: widget.height ?? null,
        width: widget.width ?? null,
        placeholder: (context, url) => const Center(child: LoadingIndicator()),
        errorWidget: (context, url, error) => Image.asset(
              profileHolder,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ));
  }
}
