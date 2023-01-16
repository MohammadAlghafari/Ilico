import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static TextTheme textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    subtitle1: subtitle1,
    subtitle2: subtitle2,
    bodyText2: bodyText2,
    bodyText1: bodyText1,
    button: button,
    // caption: caption,
    // overline: overLine,
  );
  static const String fontGeometry = 'Geometry Soft Pro';
  static const String font = fontGeometry;

  static const String fontJost = 'Jost';
  static const String bodyFont = fontJost;

  static TextStyle headline1 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    // letterSpacing: 0.4,
    // height: 42,
    color: AppColors.kBlackColor,
  );

  static TextStyle headline2 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: 0.4,
    // height: 34,
    color: AppColors.kBlackColor,
  );
  static TextStyle headline3 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    // letterSpacing: 0.4,
    // height: 30,
    color: AppColors.kBlackColor,
  );

  static TextStyle headline4 = const TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: font,
    fontSize: 16,
    // height: 26,
    color: AppColors.kBlackColor,
  );

  static TextStyle headline5 = const TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: font,
    fontSize: 14,
    letterSpacing: 0.4,
    // height: 18,
    color: AppColors.kBlackColor,
  );

  //appbar title
  static TextStyle headline6 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 0.18,
    color: AppColors.kBlackColor,
  );

  ///TEXT DESCRIPTION//
  static TextStyle subtitle1 = const TextStyle(
    fontFamily: bodyFont,
    fontWeight: FontWeight.w300,
    // height: 17.32,
    fontSize: 12,
    color: AppColors.kBlackColor,
  );

  ///  TEXT TITLE///
  static TextStyle subtitle2 = const TextStyle(
    fontFamily: bodyFont,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    // height: 17.34,
    color: AppColors.kBlackColor,
  );

  ///BODY 3 LIGHT///
  static TextStyle bodyText1 = const TextStyle(
    fontFamily: bodyFont,
    fontWeight: FontWeight.w300,
    fontSize: 16,
    // height: 24,
    color: AppColors.kBlackColor,
  );

  ///FIELD TEXT PLACEHOLDER///
  static TextStyle bodyText2 = const TextStyle(
    fontFamily: bodyFont,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    // height: 22,
    color: AppColors.kBlackColor,
  );

  static TextStyle button = const TextStyle(
    fontFamily: bodyFont,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    // height: 24,
    color: AppColors.kBlackColor,
  );
}
