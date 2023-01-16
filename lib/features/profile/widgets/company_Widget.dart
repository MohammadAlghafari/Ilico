import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/length_validator.dart';
import '../data/profile_repository/profile_repository.dart';
import '../data/use_case/edit_company_service_provider.dart';

class CompanyWidget extends StatefulWidget {
  ProfileSpModel profileModel;
  final ValueChanged callBack;
  CompanyWidget({Key? key, required this.profileModel, required this.callBack}) : super(key: key);

  @override
  _CompanyWidgetState createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Form(
        key: form.key,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
              validator: (value) {
                return BaseValidator.validateValue(
                  context,
                  value!,
                  [
                    LengthValidator(length: 60),
                  ],
                );
              },
              initialValue: widget.profileModel.companyModel?.job,
              labelText: 'Job',
              labelStyle: AppTheme.bodyText2,
              hintText: 'Hairdresser',
              textEditingController: form.controllers[0],
              focusNode: form.nodes[0],
              nextFocusNode: form.nodes[1],
            ),
            CustomTextField(
              validator: (value) {
                return BaseValidator.validateValue(
                  context,
                  value!,
                  [
                    LengthValidator(length: 60),
                  ],
                );
              },
              initialValue: widget.profileModel.companyModel?.name,
              labelText: 'Company name',
              labelStyle: AppTheme.bodyText2,
              hintText: 'Hairsalon',
              textEditingController: form.controllers[1],
              focusNode: form.nodes[1],
              nextFocusNode: form.nodes[2],
            ),
            CustomTextField(
              initialValue: widget.profileModel.companyModel?.phoneNumber,
              labelText: 'Company number',
              labelStyle: AppTheme.bodyText2,
              hintText: '+32   06 00 00 00 00',
              textEditingController: form.controllers[2],
              focusNode: form.nodes[2],
              nextFocusNode: form.nodes[3],
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              initialValue: widget.profileModel.companyModel?.iban,
              labelText: 'Company IBAN',
              labelStyle: AppTheme.bodyText2,
              hintText: '2658562254',
              textEditingController: form.controllers[3],
              focusNode: form.nodes[3],
              nextFocusNode: form.nodes[4],
              keyboardType: TextInputType.number,
              //  isSuffixIcon: true,
            ),
            CustomTextField(
              validator: (value) {
                return BaseValidator.validateValue(
                  context,
                  value!,
                  [
                    LengthValidator(length: 500),
                  ],
                );
              },
              initialValue: widget.profileModel.companyModel?.description,
              labelText: 'Description',
              labelStyle: AppTheme.bodyText2,
              hintText: 'Type service description here...',
              textEditingController: form.controllers[4],
              focusNode: form.nodes[4],
              maxLine: 5,
            ),
            SizedBox(
              height: 20.h,
            ),
            CreateModel(
              onTap: () {
                return form.validate();
              },
              onSuccess: (model) {
                widget.callBack(model);

                Navigation.pop();
              },
              withValidation: true,
              useCaseCallBack: (model) {
                return EditCompanyProfileUseCase(ProfileRepository()).call(
                    params: EditCompanyProfileParams(
                  job: form.controllers[0].text,
                  name: form.controllers[1].text,
                  phoneNumber: form.controllers[2].text,
                  iban: form.controllers[3].text,
                  description: form.controllers[4].text,
                ));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: CoustomButton(
                        buttonName: "Save",
                        // height: 50,
                        // width: 336,
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
  int numberOfFields() => 5;
}
