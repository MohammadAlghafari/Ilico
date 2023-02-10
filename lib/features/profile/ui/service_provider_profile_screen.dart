import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/profile/bloc/profile_cubit.dart';
import 'package:charja_charity/features/profile/data/model/sp_general_information_model.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_general_information_usecase.dart';
import 'package:charja_charity/features/profile/ui/ArticleTabForServiceProvider.dart';
import 'package:charja_charity/features/profile/ui/galleryTabForServiceProvider.dart';
import 'package:charja_charity/features/profile/ui/productsTabForServiceProvider.dart';
import 'package:charja_charity/features/profile/ui/servicesTabForServiceProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/favorite_widget.dart';
import '../../../core/ui/widgets/share_widget.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';
import '../../search/data/model/search_model.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/queries.dart';
import '../data/use_case/toggel_isAvaliable_usecase.dart';
import '../widgets/category_item.dart';
import '../widgets/my_profile_appbar.dart';
import 'eventTabForServiceProvider.dart';

class ServiceProviderProfileScreen extends StatefulWidget {
  const ServiceProviderProfileScreen({Key? key, this.data, required this.isMyProfile}) : super(key: key);
  final SearchOfServiceProvider? data;
  final bool isMyProfile;

  @override
  State<ServiceProviderProfileScreen> createState() => _ServiceProviderProfileScreenState();
}

class _ServiceProviderProfileScreenState extends State<ServiceProviderProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isInfluencer = false; //todo role
  late List<Widget> action = [];
  late PaginationCubit cubitService;
  bool isAvaliable = false;

  List<Widget> setAction() {
    action = [
      FavoriteWidget(
        isFavorite: (widget.data!.isFav!),
        id: widget.data!.id!,
        onChange: (value) {
          if (value) {
            widget.data!.isFav = !widget.data!.isFav!;
            setAction();
            setState(() {});
          }
        },
        type: 'ServiceProvider',
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: ShareWidget(id: widget.data!.id!, role: widget.data!.userType!),
      ),
    ];
    return action;
  }

  List<Widget> setMyProfileAction({bool? isAva}) {
    action = [
      IsAvaliableWidget(
        onChange: (val) {
          if (val) {
            print(isAva);
            isAva = !(isAva!);
            setMyProfileAction(isAva: isAva);
            setState(() {});
          }
        },
        isAvaliable: isAva!,
      )
    ];
    return action;
  }

  @override
  void initState() {
    super.initState();
    //  setMyProfileAction();
    tabController = TabController(length: 7, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetModel(
        onSuccess: (SPGeneralInformationModel model) {
          if (widget.isMyProfile == false) {
            action = setAction();
          } else {
            action = setMyProfileAction(isAva: model.isAvailable);
            print(";;;;;;;;;;;;;;;;${model.isAvailable}");
          }
          setState(() {});
          print(model);
        },
        useCaseCallBack: () {
          if (CashHelper.authorized) {
            //For User
            return SPGeneralInformationUseCase(ProfileRepository()).call(
                params: SPGeneralInformationParams(
                    id: widget.data!.id!,
                    latitude: CashHelper.getData(key: LATITUDE),
                    longitude: CashHelper.getData(key: LONGITUDE),
                    query: getServiceProviderGeneralInfoByIDQueriesUser));
          } else {
            //For Guest
            return SPGeneralInformationUseCase(ProfileRepository()).call(
                params: SPGeneralInformationParams(
                    id: widget.data!.id!,
                    latitude: CashHelper.getData(key: LATITUDE),
                    longitude: CashHelper.getData(key: LONGITUDE),
                    query: getServiceProviderGeneralInfoByIDQueriesGuest));
          }
        },
        loading: const LoadingIndicator(),
        modelBuilder: (SPGeneralInformationModel model) {
          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: !widget.isMyProfile
                  ? MyProfileAppBar(
                      profileInfo: model,
                    )
                  : SizedBox(),
              backgroundColor: AppColors.kWhiteColor,
              appBar: AppBarWidget(
                title: model.generalInformation?.fullName,
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
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w),
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  UnicornOutlineButton(
                                    isInfluencer: false,
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
                                    photoUrl: model.photoUrl,
                                    onPressed: () {},
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 13.h, left: 2.w),
                                      child: Container(
                                        height: 16.w,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                          color: (widget.data?.isAvailable != null && widget.data!.isAvailable!)
                                              ? AppColors.kSFlashyGreenColor
                                              : AppColors.kGreyDark,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 3),
                                        ),
                                      ),
                                    ),
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
                                  //TODO add translation
                                  '${model.company!.job} ,${widget.data!.generalInformation!.distance!.floor()} km away',
                                  style: AppTheme.bodyText1.copyWith(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 6.h,
                                      width: 6.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (widget.data!.isAvailable != null && widget.data!.isAvailable!)
                                              ? AppColors.kSDarkGreenColor
                                              : AppColors.kGreyDark),
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      "Available",
                                      style: AppTheme.subtitle2.copyWith(
                                          fontSize: 12,
                                          color: (widget.data!.isAvailable != null && widget.data!.isAvailable!)
                                              ? AppColors.kSDarkGreenColor
                                              : AppColors.kGreyDark),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                (widget.data!.isEventProgress != null && widget.data!.isEventProgress!)
                                    ? Text(
                                        "Event in progress",
                                        style:
                                            AppTheme.subtitle2.copyWith(fontSize: 12, color: AppColors.kPDarkBlueColor),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    ...model.activities!
                                        .map((activites) => CategoryWidget(
                                              categoryName: activites.name!,
                                            ))
                                        .toList(),
                                    // const CategoryWidget(),
                                    // SizedBox(width: 10.w),
                                    // const CategoryWidget(),
                                  ],
                                )
                              ],
                            )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/certify.png',
                            scale: 3,
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: model.company!.description != null
                          ? Text(
                              '${model.company!.description}',
                              style: AppTheme.bodyText1.copyWith(fontSize: 12),
                            )
                          : SizedBox(),
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
                        unselectedLabelStyle:
                            AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                        labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
                        tabs: [
                          Tab(
                            child: Text(
                              'Services'.tr(),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Products'.tr(),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Reviews'.tr(),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Events'.tr(),
                            ),
                          ),
                          Tab(
                            child: Text('Gallery'.tr()),
                          ),
                          Tab(
                            child: Text(
                              'Articles '.tr(),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Collaborations '.tr(),
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
                          ServicesTabForServiceProvider(id: widget.data!.id!),
                          // Container(),
                          ProductsTabForServiceProvider(id: widget.data!.id!),
                          Container(),
                          EventTabForServiceProvider(id: widget.data!.id!),
                          GalleryTabForServiceProvider(id: widget.data!.id!), //gallary
                          ArticleTabForServiceProvider(id: widget.data!.id!),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Divider buildDivider() => const Divider(color: AppColors.kBottomNavGray, endIndent: 18, indent: 18);
}

class IsAvaliableWidget extends StatefulWidget {
  IsAvaliableWidget({required this.isAvaliable, this.onChange});
  late bool isAvaliable;
  final ValueChanged<bool>? onChange;

  @override
  State<IsAvaliableWidget> createState() => _IsAvaliableWidgetState();
}

class _IsAvaliableWidgetState extends State<IsAvaliableWidget> {
  ProfileCubit cubit = ProfileCubit();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubit,
      listener: (context, state) {
        if (state is IsAvaliableSuccess) {
          widget.onChange!(true);
          print("lllllllllllllllllll${widget.isAvaliable}");
        }
      },
      builder: (BuildContext context, state) {
        if (state is IsAvaliableLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Center(child: LoadingIndicator()),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: FlutterSwitch(
            width: 33,
            height: 20,
            activeColor: AppColors.kPDarkBlueColor,
            inactiveColor: AppColors.kMediumColor,
            // valueFontSize: 25.0,
            toggleSize: 13,
            value: widget.isAvaliable,
            borderRadius: 16.0,
            //padding: 8.0,
            //  showOnOff: true,
            onToggle: (val) {
              cubit.isAvaliabletoggle(params: ToggleIsAvaliableParams());
              setState(() {
                // widget.isAvaliable = val;
              });
            },
          ),
        );
      },
    );
  }
}
