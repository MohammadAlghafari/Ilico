import 'package:charja_charity/core/ui/widgets/Coustom_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';

class NotificationListItem extends StatelessWidget {
  NotificationListItem(
      {Key? key,
      required this.image,
      required this.index,
      required this.title,
      required this.supTitle,
      required this.time,
      this.type})
      : super(key: key);
  final String? image;
  final int? index;
  final String? title;
  final String? supTitle;
  final String? time;
  int? type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 16.h),
      tileColor: type != 1
          ? AppColors.kWhiteColor
          : AppColors.kPOrangeColor.withOpacity(0.1),
      leading: CircleAvatar(
          radius: 26.r,
          backgroundColor: AppColors.kMediumColor,
          child: Image.asset(image!, fit: BoxFit.contain)),
      title: Text(
        title!,
        style: AppTheme.headline5.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: type != 1 || index! > 1
          ? RichText(
              text: TextSpan(
                  text: supTitle,
                  style: index! <= 1
                      ? AppTheme.subtitle2.copyWith()
                      : AppTheme.subtitle1.copyWith(),
                  children: [
                    TextSpan(
                      text: time,
                      style: AppTheme.subtitle1.copyWith(
                          color: index! <= 1
                              ? AppColors.kPOrangeColor
                              : AppColors.kBlackColor),
                      //recognizer: new TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                    ),
                  ]),
            )
          : Column(
              children: [
                RichText(
                  text: TextSpan(
                      text: supTitle,
                      style: index! <= 1
                          ? AppTheme.subtitle2.copyWith()
                          : AppTheme.subtitle1.copyWith(),
                      children: [
                        TextSpan(
                          text: time,
                          style: AppTheme.subtitle1.copyWith(
                              color: index! <= 1
                                  ? AppColors.kPOrangeColor
                                  : AppColors.kBlackColor),
                          //recognizer: new TapGestureRecognizer()..onTap = () => print('Tap Here onTap'),
                        ),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CoustomButton(
                      width: 100.w,
                      // height: 40.h,
                      backgoundColor: AppColors.kWhiteColor,
                      borderSideColor: AppColors.kGreyLight,
                      borderRadius: 20.r,
                      function: () {},
                      widgetContent: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            AcceptIcon,
                            color: AppColors.kSDarkGreenColor,
                          ),
                          Text(
                            "Accept",
                            style: AppTheme.subtitle2
                                .copyWith(color: AppColors.kSDarkGreenColor),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    CoustomButton(
                      backgoundColor: AppColors.kWhiteColor,
                      borderSideColor: AppColors.kGreyLight,
                      borderRadius: 20.r,
                      width: 100.w,
                      // height: 40.h,
                      function: () {},
                      widgetContent: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            DeclineIcon,
                            color: AppColors.kBlackColor,
                          ),
                          Text(
                            "Decline",
                            style: AppTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
      trailing: index! <= 1
          ? Container(
              height: 10.h,
              width: 10.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: AppColors.kPOrangeColor),
            )
          : const SizedBox(
              width: 0.01,
              height: 0.01,
            ),
    );
  }
}
