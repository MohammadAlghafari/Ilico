import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/constants/end_point.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/ui/widgets/view_profile_card.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/Notifications/ui/notifications_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/boilerplate/get_model/widgets/get_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../Contact_Policy/ui/FAQ_Screen.dart';
import '../../Contact_Policy/ui/contact_Us_Screen.dart';
import '../../Contact_Policy/ui/privacy_Policy_Screen.dart';
import '../../Contact_Policy/ui/termsAndConditions.dart';
import '../../user_managment/data/repository/auth_repository.dart';
import '../../user_managment/data/usecase/logout_usecase.dart';
import '../data/model/profile_model.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/profile_usecase.dart';
import '../widgets/category_item.dart';
import 'businessContent.dart';
import 'edit_profile_screen.dart';
import 'my_content.dart';

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
          title: 'Profile',
          action: [
            buildActionWidget(context),
          ],
          appBarHeight: 64.h,
          withBackButton: false,
          leadingWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Image.asset(logo_White, scale: 6),
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
                  child: Column(
                    children: [
                      UnicornOutlineButton(
                        minWidth: 85,
                        minHeight: 85,
                        strokeWidth: 2,
                        radius: 200,
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.kPDarkBlueColor,
                            AppColors.kSFlashyGreenColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        child: SizedBox(
                          width: 80.w,
                          child: Image.asset(
                            'assets/images/Rectangle.png',
                            scale: 2,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'Jane Doe',
                        style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CategoryWidget(),
                          SizedBox(
                            width: 12.w,
                          ),
                          const CategoryWidget()
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.kPDarkBlueColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset('assets/images/qr-code.svg', fit: BoxFit.contain),
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.w),
                              child: CoustomButton(
                                widgetContent: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(downloadIcon),
                                    Text(
                                      'Save to gallery',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.button.copyWith(color: AppColors.kPDarkBlueColor),
                                    )
                                  ],
                                ),

                                // buttonName: "Sign in",
                                backgoundColor: AppColors.kWhiteColor,
                                borderSideColor: AppColors.kPDarkBlueColor,
                                borderRadius: 10.0.r,
                                function: () {}, buttonName: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 27.w),
                              child: CoustomButton(
                                  widgetContent: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(shareIcon),
                                      Text(
                                        'Share the profile',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.button.copyWith(color: AppColors.kPDarkBlueColor),
                                      )
                                    ],
                                  ),

                                  // buttonName: "Sign in",
                                  backgoundColor: AppColors.kWhiteColor,
                                  borderSideColor: AppColors.kPDarkBlueColor,
                                  borderRadius: 10.0.r,
                                  function: () {}),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 83.h,
              width: 80.w,
              child: profileModel?.photoUrl == null || profileModel?.photoUrl == ""
                  ? Image.asset(
                      'assets/images/Rectangle.png',
                      scale: 2,
                    )
                  : Image.network((profileModel?.photoUrl)!, fit: BoxFit.cover),
            ),
          ),
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
              profileModel: profileModel,
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.kPDarkBlueColor), borderRadius: BorderRadius.circular(10)),
            width: 160.w,
            height: 40.h,
            child: Center(
              child: Text('Edit Profile',
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
                    Navigation.push(const FAQScreen());
                  },
                  assets: question,
                  title: 'FAQ',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(ContactUsScreen());
                  },
                  assets: contactUs,
                  title: 'Contact Us / Claims',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(const PrivacyPolicyScreen());
                  },
                  assets: privacyPolicy,
                  title: 'Privacy policy',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(const TermsAndConditionsScreen());
                  },
                  assets: terms,
                  title: 'Terms and conditions',
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
                          'Log out',
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
                            ' Are you sure you would like log out of your account?',
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
                                  buttonName: "Cancel",
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
                                  onSuccess: (bool result) {
                                    Navigator.pop(context);
                                    setState(() {});
                                    CashHelper.removeLoginData();
                                    widget.function.call();
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
                                    buttonName: "Log out",
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
            title: 'Log out',
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
              assets: heart,
              title: 'My favourites',
            ),
            const Divider(
              color: AppColors.kGreyLight,
            ),
            ItemProfile(
              assets: notificationIcon,
              title: 'Notifications',
            ),
            const Divider(
              color: AppColors.kGreyLight,
            ),
            ItemProfile(
              assets: password,
              title: 'Password and security',
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
                  title: 'My profile',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: heart,
                  title: 'My favourites',
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
                    title: 'My content',
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
                    title: 'Notifications',
                  ),
                  const Divider(
                    color: AppColors.kGreyLight,
                  ),
                  ItemProfile(
                    onTap: () {
                      Navigation.push(ContactUsScreen());
                    },
                    assets: password,
                    title: 'Password and security',
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
                  title: 'My profile',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: job,
                  title: 'Jobs alerts',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  assets: heart,
                  title: 'My favourites',
                ),
                const Divider(
                  color: AppColors.kGreyLight,
                ),
                ItemProfile(
                  onTap: () {
                    Navigation.push(BusinessContent(
                      callBack: (model) {
                        widget.profileModel.companyModel = model;
                        setState(() {});
                      },
                      profileModel: widget.profileModel,
                    ));
                  },
                  assets: content,
                  title: 'Business Content',
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
                    title: 'Notifications',
                  ),
                  const Divider(
                    color: AppColors.kGreyLight,
                  ),
                  ItemProfile(
                    onTap: () {
                      Navigation.push(ContactUsScreen());
                    },
                    assets: password,
                    title: 'Password and security',
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
