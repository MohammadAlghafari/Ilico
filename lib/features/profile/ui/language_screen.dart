import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/language_helper.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> lang = ['en', 'fr'];
  String selectedItem = 'en';
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.locale == LanguageHelper.kEnglishLocale) {
      selectedItem = 'en';
    } else {
      selectedItem = 'fr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        action: [],
        title: 'Language'.tr(),
        appBarHeight: 60.h,
        withBackButton: true,
      ),
      body: Column(
        children: [
          const Divider(
            color: AppColors.kGreyLight,
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            child: SizedBox(
              // width: 100.w,
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.kMediumColor, width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabled: true,
                    fillColor: AppColors.kLightColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                    ),
                  ),
                  value: selectedItem,
                  items: lang
                      .map((e) => DropdownMenuItem(
                            onTap: () {
                              if (e == 'en') {
                                context.setLocale(LanguageHelper.kEnglishLocale);
                              } else {
                                context.setLocale(LanguageHelper.kFranceLocale);
                              }
                            },
                            value: e,
                            child: Text(
                              e,
                              style: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 20),
                            ),
                          ))
                      .toList(),
                  onChanged: (item) {
                    setState(() {
                      selectedItem = item!;
                    });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
