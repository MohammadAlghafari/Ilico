import 'dart:io';

import 'package:charja_charity/features/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/loading.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../add_section/data/usecase/upload_file_usecase.dart';
import '../../profile/data/use_case/edit_profile_usecase.dart';
import '../widgets/sign_header_widget.dart';

class SignUpUploadPicture extends StatefulWidget {
  const SignUpUploadPicture({Key? key}) : super(key: key);

  @override
  State<SignUpUploadPicture> createState() => _SignUpUploadPictureState();
}

class _SignUpUploadPictureState extends State<SignUpUploadPicture> {
  ProfileCubit profileCubit = ProfileCubit();
  File? image;
  Future<void> selectImage({required ImageSource imageSource}) async {
    final imagePicker = ImagePicker();
    var pickedFile = await imagePicker.pickImage(source: imageSource);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 220.h,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(startLine),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(Icon_Steps),
                          const SizedBox(width: 10),
                          Image.asset(
                            centerLine,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(iconFilled),
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Business informations",
                            style:
                                AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Upload picture",
                            style:
                                AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),
                    child: Text(
                      'Set a profile picture',
                      style: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Container(
                      width: 336.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.kGreyLight), borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  width: 76.w,
                                  height: 80.h,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kGreyWhite),
                                  child: image != null
                                      ? Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Center(
                                          child: SvgPicture.asset(
                                          uploadPicture,
                                        )),
                                ),
                              ),
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
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Upload photo',
                                    style: AppTheme.subtitle2.copyWith(fontSize: 14, color: AppColors.kPOrangeColor),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'The recommended size is 000x000 px',
                                    style: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocConsumer(
              bloc: profileCubit,
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  Navigation.goToHome();
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
                                profileCubit.editProfile(
                                    params: GetFileParams(type: "image", file: image != null ? [image!] : []),
                                    editProfileParams: EditProfileParams());
                              })),
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
}
