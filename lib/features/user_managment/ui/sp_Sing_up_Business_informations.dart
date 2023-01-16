import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../profile/data/use_case/edit_company_service_provider.dart';
import '../bloc/service_provider_cubit.dart';
import '../data/model/supscription_model.dart';
import '../widgets/sign_header_widget.dart';
import 'service_select_activity.dart';
import 'sign_up_upload_picture.dart';

class SPSingUpBusinessInformations extends StatefulWidget {
  const SPSingUpBusinessInformations({Key? key, required this.supscription}) : super(key: key);

  final Supscription supscription;

  @override
  _SPSingUpBusinessInformationsState createState() => _SPSingUpBusinessInformationsState();
}

class _SPSingUpBusinessInformationsState extends State<SPSingUpBusinessInformations> with FormStateMinxin {
  late String idCategory;
  late String nameCategory;
  late List<String?> categoriesID;
  ServiceProviderCubit cubit = ServiceProviderCubit();

  @override
  void initState() {
    categoriesID = List.filled((widget.supscription.activityCount)!, null, growable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 232.h,
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back),
        centerTitle: true,
        //  title:
        flexibleSpace: SignHeader(
          // height: 283.h,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 34.w,
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 34.w,
                    ),
                    Text(
                      "Create your account",
                      style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(endLine),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(Icon_Steps),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(centerLine),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(iconFilled),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(endLine),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "    Payment",
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Business informations",
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Form(
            key: form.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: List.generate(widget.supscription.activityCount!,
                      (index) => singleActivityWidget(controllerIndex: index, foucsnodeIndex: index + 1)),
                ),
                CustomTextField(
                  labelText: 'Company’s name',
                  labelStyle: AppTheme.bodyText2,
                  hintText: 'distinctio error nesciunt',
                  textEditingController: form.controllers[widget.supscription.activityCount!],
                  focusNode: form.nodes[widget.supscription.activityCount!],
                  nextFocusNode: form.nodes[widget.supscription.activityCount! + 1],
                ),
                CustomTextField(
                  labelText: 'Your job position',
                  labelStyle: AppTheme.bodyText2,
                  hintText: 'distinctio error nesciunt  ',
                  textEditingController: form.controllers[widget.supscription.activityCount! + 1],
                  focusNode: form.nodes[widget.supscription.activityCount! + 1],
                  nextFocusNode: form.nodes[widget.supscription.activityCount! + 2],
                ),
                CustomTextField(
                  labelText: 'SIREN number',
                  labelStyle: AppTheme.bodyText2,
                  hintText: 'distinctio error nesciunt',
                  textEditingController: form.controllers[widget.supscription.activityCount! + 2],
                  focusNode: form.nodes[widget.supscription.activityCount! + 2],
                  // nextFocusNode: form.nodes[5],
                  //useObscure: true,
                ),
                SizedBox(
                  height: 40.h,
                ),
                BlocConsumer(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is SPCategoryLoaded) {
                      Navigation.push(const SignUpUploadPicture());
                    }
                  },
                  builder: (context, state) {
                    if (state is SPCategoryLoading) {
                      return const Center(child: LoadingIndicator());
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: CoustomButton(
                              buttonName: "Continue",
                              backgoundColor: AppColors.kWhiteColor,
                              borderSideColor: AppColors.kPDarkBlueColor,
                              borderRadius: 10.0.r,
                              function: () {
                                if (categoriesID.contains(null)) {
                                  Dialogs.showSnackBar(
                                      message: 'Please select all activity',
                                      typeSnackBar: AnimatedSnackBarType.warning);
                                } else {
                                  cubit.confirm(
                                      categoriesID,
                                      EditCompanyProfileParams(
                                        job: form.controllers[widget.supscription.activityCount! + 1].text,
                                        name: form.controllers[widget.supscription.activityCount!].text,
                                        sirenNumber: form.controllers[widget.supscription.activityCount! + 2].text,
                                      ));
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget singleActivityWidget({required int controllerIndex, required int foucsnodeIndex}) {
    return InkWell(
      onTap: () {
        Navigation.push(ServiceSelectActivity(
          index: controllerIndex,
          selectedIds: categoriesID,
          categorySelect: (activityModel) {
            form.controllers[controllerIndex].text = activityModel.name!;
          },
        ));
      },
      child: CustomTextField(
        enabled: false,
        labelText: 'Select your Activity ${controllerIndex + 1}',
        labelStyle: AppTheme.bodyText2,
        hintText: 'Activity',
        textEditingController: form.controllers[controllerIndex],
        focusNode: form.nodes[controllerIndex],
        nextFocusNode: form.nodes[foucsnodeIndex],
        suffixIcon: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.kPDarkBlueColor,
          size: 15.r,
        ),
        isSuffixIcon: true,
      ),
    );
  }

  @override
  int numberOfFields() => widget.supscription.activityCount! + 3;
}
