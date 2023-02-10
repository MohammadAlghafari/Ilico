import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/ui/widgets/custom_text_field.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/sheet/coustom_sheet.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';

class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({Key? key}) : super(key: key);

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBarWidget(
        withBackButton: false,
        title: 'Submit a job'.tr(),
        action: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Send an alert to the professionals around you for the service/product you are looking for. You will receive an alert as soon as a professional is available.'
                    .tr(),
                style: AppTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Select the type of service'.tr(),
                style: AppTheme.subtitle2.copyWith(fontSize: 15),
              ),
              SizedBox(
                height: 8.h,
              ),
              InkWell(
                onTap: () {
                  CustomSheet.show(
                    context: context,
                    title: "Type of service".tr(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Container(
                                height: 44.h,
                                // child: MyRadio(
                                //   categoryModel: CategoryModel(),
                                //   onChange: (val) {},
                                //   value: false,
                                // ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CoustomButton(
                                  buttonName: "Ok".tr(),
                                  backgoundColor: AppColors.kWhiteColor,
                                  borderSideColor: AppColors.kPDarkBlueColor,
                                  borderRadius: 10.0.r,
                                  function: () {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kLightColor,
                      border: Border.all(color: AppColors.kMediumLightColor, width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enter service name",
                          style: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 14),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomTextField(
                labelText: 'Tell us more about your request',
                textEditingController: form.controllers[0],
                focusNode: form.nodes[0],
                maxLine: 5,
                hintText: 'Type your text here',
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CoustomButton(
                        buttonName: "Send my job alert",
                        backgoundColor: AppColors.kWhiteColor,
                        borderSideColor: AppColors.kPDarkBlueColor,
                        borderRadius: 10.0.r,
                        function: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 1;
}
