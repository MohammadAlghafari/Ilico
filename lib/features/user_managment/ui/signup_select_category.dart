import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/features/user_managment/ui/sing_up_Social_Networks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/root_screen/root_screen.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../profile/data/model/profile_model.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/assign_category.dart';
import '../data/usecase/get_category_usecase.dart';
import '../widgets/sign_header_widget.dart';

class SignupSelectCategory extends StatefulWidget {
  const SignupSelectCategory({Key? key}) : super(key: key);

  @override
  State<SignupSelectCategory> createState() => _SignupSelectCategoryState();
}

class _SignupSelectCategoryState extends State<SignupSelectCategory> {
  String? role = CashHelper.getRole();
  List<Activities>? categoryModelList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignHeader(
                height: (role == 'Customer') ? 124.h : 190.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 31),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Text(
                            'Create your account'.tr(),
                            style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                          ),
                        ],
                      ),
                    ),
                    (role == 'Customer') ? const SizedBox() : SizedBox(height: 46.h),
                    (role == 'Customer')
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 200.w),
                              Image.asset(circleIcon),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                    (role == 'Customer') ? SizedBox() : SizedBox(height: 14.h),
                    (role == 'Customer')
                        ? SizedBox()
                        : Text(
                            'Influencer profile'.tr(),
                            style: AppTheme.subtitle2.copyWith(color: Colors.white, fontSize: 14),
                          )
                  ],
                )),
            SizedBox(
              height: 29.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              child: Text(
                'Select 3 categories you are interested in'.tr(),
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
                String? role = CashHelper.getRole();
                if (role == 'Customer') {
                  Navigation.push(RootScreen());
                } else {
                  Navigation.push(SingUpSocialNetworks());
                }
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
                  if (count >= 3) {
                    return AssignCategoryUseCase(AuthRepository())
                        .call(params: AssignCategoryParams(categoriesIds: selectedIds));
                  } else {
                    Dialogs.showSnackBar(
                        message: 'Please select at least 3 categories to proceed'.tr(),
                        typeSnackBar: AnimatedSnackBarType.warning);
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

class MyRadio extends StatefulWidget {
  final Activities categoryModel;

  bool value;
  Function(bool) onChange;
  MyRadio({
    Key? key,
    required this.categoryModel,
    required this.value,
    required this.onChange,
  }) : super(key: key);

  @override
  State<MyRadio> createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.categoryModel.isSelected = _value;
          widget.onChange(_value);
        });
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.67.w),
            child: Container(
              width: 23.w,
              height: 23.h,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: _value ? AppColors.kPDarkBlueColor : AppColors.kGrayBorder),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: _value ? AppColors.kPDarkBlueColor : Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            (widget.categoryModel.name!),
            style: AppTheme.subtitle2
                .copyWith(color: _value ? AppColors.kPDarkBlueColor : AppColors.kGrayBorder, fontSize: 14),
          ),
          SizedBox(
            width: 14.w,
          )
        ],
      ),
    );
  }
}
