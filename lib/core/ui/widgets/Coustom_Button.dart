import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CoustomButton extends StatelessWidget {
  String? buttonName;
  double? height;
  double? width;
  Color? backgoundColor;
  Color? borderSideColor;
  double? borderRadius;
  VoidCallback? function;
  Widget? widgetContent;
  //double? width;

  CoustomButton(
      {super.key,
      this.buttonName,
      this.height,
      this.width,
      required this.backgoundColor,
      required this.borderSideColor,
      required this.borderRadius,
      this.function,
      this.widgetContent});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(4)),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(width ?? double.infinity, height ?? 50.h),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          backgoundColor!,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            side: BorderSide(color: borderSideColor!, width: 1),
          ),
        ),
      ),
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: widgetContent ??
            Text(buttonName!,
                textAlign: TextAlign.center, style: AppTheme.button.copyWith(color: AppColors.kPDarkBlueColor)),
      ),
    );
  }
}
