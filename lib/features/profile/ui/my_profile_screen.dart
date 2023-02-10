import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/core/http/graphQl_provider.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/Notifications/ui/notifications_Screen.dart';
import 'package:charja_charity/features/profile/ui/update_category_screen.dart';
import 'package:charja_charity/features/search/data/model/search_model.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/boilerplate/get_model/widgets/get_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/sheet/coustom_sheet.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../../core/utils/language_helper.dart';
import '../../../core/utils/located_my_location.dart';
import '../../Contact_Policy/ui/FAQ_Screen.dart';
import '../../Contact_Policy/ui/contact_Us_Screen.dart';
import '../../Contact_Policy/ui/privacy_Policy_Screen.dart';
import '../../Contact_Policy/ui/termsAndConditions.dart';
import '../../user_managment/data/model/logout_model.dart';
import '../../user_managment/data/repository/auth_repository.dart';
import '../../user_managment/data/usecase/logout_usecase.dart';
import '../../user_managment/ui/reset_password_screen.dart';
import '../data/model/profile_model.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/profile_usecase.dart';
import '../widgets/share_profile_widget.dart';
import 'businessContent.dart';
import 'edit_profile_screen.dart';
import 'influencers_profile_screen.dart';
import 'my_content.dart';
import 'my_favorite_screen.dart';
import 'service_provider_profile_screen.dart' as ps;

class MyProfile extends StatefulWidget {
  final VoidCallback? function;

  const MyProfile({Key? key, this.function}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
          title: 'Profile'.tr(),
          action: [
            buildActionWidget(context),
          ],
          appBarHeight: 64.h,
          withBackButton: false,
          leadingWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SvgPicture.asset(
              logo_White,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: GetModel(
            onSuccess: (UserInfo model) {},
            useCaseCallBack: () {
              print(CashHelper.getData(key: userType));
              return ProfileUseCase(ProfileRepository()).call(params: ProfileParams());
            },
            modelBuilder: (UserInfo model) {
              return ProfileScreen(
                role: CashHelper.getRole()!,
                function: widget.function!,
                profileModel: model,
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget buildActionWidget(context) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: InkWell(
          onTap: () {
            AppCustomAlertDialog.alertDialog(
                context: context,
                widget: Padding(
                  padding: EdgeInsets.symmetric(vertical: 29.h),
                  child: const ShareProfileWidget(),
                ));
          },
          child: SvgPicture.asset(qrCode)));
}

class ProfileScreen extends StatefulWidget {
  final UserInfo profileModel;
  final VoidCallback function;
  final String role;

  const ProfileScreen({Key? key, required this.role, required this.profileModel, required this.function})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserInfo? profileModel;

  get role => CashHelper.getRole();

  @override
  void initState() {
    profileModel = widget.profileModel;
    super.initState();
  }

  @override
  void dispose() {
    profileModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(
          color: AppColors.kGreyLight,
          thickness: 1,
        ),
        SizedBox(
          height: 25.h,
        ),
        UnicornOutlineButton(
          minWidth: 78,
          minHeight: 78,
          strokeWidth: 2,
          radius: 200,
          photoUrl: profileModel!.photoUrl,
          onPressed: () {},
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          (profileModel?.generalInformation?.firstName)!,
          style: AppTheme.headline2.copyWith(color: AppColors.kPDarkBlueColor),
        ),
        SizedBox(
          height: 16.h,
        ),
        InkWell(
          onTap: () {
            Navigation.push(EditProfileScreen(
              callBack: (model) {
                profileModel = model;
                setState(() {});
              },
              function: () {
                setState(() {});
              },
              profileModel: profileModel,
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.kPDarkBlueColor), borderRadius: BorderRadius.circular(10)),
            width: 160.w,
            height: 40.h,
            child: Center(
              child: Text('Edit Profile'.tr(),
                  style: AppTheme.subtitle2.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14)),
            ),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        getWidget(role: widget.role, modell: profileModel!),
        SizedBox(
          height: 24.h,
        ),
        Container(
            width: 336.w,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
            child: Column(
              children: [
                ItemProfile(
                  onTap: () {
                    CustomSheet.show(
                        isDismissible: false,
                        // title: "Verify Mobile Number".tr(),
                        context: context,
                        child: LanguageWidget());
                    // Navigation.push(const LanguageScreen());
                  },
                  assets: question,
                  title: 'Language'.tr(),
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(const FAQScreen());
                  },
                  assets: question,
                  title: 'FAQ'.tr(),
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(ContactUsScreen());
                  },
                  assets: contactUs,
                  title: 'Contact Us / Claims'.tr(),
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(const PrivacyPolicyScreen());
                  },
                  assets: privacyPolicy,
                  title: 'Privacy policy'.tr(),
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(const TermsAndConditionsScreen());
                  },
                  assets: terms,
                  title: 'Terms and conditions'.tr(),
                ),
              ],
            )),
        SizedBox(
          height: 24.h,
        ),
        Container(
          width: 336.w,
          //  height: 133.h,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
          child: ItemProfile(
            onTap: () {
              return AppCustomAlertDialog.dialog(
                  widget: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: 300.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          'Log out'.tr(),
                          style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Text(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            'Are you sure you would like log out of your account?'.tr(),
                            style: AppTheme.subtitle1.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        const Divider(
                          color: AppColors.kLightColor,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: CoustomButton(
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                  buttonName: "Cancel".tr(),
                                  backgoundColor: AppColors.kWhiteColor,
                                  borderSideColor: AppColors.kPDarkBlueColor,
                                  borderRadius: 10.0.r,
                                ),
                              ),
                              SizedBox(
                                width: 24.w,
                              ),
                              Expanded(
                                child: CreateModel(
                                  onSuccess: (LogOutModel result) {
                                    if (result.message.isNotEmpty) {
                                      Navigator.pop(context);
                                      setState(() {});
                                      CashHelper.removeLoginData();
                                      try {
                                        CubeChatConnection.instance.logout();
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }
                                      GraphQlProvider.setQlLink(auth: false);
                                      widget.function.call();
                                    }
                                  },
                                  withValidation: false,
                                  useCaseCallBack: (model) {
                                    return LogOutUseCase(AuthRepository()).call(params: LogOutParams());
                                  },
                                  child: CoustomButton(
                                    // function: () {
                                    //
                                    //
                                    // },
                                    buttonName: 'Log out'.tr(),
                                    backgoundColor: AppColors.kWhiteColor,
                                    borderSideColor: AppColors.kPDarkBlueColor,
                                    borderRadius: 10.0.r,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  context: context);
            },
            assets: logout,
            title: 'Log out'.tr(),
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }

  getWidget({required String role, required UserInfo modell}) {
    if (CashHelper.getRole() == 'Customer') {
      return const ProfileCustomerWidget();
    } else if (CashHelper.getRole() == 'Influencer') {
      return ProfileInflencerWidget(
        user: modell,
        callBack: (model) {
          profileModel = model;
          setState(() {});
        },
      );
    } else if (CashHelper.getRole() == 'ServiceProvider') {
      return ProfileServicePWidget(
        profileModel: modell as ProfileSpModel,
      );
    }
  }
}

class ProfileCustomerWidget extends StatelessWidget {
  const ProfileCustomerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Container(
        width: 336.w,
        //  height: 133.h,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
        child: Column(
          children: [
            ItemProfile(
              assets: activityIcon,
              title: "My Categories".tr(),
              onTap: () {
                Navigation.push(UpdateCategoryScreen());
              },
            ),
            const Divider(
              color: AppColors.kGreyLight,
            ),
            ItemProfile(
              assets: heart,
              title: 'My favourites'.tr(),
              onTap: () {
                Navigation.push(MyFavoriteScreen());
              },
            ),
            const Divider(
              color: AppColors.kGreyLight,
            ),
            ItemProfile(
              assets: notificationIcon,
              title: 'Notifications'.tr(),
            ),
            const Divider(
              color: AppColors.kGreyLight,
            ),
            ItemProfile(
              onTap: () {
                Navigation.push(ResetPasswordScreen());
              },
              assets: password,
              title: 'Password and security'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInflencerWidget extends StatelessWidget {
  const ProfileInflencerWidget({Key? key, required this.user, required this.callBack}) : super(key: key);
  final UserInfo user;
  final ValueChanged callBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Column(
        children: [
          Container(
            width: 336.w,
            //  height: 133.h,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
            child: Column(
              children: [
                ItemProfile(
                  assets: profile,
                  title: 'My profile'.tr(),
                  onTap: () {
                    Navigation.push(InfluencersProfileScreen(
                        isMyProfile: true,
                        data: SearchOfServiceProvider(
                          userType: CashHelper.getRole(), id: user.id, isSelected: false, isFav: false,
                          //TODO Add Fav to Influencers Profile Screen
                        )));
                  },
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: activityIcon,
                  title: "My Categories".tr(),
                  onTap: () {
                    Navigation.push(UpdateCategoryScreen());
                  },
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: heart,
                  title: 'My favourites'.tr(),
                  onTap: () {
                    Navigation.push(MyFavoriteScreen());
                  },
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                InkWell(
                  onTap: () {
                    Navigation.push(MyContent(
                      userInfo: user as ProfileInfluencerModel,
                      callBack: callBack,
                    ));
                  },
                  child: ItemProfile(
                    assets: content,
                    title: 'My content'.tr(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Container(
              width: 336.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
              child: Column(
                children: [
                  ItemProfile(
                    onTap: () {
                      Navigation.push(const NotificationsScreen());
                    },
                    assets: notificationIcon,
                    title: 'Notifications'.tr(),
                  ),
                  const Divider(
                    color: AppColors.kGreyLight,
                  ),
                  ItemProfile(
                    onTap: () {
                      Navigation.push(ResetPasswordScreen());
                    },
                    assets: password,
                    title: 'Password and security'.tr(),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class ProfileServicePWidget extends StatefulWidget {
  ProfileSpModel profileModel;

  ProfileServicePWidget({Key? key, required this.profileModel}) : super(key: key);

  @override
  State<ProfileServicePWidget> createState() => _ProfileServicePWidgetState();
}

class _ProfileServicePWidgetState extends State<ProfileServicePWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Column(
        children: [
          Container(
            width: 336.w,
            //  height: 133.h,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
            child: Column(
              children: [
                ItemProfile(
                  assets: profile,
                  title: 'My profile'.tr(),
                  onTap: () {
                    if (CashHelper.getData(key: LATITUDE) == null && CashHelper.getData(key: LONGITUDE) == null) {
                      LocatedMyLocation.determinePosition();
                    } else {
                      Navigation.push(ps.ServiceProviderProfileScreen(
                          isMyProfile: true,
                          data: SearchOfServiceProvider(
                            userType: CashHelper.getRole(),
                            id: widget.profileModel.id,
                            isAvailable: widget.profileModel.isAvailable,
                            isEventProgress: widget.profileModel.isEventProgress,
                            isFav: true,
                            isSelected: false,
                            generalInformation: GeneralInformation(distance: 1.0),
                          )));
                    }
                  },
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: activityIcon,
                  title: "My activities".tr(),
                  onTap: () {
                    Navigation.push(UpdateCategoryScreen(
                      //TODO add number of activities to Categories screen
                      categoryNumber: widget.profileModel.activityCount,
                    ));
                  },
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: job,
                  title: 'Jobs alerts'.tr(),
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: heart,
                  title: 'My favourites'.tr(),
                  onTap: () {
                    Navigation.push(MyFavoriteScreen());
                  },
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(BusinessContent(
                      valueChanged: (b) {},
                      profileModel: widget.profileModel,
                      callBack: (model) {
                        widget.profileModel.companyModel = model;
                        setState(() {});
                      },
                    ));
                  },
                  assets: content,
                  title: 'Business content'.tr(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Container(
              width: 336.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
              child: Column(
                children: [
                  ItemProfile(
                    onTap: () {
                      Navigation.push(const NotificationsScreen());
                    },
                    assets: notificationIcon,
                    title: 'Notifications'.tr(),
                  ),
                  const Divider(
                    color: AppColors.kGreyLight,
                  ),
                  ItemProfile(
                    onTap: () {
                      Navigation.push(ResetPasswordScreen());
                    },
                    assets: password,
                    title: 'Password and security'.tr(),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class ItemProfile extends StatelessWidget {
  ItemProfile({required this.assets, required this.title, this.onTap});

  final String assets;
  final String title;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 19.h),
        child: Row(
          children: [
            SvgPicture.asset(
              assets,
              color: AppColors.kPDarkBlueColor,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              title,
              style: AppTheme.subtitle2.copyWith(fontSize: 16, color: AppColors.kPDarkBlueColor),
            )
          ],
        ),
      ),
    );
  }
}

class LanguageSheet extends StatefulWidget {
  late final bool isSelectedLang;
  final String title;
  Function(bool) onChange;

  LanguageSheet({Key? key, required this.isSelectedLang, required this.title, required this.onChange})
      : super(key: key);

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.title == 'English') {
          context.setLocale(LanguageHelper.kEnglishLocale);
        } else {
          context.setLocale(LanguageHelper.kFranceLocale);
        }
        widget.onChange(!widget.isSelectedLang);
        setState(() {});
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.67.w),
            child: Container(
              width: 23.w,
              height: 23.h,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: widget.isSelectedLang ? AppColors.kPDarkBlueColor : AppColors.kGrayBorder),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: widget.isSelectedLang ? AppColors.kPDarkBlueColor : Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            (widget.title),
            style: AppTheme.subtitle2.copyWith(
                color: widget.isSelectedLang ? AppColors.kPDarkBlueColor : AppColors.kGrayBorder, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  List<String> lang = ['English', 'French'];

  // String selectedItem = 'English';
  bool isSelected = false;
  int selectedIndex = 0;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.locale == LanguageHelper.kEnglishLocale) {
      lang[0] = 'English';
      selectedIndex = 0;
    } else {
      lang[1] = 'French';
      selectedIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(children: [
        Text(
          'Select language',
          style: AppTheme.headline2.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 20),
        ),
        SizedBox(
          height: 42.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 35.h),
              padding: EdgeInsets.zero,
              itemCount: lang.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return LanguageSheet(
                  onChange: (val) {
                    selectedIndex = index;
                    isSelected = val;
                    setState(() {});
                  },
                  isSelectedLang: selectedIndex == index,
                  title: lang[index],
                );
              }),
        ),
        SizedBox(
          height: 20.h,
        ),
        const Divider(
          thickness: 1,
          endIndent: 20,
          indent: 20,
          color: AppColors.kLightColor,
        ),
        SizedBox(
          height: 38.h,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: CoustomButton(
                  function: () {
                    Navigation.pop();
                  },
                  buttonName: "OK",
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0.r,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
