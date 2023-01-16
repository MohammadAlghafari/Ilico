import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../user_managment/widgets/social_media_widget.dart';

class MyContent extends StatefulWidget {
  const MyContent({Key? key, required this.userInfo, required this.callBack}) : super(key: key);
  final ProfileInfluencerModel? userInfo;
  final ValueChanged callBack;
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: 'My Content',
        withBackButton: true,
        action: [
          IconButton(
              onPressed: () {
                if (selectedTabIndex == 1) {
                  //TODO Push To New Article Screen
                } else {
                  print(selectedTabIndex);
                }
              },
              icon: SvgPicture.asset(addIcon))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.kWhiteProfileCardIconArea,
            child: TabBar(
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              indicatorColor: AppColors.kPDarkBlueColor,
              padding: EdgeInsets.zero,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              onTap: (int index) {
                selectedTabIndex = index;
              },
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              labelColor: Colors.black,
              unselectedLabelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
              labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
              tabs: [
                Tab(
                  child: Text(
                    'Social networks',
                  ),
                ),
                Tab(
                  child: Text(
                    'Articles',
                  ),
                ),
                Tab(
                  child: Text(
                    'Gallery',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SocialMediaWidget(
                      btnName: "Save",
                      model: widget.userInfo,
                      callback: widget.callBack,
                    ),
                  ),
                ),
                Container(),
                Container(),
                // SocialMediaWidget(
                //   btnName: "Save",
                // ),
                // SocialMediaWidget(btnName: "Save"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
