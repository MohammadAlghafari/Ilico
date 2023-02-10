import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resend_otp_usecase.dart';
import 'package:charja_charity/features/user_managment/data/usecase/verify_usecase.dart';
import 'package:charja_charity/features/user_managment/ui/Sp_Sing_Up_Subscriptions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../features/user_managment/data/repository/auth_repository.dart';
import '../../../features/user_managment/ui/signup_select_category.dart';
import '../../constants/end_point.dart';
import '../../http/graphQl_provider.dart';
import '../../utils/cashe_helper.dart';
import '../dialogs/dialogs.dart';
import 'Coustom_Button.dart';

class VerficationBottomSheet extends StatefulWidget {
  VerficationBottomSheet({required this.phoneNumber});

  final String? phoneNumber;
  static PinTheme defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle:
        AppTheme.subtitle2.copyWith(fontWeight: FontWeight.w500, fontSize: 30, color: AppColors.kVerifyTextFiledColor),
    decoration: BoxDecoration(
      color: AppColors.kVerifyBackgroundTextFiledColor,
      // border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10.r),
    ),
  );
  static PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
    color: AppColors.kVerifyBackgroundTextFiledColor,
    border: Border.all(color: AppColors.kGreyLight),
    borderRadius: BorderRadius.circular(10.r),
  );

  static PinTheme submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: AppColors.kVerifyBackgroundTextFiledColor,
    ),
  );

  @override
  State<VerficationBottomSheet> createState() => _VerficationBottomSheetState();
}

class _VerficationBottomSheetState extends State<VerficationBottomSheet> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "A verification code has been sent to".tr() + " ",
            style: AppTheme.subtitle1.copyWith(
              color: AppColors.kDimBlue,
            ),
            children: [
              TextSpan(
                  text: "${widget.phoneNumber}",
                  style: AppTheme.subtitle2.copyWith(
                    color: AppColors.kDimBlue,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 32.h,
        ),
        Pinput(
          length: 4,
          controller: controller,
          defaultPinTheme: VerficationBottomSheet.defaultPinTheme,
          focusedPinTheme: VerficationBottomSheet.focusedPinTheme,
          submittedPinTheme: VerficationBottomSheet.submittedPinTheme,
          validator: (s) {
            // return s == widget.code ? null : 'Pin is incorrect';
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) => print(pin),
        ),
        SizedBox(
          height: 24.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "Don't recieve a code? ",
              style: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField.withOpacity(0.5), fontSize: 14),
            ),
            CreateModel(
              onSuccess: (bool result) {
                if (result) {
                  Dialogs.showSnackBar(message: "Code Resend Successfully", typeSnackBar: AnimatedSnackBarType.success);
                  // Navigation.push(const SelectGategories());
                }
              },
              withValidation: false,
              useCaseCallBack: (model) {
                print("email : ${widget.phoneNumber}\n\n\n");
                return ResendOTPUseCase(AuthRepository()).call(params: ResendOTPParams(email: widget.phoneNumber!));
              },
              child: Text(
                "Resend",
                style: AppTheme.subtitle2.copyWith(color: AppColors.kGrayTextField.withOpacity(0.5), fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 85.h,
        ),
        CreateModel(
          onSuccess: (LoginModel model) {
            if (model != null) {
              CashHelper.saveData(key: kACCESSTOKEN, value: model.accessToken);
              CashHelper.saveData(key: kREFRESHTOKEN, value: model.refreshToken);
              CashHelper.saveData(key: kAccessTOKENEXPIRATIONDATE, value: model.accessTokenExpirationDate);
              CashHelper.saveData(key: REFRESHTOKENEXPIRATIONDATE, value: model.refreshTokenExpirationDate);
              CashHelper.saveData(key: userType, value: model.userType);

              GraphQlProvider.setQlLink(auth: true);
              switch (model.userType) {
                case "Influencer":
                  Navigation.push(const SignupSelectCategory());
                  break;
                case "Customer":
                  Navigation.push(SignupSelectCategory());
                  break;
                case "ServiceProvider":
                  Navigation.push(SpSingUpSubscriptions());
                  break;
                default:
                  Navigation.goToHome();
              }
            }
          },
          withValidation: false,
          useCaseCallBack: (model) {
            return UserInfoUseCase(repository: AuthRepository())
                .call(params: GetUserInfoParams(phoneNumber: widget.phoneNumber!, otpCode: int.parse(controller.text)));
          },
          child: Row(
            children: [
              Expanded(
                child: CoustomButton(
                  buttonName: "Submit",
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0.r,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
