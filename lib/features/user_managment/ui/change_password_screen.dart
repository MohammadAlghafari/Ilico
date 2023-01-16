import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/password_validator.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../data/usecase/change_password_usecase.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key, required this.email, required this.otpCode}) : super(key: key);
  final String email;
  final int otpCode;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            action: const [],
            title: "Password and security",
            withBackButton: true,
            isCenterTitle: true,
            appBarHeight: 70.h),
        body: Form(
          key: form.key,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const Divider(
                      color: AppColors.kGreyLight,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 27.w,
                      ),
                      child: CustomTextField(
                        useObscure: true,
                        isSuffixIcon: true,
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [PasswordValidator(), RequiredValidator()],
                          );
                        },
                        focusNode: form.nodes[0],
                        textEditingController: form.controllers[0],
                        hintText: 'Enter your new password',
                        labelText: 'New password',
                        labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 27.w),
                      child: CustomTextField(
                        useObscure: true,
                        isSuffixIcon: true,
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [PasswordValidator(), RequiredValidator()],
                          );
                        },
                        focusNode: form.nodes[1],
                        textEditingController: form.controllers[1],
                        hintText: 'Enter your new password',
                        labelText: 'Confirm new password',
                        labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              CreateModel(
                useCaseCallBack: (model) {
                  return ChangePasswordUseCase(repository: AuthRepository()).call(
                      params: ChangePasswordParams(
                          email: widget.email,
                          newPassword: form.controllers[0].text,
                          confirmNewPassword: form.controllers[1].text,
                          otpCode: widget.otpCode));
                },
                onSuccess: (val) {
                  Navigation.goToHome();
                },
                withValidation: true,
                onTap: () {
                  return form.validate();
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                        child: CoustomButton(
                          buttonName: "Change Password",
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
      ),
    );
  }

  @override
  int numberOfFields() => 2;
}
