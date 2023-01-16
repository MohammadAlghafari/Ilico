import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/sheet/coustom_sheet.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/email_validator.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/forget_password_usecase.dart';
import '../widgets/sign_header_widget.dart';
import 'forget_password_verfiy_code.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with FormStateMinxin {
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
                                  'Forgot your password?',
                                  style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 33.h,
                  ),
                  Form(
                    key: form.key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 208.w,
                          child: Text(
                            'Please enter your registered email below to receive password reset instruction',
                            style: AppTheme.bodyText1.copyWith(fontSize: 12, color: AppColors.kDimBlue),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 25.w,
                            left: 25.w,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: CustomTextField(
                              validator: (value) {
                                return BaseValidator.validateValue(
                                  context,
                                  value!,
                                  [EmailValidator(), RequiredValidator()],
                                );
                              },
                              focusNode: form.nodes[0],
                              textEditingController: form.controllers[0],
                              hintText: 'Enter your email',
                              labelText: 'Email',
                              labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
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
              onTap: () {
                return form.validate();
              },
              withValidation: true,
              onSuccess: (val) {
                CustomSheet.show(
                    isDismissible: false,
                    title: "Verify Mobile Number",
                    context: context,
                    child: VerfiyCodeForgetPassword(
                      email: form.controllers[0].text,
                    ));
                // Navigation.push(const RootScreen());
              },
              useCaseCallBack: (val) {
                return ForgetPasswordUseCase(AuthRepository())
                    .call(params: ForgetPasswordParams(email: form.controllers[0].text));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 27.w),
                      child: CoustomButton(
                        buttonName: "Submit",
                        backgoundColor: AppColors.kWhiteColor,
                        borderSideColor: AppColors.kPDarkBlueColor,
                        borderRadius: 10.0.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 1;
}
