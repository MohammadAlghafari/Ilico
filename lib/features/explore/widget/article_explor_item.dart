import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:charja_charity/core/models/imageOrVideosFileType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../ui/article_details.dart';
import 'Indicator_widget.dart';
import 'carousel_slider_widget.dart';

class ArticleExplorItem extends StatefulWidget {
  final double? width;
  final double? height;
  bool fromListArticle;
  ArticleExplorItem({Key? key, this.width, this.height, required this.fromListArticle}) : super(key: key);

  @override
  State<ArticleExplorItem> createState() => _ArticleExplorItemState();
}

class _ArticleExplorItemState extends State<ArticleExplorItem> {
  int activeIndex = 0;
  final urlImages = [
    FileTypeImageOrVideos(type: 1, imageFile: File('assets/images/article.png')),
    FileTypeImageOrVideos(type: 1, imageFile: File('assets/images/article.png')),
    FileTypeImageOrVideos(type: 1, imageFile: File('assets/images/article.png'))
  ];
  late CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 198.w,
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.kGreyLight), borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.fromListArticle ? 314 : 198.w,
            height: widget.fromListArticle ? 146.h : 100.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            child: widget.fromListArticle
                ? CarouselSliderWidget(
                    index: (index) {
                      activeIndex = index;
                      setState(() {});
                    },
                    type: SliderType.list,
                    controller: _controller,
                    activeIndex: activeIndex,
                    urlImagesList: urlImages,
                  )
                : Image.asset('assets/images/article.png', fit: BoxFit.fitWidth),
          ),
          widget.fromListArticle
              ? SizedBox(
                  height: 15.h,
                )
              : SizedBox(),
          widget.fromListArticle
              ? IndicatorWidget(controller: _controller, urlImagesList: urlImages, activeIndex: activeIndex)
              : SizedBox(),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.fromListArticle
                    ? Text(
                        'Repellendus sit modi',
                        style: AppTheme.subtitle2.copyWith(fontSize: 16, color: AppColors.kPDarkBlueColor),
                      )
                    : SizedBox(),
                widget.fromListArticle
                    ? SizedBox(
                        height: 10.h,
                      )
                    : SizedBox(),
                Text(
                  'Voluptatem et saepe rem vero. Dolore soluta repellat qui ipsam nesciunt labore est neque laboriosam. Est adipisci facilis',
                  style: AppTheme.bodyText1.copyWith(fontSize: 12),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10.h,
                ),
                !widget.fromListArticle
                    ? Text(
                        'Read more',
                        style: AppTheme.subtitle2.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          color: AppColors.kPDarkBlueColor,
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ImageAndNameWidget(
                      scale: 10,
                      minWidth: 10,
                      maxHeight: 10,
                      name: 'Ethel Bechtelar',
                    ),
                    widget.fromListArticle
                        ? Text(
                            'Read more',
                            style: AppTheme.subtitle2.copyWith(fontSize: 14, color: AppColors.kPDarkBlueColor),
                          )
                        : const SizedBox()
                  ],
                ),
                widget.fromListArticle
                    ? SizedBox(
                        height: 10.h,
                      )
                    : const SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
