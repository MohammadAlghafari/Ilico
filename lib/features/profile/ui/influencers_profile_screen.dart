import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/influncer_general_information_usecase.dart';
import 'package:charja_charity/features/profile/ui/articleTabFoImfluncer.dart';
import 'package:charja_charity/features/profile/ui/galleryTabForInfluncer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/boilerplate/get_model/widgets/get_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/loading.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../search/data/model/search_model.dart';
import '../data/model/influncer_general_information_model.dart';
import '../data/profile_repository/profile_repository.dart';
import '../widgets/category_item.dart';
import '../widgets/social_media_count.dart';

class InfluencersProfileScreen extends StatefulWidget {
  final SearchOfServiceProvider? data;
  final bool isMyProfile;

  const InfluencersProfileScreen({Key? key, required this.data, required this.isMyProfile}) : super(key: key);

  @override
  _InfluencersProfileScreenState createState() => _InfluencersProfileScreenState();
}

class _InfluencersProfileScreenState extends State<InfluencersProfileScreen> with SingleTickerProviderStateMixin {
  late List<Widget> action = [];
  late TabController tabController;

  List<Widget> setAction() {
    action = [
      // FavoriteWidget(
      //   isFavorite: (widget.data!.isFav!),
      //   id: widget.data!.id!,
      //   onChange: (value) {
      //     if (value) {
      //       widget.data!.isFav = !widget.data!.isFav!;
      //       setAction();
      //       setState(() {});
      //     }
      //   },
      //   type: 'Influencer',
      // ),
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 22.w),
      //   child: ShareWidget(id: widget.data!.id!, role: CashHelper.getData(key: userType)),
      // ),
    ];
    return action;
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    action = setAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetModel(
          onSuccess: (InfluncerGeneralInformationModel model) {
            if (widget.isMyProfile == false) {
              //  action = setAction();
            } else {
              // action = setMyProfileAction(isAva: model.isAvailable);
              // print(";;;;;;;;;;;;;;;;${model.isAvailable}");
            }
            setState(() {});
            print(model);
          },
          useCaseCallBack: () {
            if (CashHelper.authorized) {
              //For User
              return InfluncerGeneralInformationUseCase(ProfileRepository()).call(
                  params: InfluncerGeneralInformationParams(
                      id: widget.data!.id!, query: getInfluncerGeneralInfomationByIDQueriesUser));
            } else {
              //For Guest
              return InfluncerGeneralInformationUseCase(ProfileRepository()).call(
                  params: InfluncerGeneralInformationParams(
                      id: widget.data!.id!, query: getInfluncerGeneralInfomationByIDQueriesGuest));
            }
          },
          loading: const LoadingIndicator(),
          modelBuilder: (InfluncerGeneralInformationModel model) {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBarWidget(
                  title: "${model.generalInformation!.fullName}",
                  action: action,
                  withBackButton: true,
                ),
                body: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                                      isInfluencer: true,
                                      minHeight: 100,
                                      minWidth: 100,
                                      strokeWidth: 3,
                                      radius: 100,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.kPDarkBlueColor,
                                          AppColors.kSFlashyGreenColor,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      photoUrl: model.photoUrl,
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
                                              style:
                                                  AppTheme.subtitle2.copyWith(fontSize: 17, color: AppColors.kDimBlue),
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
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  // Text(
                                  //   //TODO add translation
                                  //   /* !isInfluencer ? '${model.company!.job} at ${model.company!.name}' : */
                                  //   '2 km away',
                                  //   style: AppTheme.bodyText1.copyWith(fontSize: 14),
                                  // ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  SizedBox(
                                    width: 200.w,
                                    child: SocialMediaCount(
                                      assets1: 'assets/icons/instagram.svg',
                                      text1: '${model.instagramFollowers}',
                                      assets2: 'assets/icons/app.svg',
                                      text2: '${model.tiktokFollowers}',
                                      assets3: 'assets/icons/app2.svg',
                                      text3: '${model.facebookFollowers}',
                                      assets4: 'assets/icons/youtube.svg',
                                      text4: '${model.youtubeFollowers}',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [
                                      ...model.categories!
                                          .map((activites) => CategoryWidget(
                                                categoryName: activites.name!,
                                              ))
                                          .toList(),
                                      // const CategoryWidget(categoryName: "test"),
                                      // SizedBox(width: 10.w),
                                      // const CategoryWidget(categoryName: "test"),
                                    ],
                                  ),

                                  // /*!isInfluencer
                                  //     ? widget.data!.generalInformation!.distance != null
                                  //         ? */Text(
                                  //             //TODO add translation
                                  //             '${widget.data!.generalInformation!.distance!.floor()} km away, Available',
                                  //             style: AppTheme.bodyText1.copyWith(fontSize: 14),
                                  //           )
                                  //         /*: const SizedBox.shrink()*/
                                  //     : const SocialMediaCount(
                                  //         assets1: 'assets/icons/instagram.svg',
                                  //         text1: '55k',
                                  //         assets2: 'assets/icons/app.svg',
                                  //         text2: '30k',
                                  //         assets3: 'assets/icons/app2.svg',
                                  //         text3: '20k',
                                  //         assets4: 'assets/icons/youtube.svg',
                                  //         text4: '20k',
                                  //       ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 27),
                      //   child: /*model.company!.description != null*/ true
                      //       ? Text(
                      //           /*'${model.company!.description}'*/
                      //           "test",
                      //           style: AppTheme.bodyText1.copyWith(fontSize: 12),
                      //         )
                      //       : SizedBox(),
                      // ),
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
                          unselectedLabelStyle:
                              AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                          labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
                          tabs: [
                            Tab(
                              child: Text(
                                'Articles'.tr(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Reviews'.tr(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Gallery '.tr(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Collaborations'.tr(),
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
                            // ServicesTabForServiceProvider(id: widget.data!.id!),
                            // // Container(),
                            // ProductsTabForServiceProvider(id: widget.data!.id!),
                            ArticleTabForInfluncer(id: widget.data!.id!),
                            // EventTabForServiceProvider(id: widget.data!.id!),
                            //gallary
                            Container(),
                            GalleryTabForInfluncer(id: widget.data!.id!),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
