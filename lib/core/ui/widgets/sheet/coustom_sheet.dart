import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/utils/Keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSheet<T> extends StatelessWidget {
  const CustomSheet._(
      {Key? key,
      required this.child,
      this.title,
      this.onClose,
      this.closeButtonColor,
      this.headerStyle,
      this.isDismissible,
      this.topTitle})
      : super(key: key);

  final Widget child;
  final String? title;
  final Color? closeButtonColor;
  final TextStyle? headerStyle;
  final ValueChanged<BuildContext>? onClose;
  final bool? isDismissible;
  final double? topTitle;

  static Future<T?> show<T>({
    required BuildContext? context,
    required Widget child,
    String? title,
    bool addHeader = true,
    ValueChanged<BuildContext>? onClose,
    Color? closeButtonColor,
    TextStyle? headerStyle,
    double? topTitle,
    bool isDismissible = true,
  }) =>
      showModalBottomSheet<T>(
        context: context ?? Keys.navigatorKey.currentContext!,
        enableDrag: true,
        isDismissible: isDismissible,
        isScrollControlled: true,
        barrierColor: AppColors.kGrayTextField.withOpacity(0.5),
        //overlay color
        backgroundColor: AppColors.kWhiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r))),
        builder: (_) => CustomSheet._(
          title: title,
          onClose: onClose,
          closeButtonColor: closeButtonColor,
          headerStyle: headerStyle,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 0,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Padding(
                padding: EdgeInsets.only(top: topTitle ?? 23.h, bottom: 18.h),
                child: Text(
                  title!,
                  style: AppTheme.headline1.copyWith(fontSize: 20, color: AppColors.kPDarkBlueColor),
                ),
              ),
            Flexible(
              child: SingleChildScrollView(child: child),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget? closeWidget() => null;
}
