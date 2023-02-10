import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:charja_charity/features/add_section/data/usecase/search_of_service_by_name_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';
import '../../../core/utils/image_helper.dart';
import '../../../core/utils/validators/base_validator.dart';
import '../../../core/utils/validators/required_validator.dart';
import '../../explore/widget/article_dialog.dart';
import '../cubit/add_service_cubit.dart';
import '../data/model/search_article.dart';
import '../data/repository/add_section_repostory.dart';
import '../data/usecase/add_article_usecase.dart';
import '../data/usecase/delete_article_usecase.dart';
import '../data/usecase/edit_article.dart';
import '../data/usecase/upload_file_usecase.dart';
import '../widget/AddImageOrVideosWidget.dart';
import '../widget/PreviewImageOrVideosWidget.dart';

class EditArticleServiceScreen extends StatefulWidget {
  final ValueChanged valueChanged;
  final String? articleId;
  final bool? isEdit;
  final dynamic? article;
  const EditArticleServiceScreen({Key? key, this.isEdit, required this.valueChanged, this.articleId, this.article})
      : super(key: key);

  @override
  State<EditArticleServiceScreen> createState() => _EditArticleServiceScreenState();
}

class _EditArticleServiceScreenState extends State<EditArticleServiceScreen> with FormStateMinxin {
  AddServiceCubit articleCubit = AddServiceCubit();
  List<FileTypeImageOrVideos> list = [];
  List<File> files = [];

  String? name;
  TextEditingController? controller;
  String? id;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: name);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.article != null) {
        if (widget.isEdit == true) {
          // type = "update";
          form.controllers[0].text = widget.article!.title!;
          form.controllers[1].text = widget.article.text;

          if (widget.article!.images != null) {
            widget.article!.images!.forEach((element) {
              list.add(FileTypeImageOrVideos(type: 1, imageFile: element, imageType: "network"));
            });
          }
          if (widget.article!.videos != null) {
            widget.article!.videos!.forEach((element) {
              list.add(FileTypeImageOrVideos(type: 2, imageFile: element, imageType: "network"));
            });
          }
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'New article'.tr(),
        withBackButton: true,
        backgroundColor: AppColors.kWhiteColor,
        action: [
          if (widget.article != null)
            InkWell(
              child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: SvgPicture.asset(
                    trachIcon,
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
                            'Delete article'.tr(),
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
                              'Are you sure you would like delete the article?'.tr(),
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
                                  bloc: articleCubit,
                                  builder: (context, state) {
                                    if (state is DeleteArticleLoading) {
                                      return const Center(child: LoadingIndicator());
                                    }
                                    return CoustomButton(
                                      function: () {
                                        if (widget.article.id != null) {
                                          articleCubit.deleteArticle(
                                              deleteArticleParams: DeleteArticleParams(id: widget.article.id));
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
                                    if (state is DeleteArticleLoaded) {
                                      widget.valueChanged(true);

                                      Navigation.pop();
                                      Navigation.pop();
                                    } else if (state is DeleteArticleError) {
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
      body: Form(
        key: form.key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                color: AppColors.kGreyLight,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    CustomTextField(
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [RequiredValidator()],
                        );
                      },
                      focusNode: form.nodes[0],
                      nextFocusNode: form.nodes[1],
                      textEditingController: form.controllers[0],
                      hintText: 'Type the title'.tr(),
                      labelText: 'Title of the article'.tr(),
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        'Name of service provider'.tr(),
                        style: AppTheme.bodyText2.copyWith(fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                    TypeAheadField(
                      scrollController: ScrollController(),
                      suggestionsBoxVerticalOffset: -5.0,
                      textFieldConfiguration: TextFieldConfiguration(
                        textInputAction: TextInputAction.go,
                        controller: controller,
                        autofocus: false,
                        style: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 14),
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          hintText: 'Type the name of service provider'.tr(),
                          fillColor: AppColors.kLightColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.kMediumColor, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintStyle: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 14),
                          labelStyle: const TextStyle(color: AppColors.kGrayTextField, fontSize: 14),
                          // labelStyle: labelMedium(context,color: widgets.hintColor),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        List<SearchArticle> response;
                        id = null;
                        response = await autoCompleteSearch(pattern);
                        print(response);

                        return response;
                      },
                      itemBuilder: (_, SearchArticle suggestion) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                            child: Text(suggestion.generalInformation!.firstName!));
                      },
                      getImmediateSuggestions: false,
                      autoFlipDirection: true,
                      keepSuggestionsOnLoading: false,
                      hideOnLoading: false,
                      keepSuggestionsOnSuggestionSelected: false,
                      onSuggestionSelected: (suggestion) {
                        id = suggestion.id;
                        name = suggestion.generalInformation?.firstName!;
                        controller?.value = TextEditingValue(text: name!);
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 24.h,
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
                                        list.add(FileTypeImageOrVideos(
                                            type: 2, imageFile: element.path!, imageType: "file"));
                                        print("Is video");
                                      } else if (ImageHelper.isImage(element.path!)) {
                                        list.add(FileTypeImageOrVideos(
                                            type: 1, imageFile: element.path!, imageType: "file"));
                                        print("is Image");
                                      } else {
                                        print("File Not Support");
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
                      height: 24.h,
                    ),
                    CustomTextField(
                      maxLine: 8,
                      validator: (value) {
                        return BaseValidator.validateValue(
                          context,
                          value!,
                          [RequiredValidator()],
                        );
                      },
                      focusNode: form.nodes[1],
                      textEditingController: form.controllers[1],
                      hintText: 'Type your article'.tr(),
                      labelText: 'Your article'.tr(),
                      labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocConsumer(
                      bloc: articleCubit,
                      listener: (context, state) {
                        if (state is CreateArticleLoaded) {
                          list.clear();
                          files.clear();
                          widget.valueChanged(true);
                          Navigation.pop();
                        } else if (state is CreateArticleError) {
                          Dialogs.showSnackBar(
                              message: (state.error!.message!.first.toString()),
                              typeSnackBar: AnimatedSnackBarType.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is CreateArticleLoading) {
                          return const Center(child: CupertinoActivityIndicator(radius: 15));
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: CoustomButton(
                                    buttonName: "Submit new".tr(),
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
                                      if (form.validate()) {
                                        if (widget.isEdit!) {
                                          articleCubit.editArticle(
                                              params: GetFileParams(type: "image", file: files),
                                              editArticleParams: EditArticleParams(
                                                  id: widget.articleId,
                                                  serviceProviderId: id,
                                                  title: form.controllers[0].text,
                                                  text: form.controllers[1].text,
                                                  videos: oldvideoList,
                                                  images: oldimageList));
                                        } else {
                                          articleCubit.createArticle(
                                              params: GetFileParams(type: "image", file: files),
                                              addArticleParams: AddArticleParams(
                                                serviceProviderId: id,
                                                title: form.controllers[0].text,
                                                text: form.controllers[1].text,
                                              ));
                                        }
                                      }

                                      //  files.clear()
                                    }),
                              ),
                            ),
                          ],
                        );
                      },
                    )
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

  autoCompleteSearch(String value) async {
    final response =
        await SearchArticleUseCase(AddSectionRepostory()).call(params: SearchArticleParams(count: 60, name: value));

    return response.data!.data!;
  }
}
