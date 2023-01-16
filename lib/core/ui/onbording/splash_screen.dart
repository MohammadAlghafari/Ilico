import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/ui/onbording/onboarding_screen.dart';
import 'package:charja_charity/core/ui/root_screen/root_screen.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:flutter/material.dart';

import '../../constants/end_point.dart';
import '../../utils/cashe_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (CashHelper.getData(key: firstTimeOpenApp) == null) {
        Navigation.pushReplacement(OnboardigScreen());
      } else {
        //TODO add Navigation to Login Screen
        Navigation.pushReplacement(const RootScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.kWhiteColor,
      child: Center(
          child: Image.asset(
        logo_dark,
      )),
    ));
  }
}
