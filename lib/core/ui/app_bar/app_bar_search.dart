import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double? appBarHeight;
  final List<Widget> action;

  const AppBarSearch({Key? key, required this.title, this.appBarHeight, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      centerTitle: false,
      title: title,
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight ?? 64);
}
