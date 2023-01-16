import 'dart:io';

import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/length_validator.dart';
import '../../add_section/data/usecase/upload_file_usecase.dart';
import '../bloc/profile_cubit.dart';
import '../data/model/profile_model.dart';
import '../data/use_case/edit_profile_usecase.dart';

class EditProfileScreen extends StatefulWidget {
  UserInfo? profileModel;
  final ValueChanged callBack;
  EditProfileScreen({Key? key, this.profileModel, required this.callBack}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with FormStateMinxin {
  ProfileCubit profileCubit = ProfileCubit();
  File? image;
  Future<void> selectImage({required ImageSource imageSource}) async {
    final imagePicker = ImagePicker();
    var pickedFile = await imagePicker.pickImage(source: imageSource, imageQuality: 25);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    print(image);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Edit Profile',
        action: const [SizedBox()],
        withBackButton: true,
        appBarHeight: 64.h,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: form.key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const Divider(
                    color: AppColors.kGreyLight,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: Container(
                      width: 336.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.kGreyLight,
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                            child: UnicornOutlineButton(
                              minWidth: 80,
                              minHeight: 80,
                              strokeWidth: 2,
                              radius: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                  height: 85.h,
                                  width: 85.h,
                                  child: image != null
                                      ? Image.file(
                                          image!,
                                          fit: BoxFit.fitWidth,
                                        )
                                      : widget.profileModel?.photoUrl != null && widget.profileModel?.photoUrl != ""
                                          ? Image.network(
                                              (widget.profileModel?.photoUrl)!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/Rectangle.png',
                                              scale: 2,
                                            ),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            width: 139.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                            ),
                                            child: Wrap(
                                              alignment: WrapAlignment.end,
                                              crossAxisAlignment: WrapCrossAlignment.end,
                                              children: [
                                                ListTile(
                                                  title: const Text('Camera'),
                                                  leading: const Icon(Icons.camera),
                                                  onTap: () {
                                                    selectImage(imageSource: ImageSource.camera)
                                                        .then((value) => setState(() {
                                                              Navigator.pop(context);
                                                            }));
                                                  },
                                                ),
                                                ListTile(
                                                    title: const Text('Gallery'),
                                                    leading: const Icon(Icons.image),
                                                    onTap: () {
                                                      selectImage(imageSource: ImageSource.gallery)
                                                          .then((value) => setState(() {
                                                                Navigator.pop(context);
                                                              }));
                                                    })
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Edit your picture',
                                    style: AppTheme.subtitle2.copyWith(color: AppColors.kPOrangeColor, fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 2,
                                  ),
                                  child: Text(
                                    'The recommended size is 000x000 px',
                                    style: AppTheme.subtitle1.copyWith(
                                      color: AppColors.kGrayTextField,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [
                            LengthValidator(length: 35),
                          ],
                        );
                      },
                      labelText: 'First name',
                      initialValue: widget.profileModel?.generalInformation?.firstName,
                      focusNode: form.nodes[0],
                      nextFocusNode: form.nodes[1],
                      textEditingController: form.controllers[0],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [
                            LengthValidator(length: 35),
                          ],
                        );
                      },
                      labelText: 'Last name',
                      initialValue: widget.profileModel?.generalInformation?.lastName,
                      focusNode: form.nodes[1],
                      nextFocusNode: form.nodes[2],
                      textEditingController: form.controllers[1],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      initialValue: widget.profileModel?.generalInformation?.email,
                      labelText: 'Email',
                      focusNode: form.nodes[2],
                      nextFocusNode: form.nodes[3],
                      textEditingController: form.controllers[2],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      initialValue: widget.profileModel?.generalInformation?.phoneNumber,
                      labelText: 'Phone number',
                      focusNode: form.nodes[3],
                      nextFocusNode: form.nodes[4],
                      textEditingController: form.controllers[3],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      initialValue: widget.profileModel?.address?.address,
                      labelText: 'Address',
                      focusNode: form.nodes[4],
                      nextFocusNode: form.nodes[5],
                      textEditingController: form.controllers[4],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [
                            LengthValidator(length: 9),
                          ],
                        );
                      },
                      keyboardType: TextInputType.number,
                      initialValue: widget.profileModel?.address?.postalCode,
                      labelText: 'ZIP code',
                      focusNode: form.nodes[5],
                      nextFocusNode: form.nodes[6],
                      textEditingController: form.controllers[5],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [
                            LengthValidator(length: 60),
                          ],
                        );
                      },
                      initialValue: widget.profileModel?.address?.state,
                      labelText: 'State',
                      focusNode: form.nodes[6],
                      nextFocusNode: form.nodes[7],
                      textEditingController: form.controllers[6],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
                    child: CustomTextField(
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [
                            LengthValidator(length: 60),
                          ],
                        );
                      },
                      initialValue: widget.profileModel?.address?.country,
                      labelText: 'Country',
                      focusNode: form.nodes[7],
                      textEditingController: form.controllers[7],
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.kGreyLight,
                          )),
                      width: 336.w,
                      height: 66.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(logout),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              'Delete Account',
                              style: AppTheme.subtitle2.copyWith(fontSize: 16, color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocConsumer(
              bloc: profileCubit,
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  widget.callBack(state.data);
                  AppCustomAlertDialog.dialog(
                      widget: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        width: 300.w,
                        //height: 297.2.h,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 25.h,
                            ),
                            SvgPicture.asset(checkCircle),
                            SizedBox(
                              height: 22.h,
                            ),
                            Text(
                              'Changes have been saved',
                              style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            const Divider(
                              color: AppColors.kLightColor,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 90.w),
                                      child: CoustomButton(
                                        function: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        buttonName: "ok",
                                        backgoundColor: AppColors.kWhiteColor,
                                        borderSideColor: AppColors.kPDarkBlueColor,
                                        borderRadius: 10.0.r,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return const Center(child: LoadingIndicator());
                }
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
                          child: CoustomButton(
                            buttonName: "Save",
                            backgoundColor: AppColors.kWhiteColor,
                            borderSideColor: AppColors.kPDarkBlueColor,
                            borderRadius: 10.0.r,
                            function: () {
                              if (form.validate()) {
                                profileCubit.editProfile(
                                    params: GetFileParams(type: "image", file: image != null ? [image!] : []),
                                    editProfileParams: EditProfileParams(
                                        firstName: form.controllers[0].text,
                                        lastName: form.controllers[1].text,
                                        email: form.controllers[2].text,
                                        phoneNumber: form.controllers[3].text,
                                        address: form.controllers[4].text,
                                        postalCode: form.controllers[5].text,
                                        state: form.controllers[6].text,
                                        country: form.controllers[7].text,
                                        photoUrl: widget.profileModel?.photoUrl
                                        //type: CashHelper.getRole()
                                        ));
                              }
                            },
                          )),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 8;
}
