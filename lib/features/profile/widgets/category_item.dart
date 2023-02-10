import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
    required this.categoryName,
  }) : super(key: key);
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 30.h,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kWhiteColor,
          border: Border.all(color: AppColors.kLightColor)),
      child: Center(
          child: Text(categoryName,
              textAlign: TextAlign.center, softWrap: false, style: AppTheme.subtitle2.copyWith(fontSize: 14))),
    );
  }
}
