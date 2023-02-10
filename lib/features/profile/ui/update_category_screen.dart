import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../profile/data/model/profile_model.dart';
import '../../user_managment/data/repository/auth_repository.dart';
import '../../user_managment/data/usecase/assign_category.dart';
import '../../user_managment/data/usecase/get_category_usecase.dart';
import '../../user_managment/ui/choise_category_screen.dart';

class UpdateCategoryScreen extends StatefulWidget {
  UpdateCategoryScreen({
    this.categoryNumber,
    Key? key,
    /*required this.userActivities*/
  }) : super(key: key);

  // final List<Activities> userActivities;
  int? categoryNumber;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  String? role = CashHelper.getRole();
  List<Activities>? categoryModelList;
  int activityNumber = 0;
  @override
  void initState() {
    if (CashHelper.getRole() == "ServiceProvider") {
      activityNumber = widget.categoryNumber!;
    } else {
      activityNumber = 3;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 29.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              child: Text(
                'Select ${activityNumber} categories you are interested in'.tr(),
                style: AppTheme.subtitle2.copyWith(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 29.h,
            ),
            Expanded(
              child: PaginationList<Activities>(
                withPagination: true,
                listBuilder: (list) {
                  categoryModelList = list;
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
                          child: Container(
                            width: 200.w,
                            height: 44.h,
                            decoration: list[index].isSelected
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.kPDarkBlueColor))
                                : const BoxDecoration(),
                            child: MyRadio(
                                categoryModel: list[index],
                                value: list[index].isSelected,
                                onChange: (bool val) {
                                  list[index].isSelected = val;
                                  setState(() {});
                                }),
                          ),
                        );
                      });
                },
                repositoryCallBack: (model) {
                  return GetCategoriesUseCase(AuthRepository()).call(
                      params: GetCategoriesParams(
                    request: model,
                  ));
                },
              ),
            ),
            CreateModel(
              withValidation: false,
              onSuccess: (model) {
                Navigation.pop();
              },
              useCaseCallBack: (model) {
                List<String>? selectedIds;
                int count;
                final categoryModelList = this.categoryModelList;
                if (categoryModelList != null && categoryModelList.isNotEmpty) {
                  selectedIds = [];
                  count = 0;
                  for (var element in categoryModelList) {
                    if (element.isSelected) {
                      selectedIds.add(element.id!);
                      count++;
                      print(selectedIds);
                      print('the count]]]]]]]]]]]]]]]$count');
                    }
                  }

                  if (CashHelper.getRole() == "ServiceProvider") {
                    if (count == activityNumber) {
                      return AssignCategoryUseCase(AuthRepository())
                          .call(params: AssignCategoryParams(categoriesIds: selectedIds));
                    } else if (count >= activityNumber) {
                      Dialogs.showSnackBar(
                          message: 'Please select only'.tr() + " ${activityNumber}" + 'categories to proceed'.tr(),
                          typeSnackBar: AnimatedSnackBarType.warning);
                    } else {
                      Dialogs.showSnackBar(
                          message: 'Please select at least'.tr() + "${activityNumber}" + ' categories to proceed'.tr(),
                          typeSnackBar: AnimatedSnackBarType.warning);
                    }
                  } else {
                    if (count >= activityNumber) {
                      return AssignCategoryUseCase(AuthRepository())
                          .call(params: AssignCategoryParams(categoriesIds: selectedIds));
                    } else {
                      Dialogs.showSnackBar(
                          message: 'Please select at least'.tr() + "${activityNumber}" + ' categories to proceed'.tr(),
                          typeSnackBar: AnimatedSnackBarType.warning);
                    }
                  }
                }
                return null;
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 8.h),
                      child: CoustomButton(
                        buttonName: "Continue".tr(),
                        backgoundColor: AppColors.kWhiteColor,
                        borderSideColor: AppColors.kPDarkBlueColor,
                        borderRadius: 10.0.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
