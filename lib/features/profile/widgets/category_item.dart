import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77.w,
      height: 30.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kWhiteColor,
          border: Border.all(color: AppColors.kLightColor)),
      child: Center(child: Text('Category', style: AppTheme.subtitle2.copyWith(fontSize: 14))),
    );
  }
}
