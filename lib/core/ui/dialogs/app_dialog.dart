import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/ui/widgets/Coustom_Button.dart';
import 'package:charja_charity/core/ui/widgets/coustomDialog.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog {
  AppDialog({
    this.cancel,
    this.Confirm,
    this.isHaveCancel,
    this.body,
    this.function,
    this.height,
    this.buildContext,
    this.btnWidth,
  });
  final bool? isHaveCancel;
//  final bool? isHaveConfirm;
  String? cancel = "Cancel";
  String? Confirm = "Ok";
  final Widget? body;
  final Function? function;
  final double? height;
  final BuildContext? buildContext;
  double? btnWidth;

  showDialog(context) {
    return CoustomDialog(
      context: context,
      body: body,
      actionButton: isHaveCancel!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  //height: 55.h,
                  // width: 114.w,
                  child: CoustomButton(
                    buttonName: cancel != null ? cancel : "Cancel",
                    backgoundColor: AppColors.kWhiteColor,
                    borderSideColor: AppColors.kPDarkBlueColor,
                    borderRadius: 10.0,
                    width: btnWidth ?? 114.w,
                    function: () {
                      Navigation.pop();
                    },
                  ),
                ),
                SizedBox(width: 24.w),
                Expanded(
                  //height: 55.h,
                  //width: 114.w,
                  child: CoustomButton(
                    buttonName: Confirm != null ? Confirm : "Ok",
                    backgoundColor: AppColors.kWhiteColor,
                    borderSideColor: AppColors.kPDarkBlueColor,
                    borderRadius: 10.0,
                    width: btnWidth ?? 114.w,
                    function: () {
                      //  Navigation.pop();
                    },
                  ),
                )
              ],
            )
          : Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: SizedBox(
                height: 55.h,
                // width: 114.w,
                child: CoustomButton(
                  buttonName: Confirm != null ? Confirm : "Ok",
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0,
                  width: btnWidth ?? 114.w,
                  function: () => function!.call(),
                ),
              ),
            ),
    );
  }
}

class AppCustomAlertDialog {
  static Future dialog({required Widget widget, required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            child: widget,
          );
        });
  }

  static Future alertDialog({required BuildContext context, required Widget widget}) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              titlePadding: const EdgeInsets.only(top: 5, bottom: 5),
              contentPadding: const EdgeInsets.only(top: 20, bottom: 35, left: 10, right: 10),
              title: widget);
        });
  }
}
