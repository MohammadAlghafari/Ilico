import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';
import '../data/model/search_model.dart';

class MarkerItem extends StatefulWidget {
  final bool isSelected;
  final SearchOfServiceProvider serviceItem;

  const MarkerItem({Key? key, required this.isSelected, required this.serviceItem}) : super(key: key);

  @override
  State<MarkerItem> createState() => _MarkerItemState();
}

class _MarkerItemState extends State<MarkerItem> {
  // bool get isSelected => widget.isSelected;

  bool get isGold => true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.isSelected ? 98.h : 91.h,
        height: widget.isSelected ? 98.h : 91.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // width: isSelected ? 80.h : 74.h,
                // height: isSelected ? 80.h : 74.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: (widget.serviceItem.isEventProgress != null && widget.serviceItem.isEventProgress!)
                          ? AppColors.kGoldColor
                          : Colors.transparent,
                      width: 5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: widget.isSelected ? AppColors.kBlackColor : AppColors.kWhiteColor, width: 3),
                  ),
                  child: UnicornOutlineButton(
                      isSelecte: widget.isSelected,
                      isMarker: true,
                      isInfluencer: false,
                      minWidth: widget.isSelected ? 65.h : 57.h,
                      minHeight: widget.isSelected ? 65.h : 57.h,
                      strokeWidth: 5,
                      radius: 200,
                      // gradient: LinearGradient(
                      //   colors: [
                      //     !widget.isSelected ? Colors.black : Colors.white,
                      //     !widget.isSelected ? Colors.black : Colors.white
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                      onPressed: () {
                        widget.isSelected != !widget.isSelected;
                      },
                      photoUrl: widget.serviceItem.photoUrl),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 13.h,
                    left: !widget.isSelected
                        ? (widget.serviceItem.isEventProgress != null && widget.serviceItem.isEventProgress!)
                            ? 3.w
                            : 10.w
                        : (widget.serviceItem.isEventProgress != null && widget.serviceItem.isEventProgress!)
                            ? 0.w
                            : 4.w),
                child: Container(
                  height: widget.isSelected ? 22.w : 16.w,
                  width: widget.isSelected ? 22.w : 16.w,
                  decoration: BoxDecoration(
                    color: widget.serviceItem.isAvailable! ? AppColors.kSFlashyGreenColor : AppColors.kGreyDark,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(1, -0.8),
              child: Padding(
                padding: EdgeInsets.only(top: 13.h, left: 3.w),
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    //border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Center(
                      child: Text(
                    '4.5',
                    style: AppTheme.subtitle2,
                  )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 20,
                width: 12,
                child: Image.asset(
                  widget.isSelected ? polygonSelected : polygonUnSelected,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ));
  }
}
