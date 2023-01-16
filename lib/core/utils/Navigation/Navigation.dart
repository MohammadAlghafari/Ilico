import 'package:charja_charity/core/ui/root_screen/root_screen.dart';
import 'package:charja_charity/features/user_managment/ui/login_screen.dart';
import 'package:flutter/cupertino.dart';

import '../Keys.dart';

class Navigation {
  static Future? popThenPush(Widget page) async {
    Navigation.pop();
    return await Navigation.push(page);
  }

  static Future? push(Widget page) async {
    if (Keys.navigatorKey.currentContext != null) {
      return await Navigator.push(
        Keys.navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => page),
      );
    }
  }

  static pop({dynamic value}) async {
    Navigator.pop(Keys.navigatorKey.currentContext!, value);
  }

  static Future? pushReplacement(Widget page) async {
    while (Navigator.canPop(Keys.navigatorKey.currentContext!)) {
      Navigation.pop();
    }
    return await Navigator.pushReplacement(
      Keys.navigatorKey.currentContext!,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future? pushAndRemoveUntil(Widget page) async {
    return await Navigator.pushAndRemoveUntil(
        Keys.navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (BuildContext context) => page),
        (Route<dynamic> route) => false);
  }

  static goToHome() {
    while (Navigator.canPop(Keys.navigatorKey.currentContext!)) {
      Navigation.pop();
    }

    ///TODO Navigation to home page
    Navigation.pushAndRemoveUntil(RootScreen());
  }

  static goToLogin() {
    Navigation.push(const LoginScreen());
    // while (Navigator.canPop(Keys.navigatorKey.currentContext!)) {
    //   Navigation.pop();
    // }
  }
}
