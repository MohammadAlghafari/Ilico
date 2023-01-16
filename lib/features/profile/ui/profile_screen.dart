import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/sheet/coustom_sheet.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../widgets/category_item.dart';
import '../widgets/profile_action_widget.dart';
import '../widgets/social_media_count.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isInfluencer = false; //todo role
  late List<Widget> action = [];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 7, vsync: this, initialIndex: 0);
    if (isInfluencer) {
      action = [
        InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/heart.svg',
            )),
        InkWell(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: SvgPicture.asset(
            'assets/icons/share.svg',
          ),
        )),
      ];
    } else {
      action = [
        InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/heart.svg',
            )),
        InkWell(
            onTap: () {
              CustomSheet.show(
                  context: null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ProfileActionWidget(assets: 'assets/icons/flag.svg', text: 'Go to location'),
                      buildDivider(),
                      const ProfileActionWidget(assets: 'assets/icons/call.svg', text: 'Start a call'),
                      buildDivider(),
                      const ProfileActionWidget(assets: 'assets/icons/globe.svg', text: 'View website'),
                      buildDivider(),
                      const ProfileActionWidget(assets: 'assets/icons/share.svg', text: 'Share profile'),
                    ],
                  ));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: SvgPicture.asset(
                'assets/icons/more-vertical.svg',
              ),
            )),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(title: 'Spencer Smith', action: action),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            UnicornOutlineButton(
                              minHeight: 100,
                              minWidth: 100,
                              strokeWidth: 2,
                              radius: 100,
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.kPDarkBlueColor,
                                  AppColors.kSFlashyGreenColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              child: Image.asset('assets/images/Rectangle.png', scale: 4),
                              onPressed: () {},
                            ),
                            Positioned(
                              bottom: -5,
                              left: 18,
                              right: 18,
                              top: 77,
                              child: Container(
                                width: 70.w,
                                height: 28.45.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColors.kGreyWhite),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/star2.svg'),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      '4.0',
                                      style: AppTheme.subtitle2.copyWith(fontSize: 17, color: AppColors.kDimBlue),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            !isInfluencer ? 'Hairdresser at HairSalon' : '2 km away',
                            style: AppTheme.bodyText1.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          !isInfluencer
                              ? Text(
                                  '2 km away, Available',
                                  style: AppTheme.bodyText1.copyWith(fontSize: 14),
                                )
                              : const SocialMediaCount(
                                  assets1: 'assets/icons/instagram.svg',
                                  text1: '55k',
                                  assets2: 'assets/icons/app.svg',
                                  text2: '30k',
                                  assets3: 'assets/icons/app2.svg',
                                  text3: '20k',
                                  assets4: 'assets/icons/youtube.svg',
                                  text4: '20k',
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              const CategoryWidget(),
                              SizedBox(width: 10.w),
                              const CategoryWidget(),
                            ],
                          )
                        ],
                      )),
                  !isInfluencer
                      ? Expanded(
                          child: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/certify.png',
                            scale: 3,
                          ),
                        ))
                      : SizedBox(
                          width: 26.w,
                        )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27),
                child: Text(
                  'Reprehenderit ea illo culpa. Vitae commodi rem quia. Iusto repellat pariatur et dignissimos tempore. A deleniti eaque voluptatem iure labore dolorem vero velit nam.',
                  style: AppTheme.bodyText1.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
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
                  tabs: const [
                    Tab(
                      child: Text(
                        'Services',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Products',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Reviews',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Events',
                      ),
                    ),
                    Tab(
                      child: Text('Gallery'),
                    ),
                    Tab(
                      child: Text(
                        'Articles ',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Collaborations ',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider buildDivider() => const Divider(color: AppColors.kBottomNavGray, endIndent: 18, indent: 18);
}
