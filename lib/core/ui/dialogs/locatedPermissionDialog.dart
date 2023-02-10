import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_styles.dart';
import '../widgets/Coustom_Button.dart';
import '../widgets/coustomDialog.dart';

class LocatedPermissionDialog extends StatelessWidget {
  const LocatedPermissionDialog({required this.function});

  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return CoustomDialog(
      context: context,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            logo_White,
            width: 80.w,
            height: 80.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Geolocation authorisation".tr(),
            style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Illico1 uses location services in order to determine proximity of listed services providers and only while you are connecting on our website"
                .tr(),
            style: AppTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40.h,
          ),
        ],
      ),
      actionButton: Row(
        children: [
          Expanded(
            child: CoustomButton(
              buttonName: "Enable to locate me".tr(),
              backgoundColor: AppColors.kWhiteColor,
              borderSideColor: AppColors.kPDarkBlueColor,
              borderRadius: 10.0,
              function: () => function.call(),
              /*  function: () async {
                  // bool permissoin = await Geolocator.isLocationServiceEnabled();
                  // if (!permissoin) {
                  //   Geolocator.openLocationSettings().then((value) {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return PopUpLocation();
                  //         });
                  //   });
                  // } else {
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return PopUpLocation();
                  //       });
                  // }
                  //    Navigation.pop();*/
            ),
          )
        ],
      ),
      //height: 338.h,
    );
  }
}
