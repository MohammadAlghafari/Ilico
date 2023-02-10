import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/add_section/data/model/get_product_model.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_service_product_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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
import '../data/usecase/update_event_usecase.dart';
import '../data/usecase/update_service_usecase.dart';
import '../widget/AddImageOrVideosWidget.dart';
import '../widget/PreviewImageOrVideosWidget.dart';

class EditProductServicEvent extends StatefulWidget {
  const EditProductServicEvent(
      {Key? key, this.appBar_title, this.page_type, this.activites, required this.service, required this.valueChanged})
      : super(key: key);
  final String? appBar_title;
  final int? page_type; //1:S , 2:P , 3:E
  final List<Activities>? activites;
  final dynamic service;
  final ValueChanged valueChanged;

  @override
  _EditProductServicEventState createState() => _EditProductServicEventState();
}

class _EditProductServicEventState extends State<EditProductServicEvent> with FormStateMinxin {
  List<FileTypeImageOrVideos> list = [];
  AddServiceCubit cubit = AddServiceCubit();
  List<File> files = [];
  DateTime? startDate;
  DateTime? endDate;

  // String? activityId;
  String? type = "create";
  Category? category;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.service != null) {
        if (widget.page_type == 3) {
          type = "update";
          form.controllers[0].text = widget.service!.name!;
          //pickedDate output format => 2021-03-10 00:00:00.000
          startDate = DateTime.parse(widget.service!.startDate!);
          String formattedstartDate = DateFormat('yyyy-MM-dd').format(startDate!);
          form.controllers[1].text = formattedstartDate;
          endDate = DateTime.parse(widget.service!.endDate!);
          String formattedendDate = DateFormat('yyyy-MM-dd').format(endDate!);

          form.controllers[2].text = formattedendDate;
          form.controllers[3].text = widget.service!.description!;
          if (widget.service!.images != null) {
            widget.service!.images!.forEach((element) {
              list.add(FileTypeImageOrVideos(type: 1, imageFile: element, imageType: "network"));
            });
          }
          if (widget.service!.videos != null) {
            widget.service!.videos!.forEach((element) {
              list.add(FileTypeImageOrVideos(type: 2, imageFile: element, imageType: "network"));
            });
          }
          setState(() {});
        } else {
          type = "update";
          form.controllers[0].text = widget.service!.name!;
          form.controllers[2].text = widget.service!.price!.toString();
          form.controllers[3].text = widget.service!.description!;
          if (widget.service!.images != null) {
            widget.service!.images!.forEach((element) {
              list.add(FileTypeImageOrVideos(type: 1, imageFile: element, imageType: "network"));
            });
          }
          if (widget.service!.videos != null) {
            widget.service!.videos!.forEach((element) {
              list.add(FileTypeImageOrVideos(type: 2, imageFile: element, imageType: "network"));
            });
          }
          if (widget.service!.category != null) {
            category = widget.service!.category;
            form.controllers[1].text = category!.name!;
          }
          setState(() {});
        }
        //form.controllers[0].text=widget.service.
      }
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'New ${widget.appBar_title}'.tr(),
        withBackButton: true,
        backgroundColor: AppColors.kWhiteColor,
        action: [
          if (widget.service != null)
            InkWell(
              child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: SvgPicture.asset(
                    trachIcon,
                    // height: 50.h,
                    // width: 14,
                  )),
              onTap: () {
                AppCustomAlertDialog.dialog(
                    widget: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      width: 300.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            'Delete ${widget.appBar_title}'.tr(),
                            style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.w),
                            child: Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              'Are you sure you would like delete the ${widget.appBar_title}?'.tr(),
                              style: AppTheme.subtitle1.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14),
                            ),
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Row(
                              children: [
                                CoustomButton(
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                  buttonName: "Cancel".tr(),
                                  backgoundColor: AppColors.kWhiteColor,
                                  borderSideColor: AppColors.kPDarkBlueColor,
                                  borderRadius: 10.0.r,
                                  width: 114.w,
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                BlocConsumer(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    if (state is DeleteEventLoading) {
                                      return const Center(child: LoadingIndicator());
                                    }
                                    if (state is DeleteServiceOrProductLoading) {
                                      return const Center(child: LoadingIndicator());
                                    }
                                    return CoustomButton(
                                      function: () {
                                        if (widget.page_type == 3 && widget.service != null) {
                                          cubit.deleteEvent(
                                              deleteEventParams: DeleteEventParams(id: widget.service!.id));
                                        } else if (widget.page_type == 2 && widget.service != null) {
                                          cubit.deleteServiceOrProduct(
                                              deleteServiceProductParams:
                                                  DeleteServiceProductParams(id: widget.service!.id, type: 2));
                                        } else if (widget.page_type == 1 && widget.service != null) {
                                          cubit.deleteServiceOrProduct(
                                              deleteServiceProductParams:
                                                  DeleteServiceProductParams(id: widget.service!.id, type: 1));
                                        }
                                      },
                                      buttonName: 'Delete'.tr(),
                                      backgoundColor: AppColors.kWhiteColor,
                                      borderSideColor: AppColors.kPDarkBlueColor,
                                      borderRadius: 10.0.r,
                                      width: 114.w,
                                    );
                                  },
                                  listener: (BuildContext context, Object? state) {
                                    if (state is DeleteEventLoaded) {
                                      widget.valueChanged(true);

                                      Navigation.pop();
                                      Navigation.pop();
                                    } else if (state is DeleteServiceOrProductLoaded) {
                                      widget.valueChanged(true);

                                      Navigation.pop();
                                      Navigation.pop();
                                    } else if (state is DeleteEventError) {
                                      Dialogs.showSnackBar(
                                          message: (state.error!.message!.first.toString()),
                                          typeSnackBar: AnimatedSnackBarType.error);
                                    } else if (state is DeleteServiceOrProductError) {
                                      Dialogs.showSnackBar(
                                          message: (state.error!.message!.first.toString()),
                                          typeSnackBar: AnimatedSnackBarType.error);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                    context: context);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
        child: Form(
          key: form.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: '${widget.appBar_title} name'.tr(),
                labelStyle: AppTheme.bodyText2,
                hintText: '${widget.appBar_title} name'.tr(),
                textEditingController: form.controllers[0],
                focusNode: form.nodes[0],
                inputFormatters: [
                  LengthLimitingTextInputFormatter(60),
                ],
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
              widget.page_type == 3
                  ? CustomTextField(
                      labelText: 'Event’s start date'.tr(),
                      labelStyle: AppTheme.bodyText2,
                      hintText: '00/00/0000',
                      textEditingController: form.controllers[1],
                      focusNode: form.nodes[1],
                      nextFocusNode: form.nodes[3],
                      readOnly: true,
                      validator: (v) => BaseValidator.validateValue(
                        context,
                        form.controllers[1].text,
                        [
                          RequiredValidator(),
                          // LengthValidator(length: 35),
                        ],
                      ),
                      //nextFocusNode: form.nodes[widget.page_type != 3 ? 2 : 3],
                      onTab: () async {
                        startDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );

                        if (startDate != null) {
                          print(startDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(startDate!);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            form.controllers[1].text = formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    )
                  : CustomTextField(
                      labelText: 'Select the activity'.tr(),
                      labelStyle: AppTheme.bodyText2,
                      hintText: 'Activity'.tr(),
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
                              category = Category(
                                  id: element.id,
                                  name: element.name!,
                                  description: element.description,
                                  isActive: element.isActive);
                              //category!.id = element.id;
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
              if (widget.page_type != 3)
                Text(
                  "Choose an activity related to your service (included in your subscription)".tr(),
                  style: AppTheme.subtitle1.copyWith(fontSize: 11, color: AppColors.kGrayTextField),
                ),
              widget.page_type != 3
                  ? CustomTextField(
                      labelText: '${widget.appBar_title}’s price'.tr(),
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
                    )
                  : CustomTextField(
                      labelText: 'Event’s end date'.tr(),
                      labelStyle: AppTheme.bodyText2,
                      hintText: '00/00/0000',
                      textEditingController: form.controllers[2],
                      focusNode: form.nodes[2],
                      nextFocusNode: form.nodes[3],
                      readOnly: true,
                      validator: (v) => BaseValidator.validateValue(
                        context,
                        form.controllers[2].text,
                        [
                          RequiredValidator(),
                          // LengthValidator(length: 35),
                        ],
                      ),
                      //nextFocusNode: form.nodes[widget.page_type != 3 ? 2 : 3],
                      onTab: () async {
                        endDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );

                        if (endDate != null) {
                          //  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          print(endDate!.toUtc().toString());
                          String formattedDate = DateFormat('yyyy-MM-dd').format(endDate!);
                          //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            form.controllers[2].text = formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
              CustomTextField(
                labelText: '${widget.appBar_title}’s description'.tr(),
                labelStyle: AppTheme.bodyText2,
                hintText: 'Type description'.tr(),
                textEditingController: form.controllers[3],
                focusNode: form.nodes[3],
                maxLine: 5,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(500),
                ],
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
                "Add pictures/videos".tr(),
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
                                  list.add(FileTypeImageOrVideos(type: 2, imageFile: element.path!, imageType: "file"));
                                  print("Is video");
                                } else if (ImageHelper.isImage(element.path!)) {
                                  list.add(FileTypeImageOrVideos(type: 1, imageFile: element.path!, imageType: "file"));
                                  print("is Image");
                                } else {
                                  print("File Not Support");
                                }
                              });
                            }
                            setState(() {
                              //     list.add(true);
                            });
                          },
                        );
                      } else {
                        return PreviewImageOrVideosWidget(
                          imageType: list[index].imageType!,
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
                    widget.valueChanged(true);

                    Navigation.pop();
                  } else if (state is AddEventLoaded) {
                    list.clear();
                    files.clear();
                    widget.valueChanged(true);

                    Navigation.pop();
                  } else if (state is AddServiceError) {
                    Dialogs.showSnackBar(
                        message: (state.error!.message!.first.toString()), typeSnackBar: AnimatedSnackBarType.error);
                  } else if (state is AddEventError) {
                    Dialogs.showSnackBar(
                        message: (state.error!.message!.first.toString()), typeSnackBar: AnimatedSnackBarType.error);
                  }
                },
                builder: (context, state) {
                  if (state is AddServiceLoading) {
                    return const Center(child: LoadingIndicator());
                  }
                  if (state is AddEventLoading) {
                    return const Center(child: LoadingIndicator());
                  }
                  String buttonTitle = widget.appBar_title!.toLowerCase();
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CoustomButton(
                              buttonName: "Submit new $buttonTitle".tr(),
                              // height: 50,
                              // width: 336,
                              backgoundColor: AppColors.kWhiteColor,
                              borderSideColor: AppColors.kPDarkBlueColor,
                              borderRadius: 10.0.r,
                              function: () {
                                List<String>? oldimageList = [];
                                List<String>? oldvideoList = [];
                                list.forEach((element) {
                                  if (element.imageType == "file") {
                                    files.add(File(element.imageFile!));
                                  } else if (element.imageType == "network") {
                                    if (element.type == 1) {
                                      oldimageList.add(element.imageFile!);
                                    } else if (element.type == 2) {
                                      oldvideoList.add(element.imageFile!);
                                    }
                                  }
                                });
                                if (type == "create") {
                                  if (form.validate()) {
                                    if (widget.page_type != 3) {
                                      cubit.addService(
                                          params: GetFileParams(type: "image", file: files),
                                          addServiceParams: AddServiceParams(
                                            id: null,
                                            name: form.controllers[0].text,
                                            price: double.parse(form.controllers[2].text),
                                            description: form.controllers[3].text,
                                            type: widget.page_type,
                                            categoryId: category!.id,
                                          ));
                                    } else {
                                      //   DateTime? date = DateTime.tryParse(form.controllers[1].text);
                                      cubit.addEvent(
                                          params: GetFileParams(type: "image", file: files),
                                          addEventParams: AddEventParams(
                                            name: form.controllers[0].text,
                                            startdate: startDate!.toUtc().toString(),
                                            enddate: endDate!.toUtc().toString(),
                                            description: form.controllers[3].text,
                                          ));
                                    }
                                  }
                                } else {
                                  if (form.validate()) {
                                    if (widget.page_type == 3) {
                                      print("update event");
                                      cubit.updateEvent(
                                          params: GetFileParams(type: "image", file: files),
                                          updateEventParams: UpdateEventParams(
                                            name: form.controllers[0].text,
                                            startDate: startDate!.toUtc().toString(),
                                            endDate: endDate!.toUtc().toString(),
                                            description: form.controllers[3].text,
                                            id: widget.service!.id,
                                            images: oldimageList,
                                            videos: oldvideoList,
                                            type: widget.page_type,
                                          ));
                                    } else {
                                      print("update");
                                      cubit.updateService(
                                          params: GetFileParams(type: "image", file: files),
                                          updateServiceParams: UpdateServiceParams(
                                            id: widget.service!.id,
                                            name: form.controllers[0].text,
                                            price: double.parse(form.controllers[2].text),
                                            description: form.controllers[3].text,
                                            //files: files,
                                            images: oldimageList,
                                            videos: oldvideoList,
                                            type: widget.page_type,
                                            categoryId: category!.id,
                                          ));
                                    }
                                  }
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
