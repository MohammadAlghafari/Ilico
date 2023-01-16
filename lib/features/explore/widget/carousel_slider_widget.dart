import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:charja_charity/features/explore/widget/videoWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/imageOrVideosFileType.dart';
import '../ui/article_details.dart';
import 'image_widget.dart';

class CarouselSliderWidget extends StatefulWidget {
  final CarouselController controller;
  final List<FileTypeImageOrVideos> urlImagesList;
  late final int activeIndex;
  final ValueChanged<int>? index;
  final int? initPage;

  final SliderType type;
  CarouselSliderWidget(
      {Key? key,
      required this.controller,
      required this.type,
      required this.activeIndex,
      required this.urlImagesList,
      this.index,
      this.initPage})
      : super(key: key);

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  double? viewportFraction;
  double? height;
  double? width;
  BoxFit? fit;

  int activeIndex = 0;
  // final urlImages = ['assets/images/article.png', 'assets/images/article.png', 'assets/images/article.png'];
  @override
  void initState() {
    activeIndex = widget.activeIndex;
    switch (widget.type) {
      case SliderType.list:
        viewportFraction = 1;
        height = 146.h;
        width = 314.w;
        fit = BoxFit.fitWidth;

        break;
      case SliderType.details:
        viewportFraction = 0.9;
        height = 282.h;
        width = 333.w;
        fit = BoxFit.fitWidth;

        break;
      case SliderType.dialog:
        viewportFraction = 1;
        height = 262.h;
        width = 262.h;
        fit = BoxFit.cover;

        break;
      case SliderType.item:
        viewportFraction = 0.9;
        height = 100.h;
        width = 198.w;
        fit = BoxFit.fitWidth;

        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.urlImagesList.length,
      carouselController: widget.controller,
      options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          initialPage: widget.initPage ?? 0,
          viewportFraction: viewportFraction!,
          enableInfiniteScroll: false,
          reverse: false,
          height: 250.h,
          onPageChanged: (index, reason) {
            setState(() {
              activeIndex = index;
              widget.index!(activeIndex);
            });
          }),
      itemBuilder: (context, index, real) {
        if (widget.urlImagesList[index].type == 1) {
          return ImageWidget(
            height: height!,
            width: width!,
            fit: fit!,
            image: widget.urlImagesList[index].imageFile!,
          );
        } else {
          return VideoWidget(
            height: height!,
            width: width!,
            fit: fit!,
            image: widget.urlImagesList[index].imageFile!,
          );
        }
      },
    );
  }
}
