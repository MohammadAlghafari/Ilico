import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/ui/app_bar/app_bar_search.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../../core/utils/located_my_location.dart';
import '../../search/ui/search_result_list_view.dart';
import '../widget/chip_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isSelected = false;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarSearch(
          appBarHeight: 80.h,
          title: Row(
            children: [
              Image.asset(logoSearch, scale: 5),
              Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () {
                      LocatedMyLocation.determinePosition();
                      /* Navigation.push(PopUpLocation(
                              position: LatLng(CashHelper.getData(key: LATITUDE), CashHelper.getData(key: LONGITUDE)),
                            ));*/
                    },
                    child: Row(
                      children: [
                        Text(
                          '64 Rue Haute, Brussels',
                          style: AppTheme.subtitle2.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.kPDarkBlueColor,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          action: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SvgPicture.asset(notificationIcon, height: 20),
            ),
          ],
        ),
        body: Stack(
          children: [
            SizedBox(width: double.infinity, child: Image.asset(backgroungSearch, fit: BoxFit.fitWidth)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h, left: 32.w, right: 32.w, bottom: 6),
                  child: Container(
                    width: 336.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChipWidget(
                            callBack: (bool value) {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            label: 'Service'.tr(),
                            isSelected: selectedIndex == 1,
                          ),
                          ChipWidget(
                            callBack: (bool value) {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                            label: 'Product'.tr(),
                            isSelected: selectedIndex == 2,
                          ),
                          ChipWidget(
                            callBack: (bool value) {
                              setState(() {
                                selectedIndex = 3;
                              });
                            },
                            label: 'Event'.tr(),
                            isSelected: selectedIndex == 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (CashHelper.getData(key: LATITUDE) == null && CashHelper.getData(key: LONGITUDE) == null) {
                      LocatedMyLocation.determinePosition();
                    } else {
                      Navigation.push(SearchListViewScreen(
                        type: typeSelectes(selectedIndex),
                      ));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Container(
                      width: 336.w,
                      height: 55.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 19.w),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              search,
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            Text(
                              "Search a service...".tr(),
                              style: TextStyle(color: AppColors.kGrayTextField, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String typeSelectes(int isSelected) {
    if (isSelected == 1) {
      return 'Service';
    } else if (isSelected == 2) {
      return 'Product';
    } else if (isSelected == 3) {
      return 'Event';
    }
    return '';
  }
}
