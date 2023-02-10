import 'package:carousel_slider/carousel_slider.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/models/imageOrVideosFileType.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/widgets/image_and_name_widget.dart';
import '../widget/article_dialog.dart';
import '../widget/carousel_slider_widget.dart';
import '../widget/indicator_widget.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key}) : super(key: key);

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final CarouselController controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    FileTypeImageOrVideos(type: 1, imageFile: 'assets/images/article.png', imageType: "file"),
    FileTypeImageOrVideos(type: 1, imageFile: 'assets/images/article.png', imageType: "file"),
    FileTypeImageOrVideos(type: 1, imageFile: 'assets/images/article.png', imageType: "file")
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
          // appBarHeight: 100.h,
          titleWidget: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: const [
                ImageAndNameWidget(
                  scale: 9,
                  minWidth: 9,
                  maxHeight: 9,
                  name: 'Ethel Bechtelar',
                ),
              ],
            ),
          ),
          title: "",
          withBackButton: true,
          action: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 0.5.h,
                color: AppColors.kGreyLight,
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 19.h),
                  child: CarouselSliderWidget(
                    index: (index) {
                      activeIndex = index;
                      setState(() {});
                    },
                    activeIndex: activeIndex,
                    urlImagesList: urlImages,
                    type: SliderType.details,
                    controller: controller,
                  ),
                ),
                onTap: () {
                  AppCustomAlertDialog.dialog(
                      widget: ArticleDialog(
                        imageOrVideosList: [
                          FileTypeImageOrVideos(type: 1, imageFile: 'assets/images/article.png', imageType: "file"),
                          FileTypeImageOrVideos(type: 1, imageFile: 'assets/images/article.png', imageType: "file"),
                          FileTypeImageOrVideos(type: 1, imageFile: 'assets/images/article.png', imageType: "file")
                        ],
                      ),
                      context: context);
                },
              ),
              IndicatorWidget(controller: controller, urlImagesList: urlImages, activeIndex: activeIndex),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Repellendus sit modi',
                      style: AppTheme.subtitle2.copyWith(fontSize: 20, color: AppColors.kPDarkBlueColor),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      '12th March 2023 ',
                      style: AppTheme.bodyText1.copyWith(fontSize: 14, color: AppColors.kGrayTextField),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      '12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 12th March 2023 ',
                      style: AppTheme.bodyText1.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum SliderType { list, details, dialog, item }
