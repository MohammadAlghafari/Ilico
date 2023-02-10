import 'package:carousel_slider/carousel_controller.dart';
import 'package:charja_charity/core/models/imageOrVideosFileType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../ui/article_details.dart';
import 'carousel_slider_widget.dart';

class ArticleDialog extends StatefulWidget {
  const ArticleDialog({Key? key, required this.imageOrVideosList, this.initIndex}) : super(key: key);
  final List<FileTypeImageOrVideos>? imageOrVideosList;
  final int? initIndex;

  @override
  State<ArticleDialog> createState() => _ArticleDialogState();
}

class _ArticleDialogState extends State<ArticleDialog> {
  final CarouselController controller = CarouselController();
  int activeIndex = 0;
  @override
  void initState() {
    activeIndex = widget.initIndex!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 326.h,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Container(
            height: 326.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () {
                          previousPage.call();
                          setState(() {});
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: activeIndex > 0 ? AppColors.kBlackColor : AppColors.kGreyLight,
                          size: 18,
                        )),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      width: 262.w,
                      height: 262.w,
                      child: CarouselSliderWidget(
                        initPage: widget.initIndex ?? 0,
                        activeIndex: activeIndex,
                        urlImagesList: widget.imageOrVideosList!,
                        controller: controller,
                        type: SliderType.dialog,
                        index: (index) {
                          activeIndex = index;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.kPDarkBlueColor,
                              size: 20,
                            )),
                        SizedBox(
                          height: 107.h,
                        ),
                        InkWell(
                            onTap: () {
                              nextPage.call();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: activeIndex == widget.imageOrVideosList!.length - 1
                                  ? AppColors.kGreyLight
                                  : AppColors.kBlackColor,
                              size: 18,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nextPage() => controller.nextPage(duration: const Duration(milliseconds: 500));
  void previousPage() => controller.previousPage(duration: const Duration(milliseconds: 500));
}
