import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../widgets/favorite_type_widget.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'My Favorites'.tr(),
        action: [],
        appBarHeight: 64.h,
        withBackButton: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 45.h,
            width: double.infinity,
            color: AppColors.kLightColor.withOpacity(0.5),
            child: TabBar(
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              indicatorColor: AppColors.kPDarkBlueColor,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              onTap: (int index) {
                print(index);
              },
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              labelColor: Colors.black,
              unselectedLabelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
              labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
              tabs: [
                Tab(
                  child: Text(
                    'Influencers'.tr(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Service providers'.tr(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                FavoriteTypeWidget(
                  type: "Influencer",
                ),
                FavoriteTypeWidget(
                  type: 'ServiceProvider',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
