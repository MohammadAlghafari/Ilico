import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/models/imageOrVideosFileType.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/loading.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/image_helper.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../../explore/widget/article_dialog.dart';
import '../../user_managment/ui/choise_category_screen.dart';
import '../cubit/add_service_cubit.dart';
import '../widget/AddImageOrVideosWidget.dart';
import '../widget/PreviewImageOrVideosWidget.dart';

class EditProductServicEvent extends StatefulWidget {
  const EditProductServicEvent({Key? key, this.appBar_title, this.page_type, this.activites}) : super(key: key);
  final String? appBar_title;
  final int? page_type; //1:S , 2:P , 3:E
  final List<Activities>? activites;

  @override
  _EditProductServicEventState createState() => _EditProductServicEventState();
}

class _EditProductServicEventState extends State<EditProductServicEvent> with FormStateMinxin {
  List<FileTypeImageOrVideos> list = [];
  AddServiceCubit cubit = AddServiceCubit();
  List<File> files = [];
  String? activityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'New ${widget.appBar_title}',
        withBackButton: true,
        action: [],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
        child: Form(
          key: form.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: '${widget.appBar_title} name',
                labelStyle: AppTheme.bodyText2,
                hintText: '${widget.appBar_title} name',
                textEditingController: form.controllers[0],
                focusNode: form.nodes[0],
                nextFocusNode: form.nodes[widget.page_type != 3 ? 2 : 3],
                validator: (v) => BaseValidator.validateValue(
                  context,
                  form.controllers[0].text,
                  [
                    RequiredValidator(),
                    // LengthValidator(length: 35),
                  ],
                ),
              ),
              CustomTextField(
                labelText: 'Select the activity',
                labelStyle: AppTheme.bodyText2,
                hintText: 'Activity',
                textEditingController: form.controllers[1],
                focusNode: form.nodes[1],
                validator: (v) => BaseValidator.validateValue(
                  context,
                  form.controllers[1].text,
                  [
                    RequiredValidator(),
                    // LengthValidator(length: 35),
                  ],
                ),
                //nextFocusNode: form.nodes[widget.page_type != 3 ? 2 : 3],
                onTab: () {
                  Navigation.push(SelectGategories(
                    activites: widget.activites,
                  ))?.then((value) {
                    widget.activites?.forEach((element) {
                      if (element.isSelected == true) {
                        activityId = element.id;
                        form.controllers[1].text = element.name!;
                      }
                    });
                  });
                },
                isSuffixIcon: true,
                readOnly: true,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.kPDarkBlueColor,
                ),
              ),
              Text(
                "Choose an activity related to your service (included in your subscription)",
                style: AppTheme.subtitle1.copyWith(fontSize: 11, color: AppColors.kGrayTextField),
              ),
              if (widget.page_type != 3)
                CustomTextField(
                  labelText: '${widget.appBar_title}’s price',
                  labelStyle: AppTheme.bodyText2,
                  hintText: '00.00  ',
                  textEditingController: form.controllers[2],
                  focusNode: form.nodes[2],
                  nextFocusNode: form.nodes[3],
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  isSuffixIcon: true,
                  validator: (v) => BaseValidator.validateValue(
                    context,
                    form.controllers[2].text,
                    [
                      RequiredValidator(),
                      // LengthValidator(length: 35),
                    ],
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(euro),
                  ),
                ),
              CustomTextField(
                labelText: '${widget.appBar_title}’s description',
                labelStyle: AppTheme.bodyText2,
                hintText: 'Type description',
                textEditingController: form.controllers[3],
                focusNode: form.nodes[3],
                maxLine: 5,
                validator: (v) => BaseValidator.validateValue(
                  context,
                  form.controllers[3].text,
                  [
                    RequiredValidator(),
                    // LengthValidator(length: 35),
                  ],
                ),
                // nextFocusNode: form.nodes[4],
                // keyboardType: TextInputType.number,
                //  isSuffixIcon: true,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                "Add pictures/videos",
                style: AppTheme.bodyText2,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                height: 100.h,
                // width: 1.sw,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == list.length) {
                        return AddImageOrVideosWidget(
                          function: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              allowMultiple: true,

                            );
                            if (result != null) {
                              print(result.files[0].size);
                              result.files.forEach((element) {
                                if (ImageHelper.isVideo(element.path!)) {
                                  list.add(FileTypeImageOrVideos(type: 2, imageFile: File(element.path!)));
                                  print("Is video");
                                } else if (ImageHelper.isImage(element.path!)) {
                                  list.add(FileTypeImageOrVideos(type: 1, imageFile: File(element.path!)));
                                  print("is Image");
                                } else {
                                  print("File Not Support");
                                }
                              });

                              /*= result.files.first.path!;*/
                            }
                            setState(() {
                              //     list.add(true);
                            });
                          },
                        );
                      } else {
                        /* VideoPlayerController controller = VideoPlayerController.file(list[index].imageFile!)
                          ..initialize().then((_) {
                            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                            setState(() {});
                          });*/
                        return PreviewImageOrVideosWidget(
                          key: ValueKey(list[index]),
                          image: list[index].imageFile!,
                          Type: list[index].type!,
                          previewImage: () {
                            AppCustomAlertDialog.dialog(
                                widget: ArticleDialog(
                                  initIndex: index,
                                  imageOrVideosList: list,
                                ),
                                context: context);
                            setState(() {});
                          },
                          deleteImage: () {
                            print(index);
                            list.remove(list[index]);
                            setState(() {});
                          },
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 18.w,
                      );
                    },
                    itemCount: list.length + 1),
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocConsumer(
                bloc: cubit,
                listener: (context, state) {
                  if (state is AddServiceLoaded) {
                    list.clear();
                    files.clear();
                    Navigation.pop();
                    print('success');
                  } else if (state is AddServiceError) {
                    Dialogs.showSnackBar(
                        message: (state.error?.message?.first.toString())!, typeSnackBar: AnimatedSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is AddServiceLoading) {
                    return const Center(child: LoadingIndicator());
                  }
                  String buttonTitle = widget.appBar_title!.toLowerCase();
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CoustomButton(
                              buttonName: "Submit new$buttonTitle",
                              // height: 50,
                              // width: 336,
                              backgoundColor: AppColors.kWhiteColor,
                              borderSideColor: AppColors.kPDarkBlueColor,
                              borderRadius: 10.0.r,
                              function: () {
                                list.forEach((element) {
                                  files.add(element.imageFile!);
                                });

                                if (form.validate()) {
                                  cubit.addService(
                                      params: GetFileParams(type: "image", file: files),
                                      addServiceParams: AddServiceParams(
                                        name: form.controllers[0].text,
                                        price: double.parse(form.controllers[2].text),
                                        description: form.controllers[3].text,
                                        //  files: list,
                                        type: widget.page_type,
                                        categoryId: activityId,
                                      ));
                                }

                                //  files.clear()
                              }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  int numberOfFields() => 4;
}
