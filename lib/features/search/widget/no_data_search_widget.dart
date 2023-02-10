import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/Search_Text_filled.dart';
import '../../../core/utils/Navigation/Navigation.dart';

class NoResultDataWidget extends StatefulWidget {
  final bool showSearchField;
  const NoResultDataWidget({Key? key, required this.showSearchField}) : super(key: key);

  @override
  State<NoResultDataWidget> createState() => _NoResultDataWidgetState();
}

class _NoResultDataWidgetState extends State<NoResultDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: double.infinity, child: Image.asset(backgroungSearch, fit: BoxFit.fitWidth)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: AppColors.kGreyLight)),
                  //height: 253.h,
                  width: 338.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 36.21.h,
                      ),
                      Image.asset(LoopPngIcon, scale: 5),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Oops... counld not find any matches'.tr(),
                        style: AppTheme.subtitle2.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 2.h),
                              child: CoustomButton(
                                buttonName: "Submit a job".tr(),
                                backgoundColor: AppColors.kWhiteColor,
                                borderSideColor: AppColors.kPDarkBlueColor,
                                borderRadius: 10.0.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          color: Colors.transparent,
          margin: EdgeInsets.only(top: 100.h),
          child: widget.showSearchField
              ? SearchTextFilled(
                  isShowFilter: false,
                  onTap: () {
                    Navigation.pop();
                  },
                )
              : const SizedBox(
                  height: 0.01,
                  width: 0.01,
                ),
        ),
      ],
    );
  }
}
