import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../utils/Keys.dart';

class Dialogs {
  static showSnackBar({required String message, AnimatedSnackBarType typeSnackBar = AnimatedSnackBarType.success}) {
    return AnimatedSnackBar.material(message, type: typeSnackBar).show(Keys.navigatorKey.currentContext!);
  }

  static showErrorSnackBar({required String message, AnimatedSnackBarType typeSnackBar = AnimatedSnackBarType.error}) {
    return AnimatedSnackBar.material(message, type: typeSnackBar).show(Keys.navigatorKey.currentContext!);
  }

  static showQuestion(context,
      {String? title, String? subtitle, Widget? content, VoidCallback? btnOkOnPress, VoidCallback? btnCancelOnPress}) {
    AwesomeDialog(
      context: Keys.navigatorKey.currentContext!,
      // dialogType: DialogType.QUESTION,
      headerAnimationLoop: false,
      animType: AnimType.topSlide,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
      btnCancelText: 'Cancel',
      btnOkText: 'Ok',

      body: Column(
        children: [
          ListTile(
            title: Text(
              title!,
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              subtitle!,
              textAlign: TextAlign.start,
            ),
          ),
          content!,
        ],
      ),
    ).show();
  }
}
