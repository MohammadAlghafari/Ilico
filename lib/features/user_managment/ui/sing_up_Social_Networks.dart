import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/user_managment/widgets/social_media_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../widgets/sign_header_widget.dart';

class SingUpSocialNetworks extends StatefulWidget {
  const SingUpSocialNetworks({Key? key}) : super(key: key);

  @override
  _SingUpSocialNetworksState createState() => _SingUpSocialNetworksState();
}

class _SingUpSocialNetworksState extends State<SingUpSocialNetworks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 232.h,
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back),
        centerTitle: true,
        //  title:
        flexibleSpace: SignHeader(
          // height: 283.h,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 34.w,
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 34.w,
                    ),
                    Text(
                      "Create your account".tr(),
                      style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Icon_Steps),
                        Image.asset(centerLine),
                        Image.asset(iconFilled),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Influencer profile".tr(),
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Social networks".tr(),
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: SocialMediaWidget(
            btnName: "Confirm".tr(),
            callback: (m) {},
          ),
        ),
      ),
    );
  }
}
