import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/core/utils/form_utils/form_state_mixin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../search/ui/search_result_list_view.dart';
import '../widgets/sign_header_widget.dart';

class SPSingUpServices extends StatefulWidget {
  const SPSingUpServices({Key? key}) : super(key: key);

  @override
  _SPSingUpServicesState createState() => _SPSingUpServicesState();
}

class _SPSingUpServicesState extends State<SPSingUpServices> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(startLine),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(Icon_Steps),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(centerLine),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(iconFilled),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Subscriptions".tr(),
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Services".tr(),
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
          padding: EdgeInsets.symmetric(horizontal: 27.h),
          child: Form(
            key: form.key,
            child: Column(
              children: [
                //TODO Move To Home Page
                InkWell(
                  onTap: () {
                    Navigation.push(SearchListViewScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    //width: 50,
                    width: 1.sw,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColors.kMediumColor, width: 0.5),
                        color: AppColors.kWhiteColor),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            search,
                          ),
                        ),
                        Text(
                          "Search a service...".tr(),
                          style: AppTheme.headline5.copyWith(color: AppColors.kGrayTextField.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                ),
                CustomTextField(
                  labelText: 'Add your first service'.tr(),
                  labelStyle: AppTheme.bodyText2,
                  hintText: 'Add your first service'.tr(),
                  textEditingController: form.controllers[0],
                  focusNode: form.nodes[0],
                  nextFocusNode: form.nodes[1],
                ),
                CustomTextField(
                  labelText: 'Service’s price'.tr(),
                  labelStyle: AppTheme.bodyText2,
                  hintText: '00.00',
                  textEditingController: form.controllers[1],
                  focusNode: form.nodes[1],
                  nextFocusNode: form.nodes[2],
                  suffixIcon: SvgPicture.asset(euro),
                  isSuffixIcon: true,
                ),
                CustomTextField(
                  labelText: 'Service’s description'.tr(),
                  labelStyle: AppTheme.bodyText2,
                  hintText: 'Type service description here...'.tr(),
                  textEditingController: form.controllers[2],
                  focusNode: form.nodes[2],
                  maxLine: 5,
                ),
                SizedBox(
                  height: 0.12.sh,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CoustomButton(
                          buttonName: "Confirm and continue".tr(),
                          backgoundColor: AppColors.kWhiteColor,
                          borderSideColor: AppColors.kPDarkBlueColor,
                          borderRadius: 10.0.r,
                          function: () {
                            //Navigation.push(SPSingUpServices());
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 3;
}
