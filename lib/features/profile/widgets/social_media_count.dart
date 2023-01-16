import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_styles.dart';

class SocialMediaCount extends StatelessWidget {
  final String assets1;
  final String assets2;
  final String assets3;
  final String assets4;
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  const SocialMediaCount({
    Key? key,
    required this.assets1,
    required this.assets2,
    required this.text3,
    required this.assets4,
    required this.assets3,
    required this.text1,
    required this.text2,
    required this.text4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(assets1),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text1,
              style: AppTheme.subtitle2.copyWith(fontSize: 12),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(assets2),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text2,
              style: AppTheme.subtitle2.copyWith(fontSize: 12),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(assets3),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text3,
              style: AppTheme.subtitle2.copyWith(fontSize: 12),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(assets4),
            SizedBox(
              width: 5.w,
            ),
            Text(
              text4,
              style: AppTheme.subtitle2.copyWith(fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}
