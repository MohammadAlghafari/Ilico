import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectGategories extends StatefulWidget {
  const SelectGategories({Key? key, this.activites}) : super(key: key);
  final List<Activities>? activites;

  @override
  State<SelectGategories> createState() => _SelectGategoriesState();
}

class _SelectGategoriesState extends State<SelectGategories> {
  List<bool> isSelected = [];
  @override
  void initState() {
    widget.activites?.forEach((element) {
      isSelected.add(false);
    });
    print(widget.activites?.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.kWhiteColor,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.kPDarkBlueColor,
              ),
              onPressed: () {
                Navigation.pop();
              }),
          title: Text(
            'Select an activity',
            style: AppTheme.headline2.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 18),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 29.h,
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.activites?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
                    child: Container(
                      width: 200.w,
                      height: 44.h,
                      decoration: widget.activites![index].isSelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.kPDarkBlueColor))
                          : const BoxDecoration(),
                      child: MyRadio(
                          categoryModel: widget.activites![index],
                          value: widget.activites![index].isSelected,
                          onChange: (bool val) {
                            widget.activites!.forEach((element) {
                              element.isSelected = false;
                            });
                            widget.activites![index].isSelected = val;
                            setState(() {});
                          }),
                    ),
                  );
                }),
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
