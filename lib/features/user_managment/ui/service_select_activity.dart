import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../profile/data/model/profile_model.dart';
import '../data/repository/auth_repository.dart';
import '../data/usecase/get_category_usecase.dart';

class ServiceSelectActivity extends StatefulWidget {
  final Function(Activities)? categorySelect;
  final int index;
  final List<String?> selectedIds;

  ServiceSelectActivity(
      {Key? key,
      required this.categorySelect,
      // required this.onChange,
      required this.index,
      required this.selectedIds})
      : super(key: key);

  @override
  State<ServiceSelectActivity> createState() => _ServiceSelectActivityState();
}

class _ServiceSelectActivityState extends State<ServiceSelectActivity> {
  late List<Activities> categoryModelList;
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (selectedCategory != null) {
          widget.selectedIds[widget.index] = selectedCategory;
        }

        return Future.value();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(
          title: 'Select an activity',
          appBarHeight: 72.h,
          withBackButton: true,
          isCenterTitle: true,
          onBackPress: () {
            if (selectedCategory != null) {
              widget.selectedIds[widget.index] = selectedCategory;
            }
            // widget.onChange(widget.selectedIds);
          },
          action: [],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                              categorySelect: widget.categorySelect,
                              categoryList: list,
                              categoryModel: list[index],
                              value: list[index].isSelected,
                              onChange: (bool val) {
                                list[index].isSelected = val;
                                selectedCategory = list[index].id;
                                setState(() {});
                              },
                            ),
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
          ],
        ),
      ),
    );
  }
}

class MyRadio extends StatefulWidget {
  final Activities categoryModel;
  final List<Activities> categoryList;
  Function(Activities)? categorySelect;
  bool value;
  Function(bool) onChange;
  MyRadio({
    this.categorySelect,
    Key? key,
    required this.categoryModel,
    required this.categoryList,
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
        widget.categoryList.forEach((element) {
          if (element.isSelected) {
            element.isSelected = false;
          }
        });
        setState(() {
          _value = !_value;
          widget.categoryModel.isSelected = _value;
          widget.onChange(_value);
          widget.categorySelect!(Activities(id: widget.categoryModel.id, name: widget.categoryModel.name));
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
