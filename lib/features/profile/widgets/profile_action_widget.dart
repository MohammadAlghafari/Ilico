import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ProfileActionWidget extends StatelessWidget {
  final String assets;
  final String text;
  const ProfileActionWidget({Key? key, required this.text, required this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 27.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(assets),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: AppTheme.subtitle2.copyWith(fontSize: 16, color: AppColors.kPDarkBlueColor),
          )
        ],
      ),
    );
  }
}
