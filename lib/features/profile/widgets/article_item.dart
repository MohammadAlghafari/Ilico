import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                width: 80.w,
                // height: 80.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset('assets/images/image.png'),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Article title long text', style: AppTheme.subtitle2.copyWith(fontSize: 14)),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      '12th March 2023',
                      style: AppTheme.bodyText1.copyWith(fontSize: 8, color: AppColors.kGrayTextField),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      'Ipsum enim eos. Aliquam odit quaerat laudan tium quia culpa autem adipisci.',
                      style: AppTheme.bodyText1.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
