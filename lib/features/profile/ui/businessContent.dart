import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/add_section/cubit/add_service_cubit.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_media_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:charja_charity/features/add_section/ui/edit_Product_Service_Event.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/ui/event_screen.dart';
import 'package:charja_charity/features/profile/ui/product_screen.dart';
import 'package:charja_charity/features/profile/ui/services_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/loading.dart';
import '../../../core/utils/image_helper.dart';
import '../../add_section/data/repository/add_section_repostory.dart';
import '../../add_section/ui/artice_screen.dart';
import '../../add_section/ui/edit_article_screen.dart';
import '../widgets/company_Widget.dart';
import 'gallery_screen.dart';

class BusinessContent extends StatefulWidget {
  final ValueChanged callBack;
  final ValueChanged valueChanged;
  UserInfo profileModel;

  BusinessContent({Key? key, required this.profileModel, required this.callBack, required this.valueChanged})
      : super(key: key);

  @override
  _BusinessContentState createState() => _BusinessContentState();
}

class _BusinessContentState extends State<BusinessContent> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int SelectedTabIndex = 0;
  late PaginationCubit cubitService;
  late PaginationCubit cubitProduct;
  late PaginationCubit cubitEvent;
  late PaginationCubit articleCubit;
  late PaginationCubit cubitMedia;
  AddServiceCubit cubit = AddServiceCubit();

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Business content'.tr(),
        withBackButton: true,
        action: [
          SelectedTabIndex == 1 || SelectedTabIndex == 2 || SelectedTabIndex == 3 || SelectedTabIndex == 5
              ? IconButton(
                  onPressed: () {
                    print("index **********************" + tabController.index.toString());

                    if (SelectedTabIndex == 1) {
                      //  print(widget.profileModel.activities![0]);
                      Navigation.push(EditProductServicEvent(
                        valueChanged: (val) {
                          cubitService.getList();
                        },
                        appBar_title: "Service",
                        page_type: 1,
                        activites: widget.profileModel.activities,
                        service: null,
                      ));
                    } else if (SelectedTabIndex == 2) {
                      Navigation.push(EditProductServicEvent(
                        valueChanged: (val) {
                          cubitProduct.getList();
                        },
                        appBar_title: "Products",
                        page_type: 2,
                        activites: widget.profileModel.activities,
                        service: null,
                      ));
                    } else if (SelectedTabIndex == 3) {
                      Navigation.push(EditProductServicEvent(
                        valueChanged: (val) {
                          cubitEvent.getList();
                        },
                        appBar_title: "Events",
                        page_type: 3,
                        activites: widget.profileModel.activities,
                        service: null,
                      ));
                    } else if (SelectedTabIndex == 5) {
                      Navigation.push(EditArticleServiceScreen(
                        isEdit: false,
                        valueChanged: (val) {
                          articleCubit.getList();
                        },
                      ));
                      //  print(SelectedTabIndex);
                    }
                  },
                  icon: SvgPicture.asset(addIcon))
              : SelectedTabIndex == 4
                  ? BlocConsumer(
                      listener: (BuildContext context, Object? state) {
                        if (state is AddMediaLoaded) {
                          cubitMedia.getList();
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

                                if (SelectedTabIndex == 4) {
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
                  : Container(),
        ],
      ),
      body: Container(
        // height: 80.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // height: 80.h,
              color: AppColors.kWhiteProfileCardIconArea,
              child: TabBar(
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                indicatorColor: AppColors.kPDarkBlueColor,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                onTap: (int index) {
                  //  SelectedTabIndex = index;
                  setState(() {
                    SelectedTabIndex = index;
                  });
                },
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                labelColor: Colors.black,
                unselectedLabelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
                tabs: [
                  Tab(
                    child: Text(
                      'Company'.tr(),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Services'.tr(),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Products'.tr(),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Events'.tr(),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Gallery'.tr(),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Articles'.tr(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Container(
                    //height: 100.h,
                    child: CompanyWidget(
                      callBack: widget.callBack,
                      profileModel: widget.profileModel as ProfileSpModel,
                    ),
                  ),
                  ServicesScreen(
                    voidCallback: (val) {
                      cubitService = val;
                    },
                    activities: widget.profileModel.activities!,
                  ),
                  ProductScreen(
                    valueChanged: (val) {
                      cubitProduct = val;
                    },
                    activities: widget.profileModel.activities!,
                  ),
                  EventScreen(
                      activities: widget.profileModel.activities!,
                      valueChanged: (val) {
                        cubitEvent = val;
                      }), //event
                  GalleryScreen(
                    valueChanged: (val) {
                      cubitMedia = val;
                    },
                  ),
                  //gallery
                  ArticleScreen(voidCallback: (val) {
                    articleCubit = val;
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null) {
      if (ImageHelper.isVideo(result.files[0].path!)) {
        AddMediaUseCase(AddSectionRepostory())
            .call(params: AddMediaParams(type: "Video", media: result.files[0].path!));
        print("Is video");
      } else if (ImageHelper.isImage(result.files[0].path!)) {
        AddMediaUseCase(AddSectionRepostory())
            .call(params: AddMediaParams(type: "Image", media: result.files[0].path!));
        print("is Image");
      } else {
        print("File Not Support");
      }
    }
    setState(() {
      cubitMedia.getList();
      //     list.add(true);
    });
  }
}
