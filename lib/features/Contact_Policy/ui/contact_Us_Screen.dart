import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/core/utils/form_utils/form_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/Navigation/Navigation.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Contact Us",
        withBackButton: true,
        action: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Get in touch",
                  textAlign: TextAlign.center,
                  style: AppTheme.headline1.copyWith(
                    color: AppColors.kDimBlue,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Our friendly team would love to hear you!",
                  textAlign: TextAlign.center,
                  style: AppTheme.subtitle1.copyWith(
                    color: AppColors.kDimBlue,
                    fontSize: 16,
                  ),
                ),
              ),
              buildForm(),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CoustomButton(
                        buttonName: "Send Message",
                        //   height: 50.h,
                        // width: 336,
                        backgoundColor: AppColors.kWhiteColor,
                        borderSideColor: AppColors.kPDarkBlueColor,
                        borderRadius: 10.0.r,
                        function: () {
                          // Navigation.push(SPSingUpBusinessInformations());
                          Navigation.push(ContactUsScreen());
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: form.key,
      child: Column(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          CustomTextField(
            labelText: 'Name',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your name',
            textEditingController: form.controllers[0],
            focusNode: form.nodes[0],
            nextFocusNode: form.nodes[1],
          ),
          CustomTextField(
            labelText: 'Email',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Enter your Email',
            textEditingController: form.controllers[1],
            focusNode: form.nodes[1],
            nextFocusNode: form.nodes[2],
          ),
          CustomTextField(
            labelText: 'Phone number',
            labelStyle: AppTheme.bodyText2,
            hintText: '+32   00 00 00 00 00',
            textEditingController: form.controllers[2],
            focusNode: form.nodes[2],
            nextFocusNode: form.nodes[3],
          ),
          CustomTextField(
            labelText: 'Message',
            labelStyle: AppTheme.bodyText2,
            hintText: 'Type your message',
            textEditingController: form.controllers[3],
            focusNode: form.nodes[3],
            // useObscure: true,
            maxLine: 8,
            //  isSuffixIcon: true,
          ),
        ],
      ),
    );
  }

  @override
  int numberOfFields() => 4;
}
