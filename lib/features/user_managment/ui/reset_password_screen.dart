import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resetpasswordusecase.dart';
import 'package:easy_localization/easy_localization.dart';
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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen();

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
            action: const [],
            title: "Password and security".tr(),
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
                        nextFocusNode: form.nodes[1],
                        hintText: 'Enter your current password'.tr(),
                        labelText: 'Old password'.tr(),
                        labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                      ),
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
                        focusNode: form.nodes[1],
                        nextFocusNode: form.nodes[2],
                        textEditingController: form.controllers[1],
                        hintText: 'Enter your new password'.tr(),
                        labelText: 'New password'.tr(),
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
                        focusNode: form.nodes[2],
                        textEditingController: form.controllers[2],
                        hintText: 'Enter your new password',
                        labelText: 'Confirm new password'.tr(),
                        labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              CreateModel(
                useCaseCallBack: (model) {
                  return ResetPasswordUseCase(repository: AuthRepository()).call(
                      params: ResetPasswordParams(
                          oldPassword: form.controllers[0].text,
                          newPassword: form.controllers[1].text,
                          confirmNewPassword: form.controllers[2].text));
                },
                onSuccess: (val) {
                  Navigation.pop();
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
                          buttonName: "Change Password".tr(),
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
  int numberOfFields() => 3;
}
