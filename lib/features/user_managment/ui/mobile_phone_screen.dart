import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:charja_charity/features/user_managment/ui/signup_select_category.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/http/graphQl_provider.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/phone_number_validation.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/signup_by_apple_usecase.dart';
import '../data/usecase/signup_by_facecbook.dart';
import '../data/usecase/signup_by_google.dart';
import '../widgets/sign_header_widget.dart';
import 'Sp_Sing_Up_Subscriptions.dart';

class MobilePhoneScreen extends StatefulWidget {
  final String? lastName;
  final String? id;
  final String? photoUrl;
  final String? email;
  final String? firstName;
  final String? rolKey;
  final bool? isGoogle;
  final bool? isCustomer;
  final bool? isApple;

  const MobilePhoneScreen(
      {Key? key,
      this.isApple,
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.rolKey,
      this.isGoogle,
      this.isCustomer})
      : super(key: key);

  @override
  State<MobilePhoneScreen> createState() => _MobilePhoneScreenState();
}

class _MobilePhoneScreenState extends State<MobilePhoneScreen> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SignHeader(
                    height: 124.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 29),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                ' enter your phone?'.tr(),
                                style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 8.h,
                ),
                Form(
                  key: form.key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 25.w,
                          left: 25.w,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: CustomTextField(
                            labelText: 'Phone number'.tr(),
                            labelStyle: AppTheme.bodyText2,
                            hintText: '+32   00 00 00 00 00',
                            textEditingController: form.controllers[0],
                            focusNode: form.nodes[0],
                            keyboardType: TextInputType.phone,
                            validator: (v) => BaseValidator.validateValue(
                              context,
                              form.controllers[0].text,
                              [RequiredValidator(), PhoneNumberValidator()],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 79.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          CreateModel(
            onSuccess: (UserModel result) {
              print(result);
              CashHelper.saveData(key: kACCESSTOKEN, value: result.accessToken);
              CashHelper.saveData(key: kREFRESHTOKEN, value: result);
              CashHelper.saveData(key: kAccessTOKENEXPIRATIONDATE, value: result.accessTokenExpirationDate);
              CashHelper.saveData(key: REFRESHTOKENEXPIRATIONDATE, value: result.refreshTokenExpirationDate);
              CashHelper.saveData(key: userType, value: result.userType);
              GraphQlProvider.setQlLink(auth: true);
              switch (result.userType) {
                case "Influencer":
                  Navigation.push(const SignupSelectCategory());
                  break;
                case "Customer":
                  Navigation.push(SignupSelectCategory());
                  break;
                case "ServiceProvider":
                  if (result.userStatus == "InActive") {
                    if (CashHelper.getData(key: kACCESSTOKEN) == null) {
                      Dialogs.showSnackBar(
                          message: 'User is already exist, go to log in pleas.',
                          typeSnackBar: AnimatedSnackBarType.error);
                    } else {
                      Navigation.push(SpSingUpSubscriptions());
                    }
                  }

                  break;
                default:
                  Navigation.goToHome();
              }
            },
            withValidation: true,
            onTap: () {
              return form.validate();
            },
            useCaseCallBack: (model) {
              if (widget.isGoogle!) {
                return SignUpByGoogleUseCase(AuthRepository()).call(
                    params: SignUpByGoogleParams(
                  photoUrl: widget.photoUrl,
                  googleProfileId: widget.id,
                  firstName: widget.firstName,
                  lastName: widget.lastName,
                  phone: form.controllers[0].text,
                  email: widget.email,
                  roleKey: widget.rolKey,
                  isCustomer: widget.isCustomer,
                ));
              } else if (widget.isApple!) {
                return SignUpByAppleUseCase(AuthRepository()).call(
                    params: SignUpByAppleParams(
                  photoUrl: widget.photoUrl,
                  appleProfileId: widget.id,
                  firstName: widget.firstName,
                  lastName: widget.lastName,
                  phone: form.controllers[0].text,
                  email: widget.email,
                  roleKey: widget.rolKey,
                  isCustomer: widget.isCustomer,
                ));
              } else {
                return SignUpByFacebookUseCase(AuthRepository()).call(
                    params: SignUpByFacebookParams(
                  photoUrl: widget.photoUrl,
                  facebookProfileId: widget.id,
                  firstName: widget.firstName,
                  lastName: widget.lastName,
                  phone: form.controllers[0].text,
                  email: widget.email,
                  roleKey: widget.rolKey,
                  isCustomer: widget.isCustomer,
                ));
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                    child: CoustomButton(
                      buttonName: "Submit".tr(),
                      backgoundColor: AppColors.kWhiteColor,
                      borderSideColor: AppColors.kPDarkBlueColor,
                      borderRadius: 10.0.r,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  @override
  int numberOfFields() => 1;
}
