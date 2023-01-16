import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class BuildDropdownField extends StatefulWidget {
  const BuildDropdownField({
    Key? key,
    this.height,
    this.titleText,
    this.horizontal,
    this.labelText,
    this.borderColor,
    this.labelColor,
    this.hintText,
    this.value,
    this.validator,
    this.items,
    required this.callBack,
  }) : super(key: key);
  final String? labelText;
  final String? titleText;
  final String? hintText;
  final FormFieldValidator? validator;
  final ValueChanged<dynamic> callBack;
  final List<DropdownMenuItem>? items;
  final dynamic value;

  final Color? borderColor;
  final Color? labelColor;
  final double? horizontal;
  final double? height;

  @override
  State<BuildDropdownField> createState() => _BuildDropdownFieldState();
}

class _BuildDropdownFieldState extends State<BuildDropdownField> {
  String? value;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.titleText != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    widget.titleText!,
                    style: AppTheme.bodyText2,
                  ),
                )
              : const SizedBox.shrink(),
          DropdownButtonHideUnderline(

              //  color: Colors.red,
              child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            height: widget.height ?? 40,
            minWidth: 2,
            alignedDropdown: true,
            child: DropdownButtonFormField<dynamic>(
              // icon: '',
              itemHeight: 90.h,
              // validator: widget.validator,
              autovalidateMode: AutovalidateMode.always,
              isDense: true,
              value: widget.value,
              isExpanded: true,
              //alignment: Alignment.bottomRight,
              menuMaxHeight: 20.h,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                ),
                fillColor: AppColors.kLightColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: widget.horizontal ?? 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.kMediumLightColor, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: widget.labelText,
                hintText: widget.hintText,
                hintStyle: AppTheme.subtitle1.copyWith(color: AppColors.kGrayTextField, fontSize: 14),
                labelStyle: const TextStyle(color: AppColors.kGrayTextField, fontSize: 14),
              ),
              items: widget.items!,
              onChanged: (vale) {
                print(vale);
                setState(() {
                  widget.callBack(vale!);
                });
              },
            ),
          )),
        ],
      ),
    );
  }
}
