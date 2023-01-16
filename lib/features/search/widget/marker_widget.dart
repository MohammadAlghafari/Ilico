import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/widgets/view_profile_card.dart';

class MarkerItem extends StatefulWidget {
  final bool isSelected;

  const MarkerItem({Key? key, required this.isSelected}) : super(key: key);

  @override
  State<MarkerItem> createState() => _MarkerItemState();
}

class _MarkerItemState extends State<MarkerItem> {
  bool get isSelected => widget.isSelected;

  bool get isGold => true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: isSelected ? 98.h : 91.h,
        height: isSelected ? 98.h : 91.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.kGoldColor, width: 3),
                ),
                child: UnicornOutlineButton(
                  minWidth: isSelected ? 80.h : 74.h,
                  minHeight: isSelected ? 80.h : 74.h,
                  strokeWidth: 3,
                  radius: 200,
                  gradient: LinearGradient(
                    colors: [
                      isSelected ? Colors.black : Colors.white,
                      isSelected ? Colors.black : Colors.white
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  onPressed: null,
                  child: SizedBox(
                      width: isSelected ? 78.h : 72.h,
                      height: isSelected ? 78.h : 72.h,
                      child: Image.asset(
                        'assets/images/Rectangle.png',
                        fit: BoxFit.contain, /*scale: isSelected ? 6 : 6.3*/
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 13.h, left: 2.w),
                child: Container(
                  height: 19.w,
                  width: 19.w,
                  decoration: BoxDecoration(
                    color: AppColors.kSDarkGreenColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(1.3, -0.5),
              child: Padding(
                padding: EdgeInsets.only(top: 13.h, left: 2.w),
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
                height: isSelected ? 18 : 13,
                width: 12,
                child: Image.asset(
                  isSelected ? polygonSelected : polygonUnSelected,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ));
  }
}
