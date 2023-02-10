import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/ui/gallery_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/loading.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../add_section/cubit/add_service_cubit.dart';
import '../../add_section/data/usecase/add_media_usecase.dart';
import '../../add_section/data/usecase/upload_file_usecase.dart';
import '../../add_section/ui/artice_screen.dart';
import '../../add_section/ui/edit_article_screen.dart';
import '../../user_managment/widgets/social_media_widget.dart';

class MyContent extends StatefulWidget {
  const MyContent({Key? key, required this.userInfo, required this.callBack}) : super(key: key);
  final ProfileInfluencerModel? userInfo;
  final ValueChanged callBack;
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedTabIndex = 0;
  late PaginationCubit articleCubit;
  late PaginationCubit galleryCubit;
  AddServiceCubit cubit = AddServiceCubit();
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        title: 'My Content'.tr(),
        withBackButton: true,
        action: [
          selectedTabIndex == 1
              ? IconButton(
                  onPressed: () {
                    if (selectedTabIndex == 1) {
                      Navigation.push(EditArticleServiceScreen(
                        isEdit: false,
                        valueChanged: (val) {
                          articleCubit.getList();
                        },
                      ));
                    } else {}
                  },
                  icon: SvgPicture.asset(addIcon))
              : selectedTabIndex == 2
                  ? BlocConsumer(
                      listener: (BuildContext context, Object? state) {
                        if (state is AddMediaLoaded) {
                          galleryCubit.getList();
                          setState(() {});

                          print("done");
                        } else if (state is AddMediaError) {
                          Dialogs.showSnackBar(
                              message: (state.error!.message!.first.toString()),
                              typeSnackBar: AnimatedSnackBarType.error);
                        }
                      },
                      builder: (BuildContext context, state) {
                        if (state is AddMediaLoading) {
                          return Center(child: LoadingIndicator());
                        } else {
                          return IconButton(
                              onPressed: () async {
                                print("index **********************" + tabController.index.toString());

                                if (selectedTabIndex == 2) {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                  );
                                  if (result != null) {
                                    List<File> file = [File(result.files[0].path!)];
                                    cubit.addMedia(
                                        params: GetFileParams(file: file, type: ""), addMediaParams: AddMediaParams());
                                  }
                                }
                                // setState(() {
                                //   cubitMedia.getList();
                                // });
                              },
                              icon: SvgPicture.asset(addIcon));
                        }
                      },
                      bloc: cubit,
                    )
                  : Container()
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.kWhiteProfileCardIconArea,
            child: TabBar(
              isScrollable: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              indicatorColor: AppColors.kPDarkBlueColor,
              padding: EdgeInsets.zero,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              onTap: (int index) {
                selectedTabIndex = index;
                setState(() {});
              },
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              labelColor: Colors.black,
              unselectedLabelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
              labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
              tabs: [
                Tab(
                  child: Text(
                    'Social networks'.tr(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Articles'.tr(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Gallery'.tr(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SocialMediaWidget(
                      btnName: "Save".tr(),
                      model: widget.userInfo,
                      callback: widget.callBack,
                    ),
                  ),
                ),
                ArticleScreen(voidCallback: (val) {
                  articleCubit = val;
                }),
                GalleryScreen(valueChanged: (val) {
                  galleryCubit = val;
                }),
                // SocialMediaWidget(
                //   btnName: "Save",
                // ),
                // SocialMediaWidget(btnName: "Save"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
