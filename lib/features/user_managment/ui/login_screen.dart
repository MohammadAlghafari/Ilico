import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/user_managment/ui/Sp_Sing_Up_Subscriptions.dart';
import 'package:charja_charity/features/user_managment/ui/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/sheet/coustom_sheet.dart';
import '../../../core/ui/widgets/verfication_Bottom_Sheet.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/email_validator.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../data/model/login_model.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/login_usecse.dart';
import '../widgets/sign_header_widget.dart';
import '../widgets/signin_with_widget.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final ValueChanged<bool>? onSuccess;

  const LoginScreen({this.onSuccess, Key? key}) : super(key: key);

  @override
  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with FormStateMinxin {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: form.key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignHeader(
                  height: 283.h,
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            logo_White,
                            width: 60,
                            height: 88.3,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Sign in",
                            style: AppTheme.headline2.copyWith(color: Colors.white),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 25.w,
                    left: 25.w,
                  ),
                  child: CustomTextField(
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [EmailValidator(), RequiredValidator()],
                      );
                    },
                    focusNode: form.nodes[0],
                    nextFocusNode: form.nodes[1],
                    textEditingController: form.controllers[0],
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25.w, left: 25.w),
                  child: CustomTextField(
                    useObscure: true,
                    isSuffixIcon: true,
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator()],
                      );
                    },
                    focusNode: form.nodes[1],
                    textEditingController: form.controllers[1],
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 249.w,
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.push(ForgetPassword());
                        // forgetPasswordSheet();
                      },
                      child: Text(
                        'Forgot password ?',
                        style: AppTheme.subtitle2.copyWith(fontSize: 14, color: AppColors.kPDarkBlueColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                const SignInWidget(fromLogin: true),
                SizedBox(
                  height: 85.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account ?', style: AppTheme.bodyText1.copyWith(fontSize: 14)),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            'Sign up ',
                            style: AppTheme.subtitle2.copyWith(fontSize: 14, color: AppColors.kPOrangeColor),
                          ),
                        ),
                        onTap: () {
                          Navigation.push(const SignupScreen());
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CreateModel(
                  // onError: (error) {
                  //   if (error is ConflictError) {
                  //     // CustomSheet.show(
                  //     //     isDismissible: false,
                  //     //     title: "Verify Mobile Number",
                  //     //     context: context,
                  //     //     child: VerficationBottomSheet(
                  //     //       phoneNumber: form.controllers[0].text,
                  //     //     ));
                  //   }
                  // },
                  withValidation: true,
                  onTap: () {
                    return form.validate();
                  },
                  onSuccess: (LoginModel model) {
                    if (model.isVerified == null) {
                      CashHelper.saveData(key: kACCESSTOKEN, value: model.accessToken);
                      CashHelper.saveData(key: kREFRESHTOKEN, value: model.refreshToken);
                      // CashHelper.saveData(key: kROLE, value: model.role);//todo
                      CashHelper.saveData(key: kAccessTOKENEXPIRATIONDATE, value: model.accessTokenExpirationDate);
                      CashHelper.saveData(key: REFRESHTOKENEXPIRATIONDATE, value: model.refreshTokenExpirationDate);
                      CashHelper.saveData(key: userType, value: model.userType);
                      if (model.userStatus == "InActive") {
                        Navigation.push(const SpSingUpSubscriptions());
                      } else {
                        CashHelper.saveData(key: isPay, value: true);
                        widget.onSuccess?.call(true);
                      }
                    } else {
                      CustomSheet.show(
                          isDismissible: false,
                          title: "Verify Mobile Number",
                          context: context,
                          child: VerficationBottomSheet(
                            phoneNumber: model.phoneNumber,
                          ));
                    }
                  },
                  useCaseCallBack: (model) {
                    return GetLoginUseCase(AuthRepository()).call(
                        params: GetLoginParams(email: form.controllers[0].text, password: form.controllers[1].text));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 27.w),
                          child: CoustomButton(
                            buttonName: "Sign in",
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
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 2;
}
