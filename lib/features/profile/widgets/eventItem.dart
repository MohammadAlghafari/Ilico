import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class EventItem extends StatefulWidget {
  const EventItem({Key? key}) : super(key: key);

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
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
                    Text('Event name long text', style: AppTheme.subtitle2.copyWith(fontSize: 14)),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Thu, Apr 19 · 20.00 Pm',
                      style: AppTheme.subtitle2.copyWith(fontSize: 12, color: AppColors.kPDarkBlueColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Ipsum enim eos. Aliquam odit quaerat laudan tium quia culpa autem adipisci.',
                      style: AppTheme.subtitle2.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
