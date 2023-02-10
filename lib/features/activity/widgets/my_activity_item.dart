import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/features/activity/ui/job_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';
import '../../../core/utils/Navigation/Navigation.dart';

class MyActivityItem extends StatelessWidget {
  const MyActivityItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: InkWell(
        onTap: () {
          Navigation.push(const JobDetailsScreen());
        },
        child: Container(
          height: 142.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kGreyLight),
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(16.h),
                child: UnicornOutlineButton(
                  minHeight: 100.h,
                  minWidth: 100.h,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.kPDarkBlueColor,
                      AppColors.kSFlashyGreenColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  onPressed: () {},
                  photoUrl: null,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Text(
                        '00/00/0000',
                        style: AppTheme.subtitle1,
                      ),
                    ),
                    Text(
                      'Spencer Smith',
                      style: AppTheme.bodyText2,
                    ),
                    Text(
                      'Service name long texttt ttttttttttt ttttttttttt ttttt t tt  ttt ttt',
                      style: AppTheme.subtitle1.copyWith(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const TagWidget(
                          text: 'Done',
                          color: AppColors.kLightGreen,
                          textColor: AppColors.kSDarkGreenColor,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 16.w),
                          child: Text(
                            'Add',
                            style: AppTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({Key? key, required this.color, required this.text, required this.textColor}) : super(key: key);

  final Color color;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTheme.subtitle2.copyWith(color: textColor),
        ),
      ),
    );
  }
}
