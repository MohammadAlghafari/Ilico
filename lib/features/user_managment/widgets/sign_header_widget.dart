import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SignHeader extends StatelessWidget {
  const SignHeader({
    super.key,
    required this.child,
    this.height,
  });
  final double? height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kPDarkBlueColor,
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/roads.png",
                  fit: BoxFit.cover,
                ),
              )),
          child,
        ],
      ),
    );
  }
}
