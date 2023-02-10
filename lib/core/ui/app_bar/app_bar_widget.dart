import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? appBarHeight;
  final bool? withBackButton;
  final List<Widget> action;
  final Widget? leadingWidget;
  final Color? backgroundColor;
  final Widget? titleWidget;
  final bool? isCenterTitle;
  final Function? onBackPress;
  final double? titleSpacing;
  const AppBarWidget(
      {Key? key,
      this.leadingWidget,
      this.onBackPress,
      this.titleWidget,
      this.isCenterTitle,
        this.titleSpacing,
      this.title,
      this.appBarHeight,
      required this.action,
      this.withBackButton,
      this.backgroundColor = Colors.white})
      : super(key: key);

  bool get withBack => withBackButton != null && withBackButton!;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      titleSpacing: titleSpacing,
      leading: withBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: AppColors.kPDarkBlueColor),
              onPressed: () {
                if (onBackPress != null) {
                  onBackPress?.call();
                }
                Navigator.pop(context);
              },
            )
          : leadingWidget ?? const SizedBox(),
      backgroundColor: backgroundColor,
      centerTitle: isCenterTitle ?? true,
      title: titleWidget ??
          Text(title!,
              style: AppTheme.headline3.copyWith(
                fontSize: 18,
                color: AppColors.kPDarkBlueColor,
              )),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 64);
}
