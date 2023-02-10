import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/activity/ui/activity_screen.dart';
import 'package:charja_charity/features/inbox/ui/inbox_screen.dart';
import 'package:charja_charity/features/profile/ui/my_profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../features/add_section/ui/add_section.dart';
import '../../../features/explore/ui/explore_screen.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_styles.dart';
import '../../utils/located_my_location.dart';
import 'authorized_page.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int selectedIndex = 0;
  bool menuClicked = false;
  late TabController tabController;

  @override
  void initState() {
    // CashHelper.removeData(key: LATITUDE);
    // CashHelper.removeData(key: LONGITUDE);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (CashHelper.getData(key: LATITUDE) == null && CashHelper.getData(key: LONGITUDE) == null) {
        LocatedMyLocation.determinePosition();
      }
      print("Latitude :${CashHelper.getData(key: LATITUDE)}");
      print("Longitude :${CashHelper.getData(key: LONGITUDE)}");
    });

    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          children: <Widget>[
            ExploreScreen(),
            const CheckAuthPage(
              loggedInWidget: ActivityScreen(),
            ),
            const CheckAuthPage(
              loggedInWidget: AddSectionScreen(),
            ),
            const CheckAuthPage(
              loggedInWidget: InboxScreen(),
            ),
            CheckAuthPage(
              loggedInWidget: MyProfile(
                function: () {
                  setState(() {});
                },
              ),
            ),
          ],
          onPageChanged: (value) {
            setState(() {
              selectedIndex = value;
              tabController.animateTo(value);
            });
          },
        ),
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            shadowColor: Colors.white,
            elevation: 0,
            style: TabStyle.fixedCircle,
            color: AppColors.kBottomNavGray,
            activeColor: AppColors.kPDarkBlueColor,
            backgroundColor: AppColors.kWhiteColor,
            controller: tabController,
            height: 75.h,
            items: [
              TabItem(
                  icon: SvgPicture.asset(
                    exploreIcon,
                    color: selectedIndex == 0 ? AppColors.kPDarkBlueColor : AppColors.kBottomNavGray,
                  ),
                  title: 'Explore'),
              TabItem(
                  icon: SvgPicture.asset(
                    activityIcon,
                    color: selectedIndex == 1 ? AppColors.kPDarkBlueColor : AppColors.kBottomNavGray,
                  ),
                  title: 'Activity'),
              TabItem(
                  icon: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanDown: (details) {
                      setState(() {
                        menuClicked = true;
                        selectedIndex = 2;
                      });
                    },
                    child: PopupMenuButton<int>(
                      padding: EdgeInsets.zero,
                      onCanceled: () {
                        setState(() {
                          menuClicked = false;
                        });
                      },
                      onSelected: (int selected) {
                        setState(() {
                          menuClicked = false;
                        });
                      },
                      itemBuilder: (context) => [
                        // popupmenu item 1
                        PopupMenuItem(
                          value: 1,

                          // row has two child icon and text.
                          child: Row(
                            children: const [
                              Icon(Icons.star),
                              SizedBox(
                                // sized box with width 10
                                width: 10,
                              ),
                              Text("Get The App")
                            ],
                          ),
                        ),
                        // popupmenu item 2
                        PopupMenuItem(
                          value: 2,

                          // row has two child icon and text
                          child: Row(
                            children: const [
                              Icon(Icons.chrome_reader_mode),
                              SizedBox(
                                // sized box with width 10
                                width: 10,
                              ),
                              Text("About")
                            ],
                          ),
                        ),
                      ],
                      offset: const Offset(-50, -120),
                      color: Colors.white,
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: selectedIndex == 2 ? AppColors.kPDarkBlueColor : AppColors.kBottomNavGray)
                            // boxShadow: const [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     blurRadius: 4,
                            //     offset: Offset(0, 4), // Shadow position
                            //   ),
                            // ]
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: SvgPicture.asset(
                            menuClicked ? closeIcon : plusIcon,
                            height: 5,
                            color: selectedIndex == 2 ? AppColors.kPDarkBlueColor : AppColors.kBottomNavGray,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: 'Plus'),
              TabItem(
                  icon: SvgPicture.asset(
                    chatIcon,
                    color: selectedIndex == 3 ? AppColors.kPDarkBlueColor : AppColors.kBottomNavGray,
                  ),
                  title: 'Inbox'),
              TabItem(
                  icon: SvgPicture.asset(
                    profileIcon,
                    color: selectedIndex == 4 ? AppColors.kPDarkBlueColor : AppColors.kBottomNavGray,
                  ),
                  title: 'Profile'),
            ],
            onTap: (int i) {
              print('press $i');
              selectedIndex = i;
              _controller.jumpToPage(i);
              setState(() {});
            },
          ),
        ));
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return AppTheme.subtitle2.copyWith(
      fontSize: 10,
      color: color,
    );
  }
}
