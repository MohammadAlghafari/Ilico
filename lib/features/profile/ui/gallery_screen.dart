import 'package:charja_charity/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:charja_charity/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_media_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/get_media_usecase.dart';
import 'package:charja_charity/features/profile/widgets/callery_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/models/imageOrVideosFileType.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../add_section/data/model/add_media_model.dart';
import '../../add_section/data/repository/add_section_repostory.dart';
import '../../explore/widget/article_dialog.dart';

class GalleryScreen extends StatefulWidget {
  final ValueChanged valueChanged;
  const GalleryScreen({required this.valueChanged});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<FileTypeImageOrVideos> fileList = [];
  late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: PaginationList<AddMediaModel>(
          onCubitCreated: (PaginationCubit cub) {
            cubit = cub;
            widget.valueChanged(cubit);
          },
          withPagination: true,
          repositoryCallBack: (model) {
            return GetMediaUseCase(AddSectionRepostory()).call(
                params: GetMediaParams(
              request: model,
            ));
          },
          listBuilder: (list) {
            return GridView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 1),
              itemBuilder: (context, index) {
                list.forEach((element) {});
                return GalleryWidget(
                  imageType: "network",
                  key: ValueKey(list[index]),
                  image: list[index].media!,
                  Type: list[index].type == "Video" ? 2 : 1,
                  previewImage: () {
                    list.forEach((element) {
                      fileList.add(FileTypeImageOrVideos(
                          type: element.type == "Video" ? 2 : 1, imageFile: element.media, imageType: "network"));
                    });
                    AppCustomAlertDialog.dialog(
                        widget: ArticleDialog(
                          initIndex: index,
                          imageOrVideosList: fileList,
                        ),
                        context: context);
                    setState(() {});
                  },
                  deleteImage: () {
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
                                    "Delete Media".tr(),
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
                                      'Are you sure you would like delete this Media?'.tr(),
                                      style:
                                          AppTheme.subtitle1.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14),
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
                                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
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
                                        CreateModel(
                                          withValidation: false,
                                          onSuccess: (model) {
                                            if (model != null) {
                                              Navigation.pop();
                                              cubit.getList();
                                            }
                                          },
                                          useCaseCallBack: (data) {
                                            return DeleteMediaUseCase(AddSectionRepostory())
                                                .call(params: DeleteMediaParams(id: list[index].id));
                                          },
                                          child: Center(
                                            child: CoustomButton(
                                              buttonName: 'Delete'.tr(),
                                              backgoundColor: AppColors.kWhiteColor,
                                              borderSideColor: AppColors.kPDarkBlueColor,
                                              borderRadius: 10.0.r,
                                              width: 114.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ])),
                        context: context);

                    // setState(() {});
                  },
                );
              },
            );
          }),
    );
  }
}
