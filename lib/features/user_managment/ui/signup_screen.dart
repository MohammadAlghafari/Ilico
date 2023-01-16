import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/ui/widgets/Coustom_Button.dart';
import 'package:charja_charity/core/ui/widgets/sheet/coustom_sheet.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/core/utils/form_utils/form_state_mixin.dart';
import 'package:charja_charity/core/utils/validators/email_validator.dart';
import 'package:charja_charity/core/utils/validators/password_validator.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/verfication_Bottom_Sheet.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/length_validator.dart';
import '../../../core/utils/validators/phone_number_validation.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/signup_usecase.dart';
import '../widgets/sign_header_widget.dart';
import '../widgets/signin_with_widget.dart';
import 'Sp_Sing_Up_Subscriptions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with FormStateMinxin {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  late List<Widget> item;
  bool switch_to_customer = false;

  @override
  void initState() {
    super.initState();
    item = [
      buildIndividualPage(),
      buildInfluencerPage(),
      buildProfessionalPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 232.h,
        automaticallyImplyLeading: false,
        centerTitle: false,
        flexibleSpace: SignHeader(
          // height: 283.h,
          child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Create your account as",
                    style: AppTheme.headline2
                        .copyWith(color: AppColors.kWhiteColor),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  buildListAccountItem(),
                  SizedBox(
                    height: 26.h,
                  )
                ],
              )),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 16.h,
              ),
              selectedIndex == 0
                  ? item[0]
                  : selectedIndex == 1
                      ? item[1]
                      : item[2],
              selectedIndex != 2
                  ? const SignInWidget(
                      fromLogin: false,
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterSwitch(
                                width: 40,
                                height: 24,
                                activeColor: AppColors.kPDarkBlueColor,
                                inactiveColor: AppColors.kMediumColor,
                                // valueFontSize: 25.0,
                                toggleSize: 16,
                                value: switch_to_customer,
                                borderRadius: 16.0,
                                //padding: 8.0,
                                //  showOnOff: true,
                                onToggle: (val) {
                                  setState(() {
                                    switch_to_customer = val;
                                  });
                                },
                              ),
                              Text(
                                "Allow to switch to customer account",
                                style: AppTheme.headline5,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "If you activate this option, you will have access to an user account. You can switch to your professional account anytime.",
                            style: AppTheme.subtitle1.copyWith(
                                color: AppColors.kGrayTextField,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
              SizedBox(
                height: 29.h,
              ),
              CreateModel(
                onSuccess: (UserModel result) {
                  if (result.isVerified != null && result.isVerified == false) {
                    CustomSheet.show(
                        isDismissible: false,
                        title: "Verify Mobile Number",
                        context: context,
                        child: VerficationBottomSheet(
                          phoneNumber: form.controllers[2].text,
                        ));
                  } else if (result.userType == "ServiceProvider") {
                    if (result.userStatus == "InActive") {
                      Navigation.push(SpSingUpSubscriptions());
                    }
                  }
                },
                withValidation: true,
                onTap: () {
                  return form.validate();
                },
                useCaseCallBack: (model) {
                  return SignUpUseCase(AuthRepository()).call(
                      params: SignUpParams(
                    firstName: form.controllers[0].text,
                    lastName: form.controllers[1].text,
                    phone: form.controllers[2].text,
                    email: form.controllers[3].text,
                    password: form.controllers[4].text,
                    roleKey: roleKey,
                    isCustomer: switch_to_customer,
                  ));
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: CoustomButton(
                          buttonName: "Create account",
                          // height: 50,
                          // width: 336,
                          backgoundColor: AppColors.kWhiteColor,
                          borderSideColor: AppColors.kPDarkBlueColor,
                          borderRadius: 10.0.r,
                          // function: () {
                          //   // Navigation.push(SearchResult());
                          //   // //Navigation.push(NotificationsScreen());
                          // },
                        ),
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

  Widget buildIndividualPage() {
    return buildSharedPageWidget();
  }

  Widget buildInfluencerPage() {
    return buildSharedPageWidget();
  }

  Widget buildProfessionalPage() {
    return buildSharedPageWidget();
  }

  String get roleKey {
    switch (selectedIndex) {
      case 0:
        return 'Customer';
      case 1:
        return 'Influencer';
      default:
        return 'ServiceProvider';
    }
  }

  Widget buildSharedPageWidget() {
    return Form(
      key: form.key,
      child: Column(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          CustomTextField(
            labelText: 'First Name',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your name',
            textEditingController: form.controllers[0],
            focusNode: form.nodes[0],
            nextFocusNode: form.nodes[1],
            validator: (v) => BaseValidator.validateValue(
              context,
              form.controllers[0].text,
              [
                RequiredValidator(),
                LengthValidator(length: 35),
              ],
            ),
          ),
          CustomTextField(
            labelText: 'Last Name',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your name',
            textEditingController: form.controllers[1],
            focusNode: form.nodes[1],
            nextFocusNode: form.nodes[2],
            validator: (v) => BaseValidator.validateValue(
              context,
              form.controllers[1].text,
              [
                RequiredValidator(),
                LengthValidator(length: 35),
              ],
            ),
          ),
          CustomTextField(
            labelText: 'Phone number',
            labelStyle: AppTheme.bodyText2,
            hintText: '+32   00 00 00 00 00',
            textEditingController: form.controllers[2],
            focusNode: form.nodes[2],
            nextFocusNode: form.nodes[3],
            keyboardType: TextInputType.phone,
            validator: (v) => BaseValidator.validateValue(
              context,
              form.controllers[2].text,
              [RequiredValidator(), PhoneNumberValidator()],
            ),
          ),
          CustomTextField(
            labelText: 'Email',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your Email',
            textEditingController: form.controllers[3],
            focusNode: form.nodes[3],
            nextFocusNode: form.nodes[4],
            validator: (v) => BaseValidator.validateValue(
              context,
              form.controllers[3].text,
              [RequiredValidator(), EmailValidator()],
            ),
          ),
          CustomTextField(
            isSuffixIcon: true,
            labelText: 'Password',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your Password',
            textEditingController: form.controllers[4],
            focusNode: form.nodes[4],
            useObscure: true,
            validator: (v) => BaseValidator.validateValue(
              context,
              form.controllers[4].text,
              [RequiredValidator(), PasswordValidator()],
            ),
            //  isSuffixIcon: true,
          ),
        ],
      ),
    );
  }

  Widget buildAccountSelected(String imageSelected, String imageUnSelected,
      VoidCallback action, int indexSelected) {
    return InkWell(
        onTap: action,
        child: Image.asset(
            indexSelected == selectedIndex ? imageSelected : imageUnSelected));
  }

  Widget buildListAccountItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildAccountSelected(selectedIndividual, unSelectedIndividual, () {
          setState(() {
            selectedIndex = 0;
            // pageController.jumpToPage(0);
          });
        }, 0),
        buildAccountSelected(selectedInfluencer, unSelectedInfluencer, () {
          setState(() {
            selectedIndex = 1;
            // pageController.jumpToPage(1);
          });
        }, 1),
        buildAccountSelected(selectedProfessional, unSelectedProfessional, () {
          setState(() {
            selectedIndex = 2;
            // pageController.jumpToPage(2);
          });
        }, 2),
      ],
    );
  }

  @override
  int numberOfFields() => 5;
}
