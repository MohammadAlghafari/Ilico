import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_styles.dart';
import '../widgets/Coustom_Button.dart';
import '../widgets/coustomDialog.dart';

class LocatedPermissionDialog extends StatelessWidget {
  const LocatedPermissionDialog();
  // final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return CoustomDialog(
      context: context,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            logo_dark,
            width: 60.w,
            height: 60.w,
          ),
          Text(
            "Geolocation authorisation",
            style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
          ),
          Text(
            "Illico1 uses location services in order to determine proximity of listed services providers and only while you are connecting on our website",
            style: AppTheme.headline5,
            textAlign: TextAlign.center,
          )
        ],
      ),
      actionButton: Row(
        children: [
          Expanded(
            child: CoustomButton(
                buttonName: "Enable to locate me",
                backgoundColor: AppColors.kWhiteColor,
                borderSideColor: AppColors.kPDarkBlueColor,
                borderRadius: 10.0,
                function: () async {
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
                  //    Navigation.pop();
                }),
          ),
        ],
      ),
      //height: 338.h,
    );
  }
}
