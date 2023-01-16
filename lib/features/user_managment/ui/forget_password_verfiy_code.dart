import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/verfication_Bottom_Sheet.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/verfiy_code_forget_password.dart';
import 'change_password_screen.dart';

class VerfiyCodeForgetPassword extends StatefulWidget {
  final String email;
  const VerfiyCodeForgetPassword({Key? key, required this.email}) : super(key: key);
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
  State<VerfiyCodeForgetPassword> createState() => _VerfiyCodeForgetPasswordState();
}

class _VerfiyCodeForgetPasswordState extends State<VerfiyCodeForgetPassword> {
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
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "A verification code has been sent to ",
            style: AppTheme.subtitle1.copyWith(
              color: AppColors.kDimBlue,
            ),
            children: [
              TextSpan(
                  text: "${widget.email}",
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
          children: const [
            // Text(
            //   textAlign: TextAlign.center,
            //   "Don't recieve a code? ",
            //   style: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField.withOpacity(0.5), fontSize: 14),
            // ),
            // CreateModel(
            //   onSuccess: (bool result) {
            //     if (result) {
            //       Dialogs.showSnackBar(message: "Code Resend Successfully", typeSnackBar: AnimatedSnackBarType.success);
            //       // Navigation.push(const SelectGategories());
            //     }
            //   },
            //   withValidation: false,
            //   useCaseCallBack: (model) {
            //     // print("email : ${widget.phoneNumber}\n\n\n");
            //     return ResendOTPUseCase(AuthRepository()).call(params: ResendOTPParams(email: widget.email!));
            //   },
            //   child: Text(
            //     "Resend",
            //     style: AppTheme.subtitle2.copyWith(color: AppColors.kGrayTextField.withOpacity(0.5), fontSize: 14),
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: 85.h,
        ),
        CreateModel(
          withValidation: false,
          onSuccess: (bool val) {
            Navigation.push(ChangePasswordScreen(
              email: widget.email,
              otpCode: int.parse(controller.text),
            ));
          },
          useCaseCallBack: (model) {
            return ForgetPasswordOtpUseCase(repository: AuthRepository())
                .call(params: ForgetPasswordOtpParams(email: widget.email, otpCode: int.parse(controller.text)));
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
