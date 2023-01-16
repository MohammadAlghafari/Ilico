import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class IndicatorWidget extends StatefulWidget {
  const IndicatorWidget({Key? key, required this.controller, required this.urlImagesList, required this.activeIndex})
      : super(key: key);
  final CarouselController controller;
  final List urlImagesList;
  final int activeIndex;

  @override
  State<IndicatorWidget> createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.urlImagesList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => widget.controller.animateToPage(entry.key),
          child: Container(
            width: 5.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? AppColors.kGrayIndicator
                        : AppColors.kBottomNavGray)
                    .withOpacity(widget.activeIndex == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
