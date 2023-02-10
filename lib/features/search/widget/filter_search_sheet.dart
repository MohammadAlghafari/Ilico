import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';

class FilterSheet extends StatefulWidget {
  final bool initFav;
  final double initTo;
  final bool initPer;
  ValueChanged<bool> isFavirate;
  ValueChanged<bool> isPremiumOnly;
  bool? value1;
  bool? value2;
  ValueChanged<double> lowerValue;
  ValueChanged<double> upperValue;
  FilterSheet(
      {Key? key,
      required this.lowerValue,
      required this.upperValue,
      required this.initFav,
      required this.initTo,
      required this.initPer,
      this.value2,
      this.value1,
      required this.isPremiumOnly,
      required this.isFavirate})
      : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  double _lowerValue = 0.0;
  double _upperValue = 5.0;
  @override
  void initState() {
    _upperValue = widget.initTo;
    widget.value2 = widget.initFav;
    widget.value1 = widget.initPer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distance (kms)'.tr(),
            style: AppTheme.subtitle2.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 30.h,
          ),
          RangeSliderFlutter(
            rightHandler: RangeSliderFlutterHandler(
              foregroundDecoration: BoxDecoration(
                color: AppColors.kPOrangeColor,
                borderRadius: BorderRadius.circular(100),
              ),
              decoration: BoxDecoration(
                color: AppColors.kPOrangeColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            handler: RangeSliderFlutterHandler(
              disabled: true,
              foregroundDecoration: BoxDecoration(
                color: AppColors.kPOrangeColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            touchSize: 5,
            textPositionBottom: -150,
            hatchMark: RangeSliderFlutterHatchMark(
              linesDistanceFromTrackBar: 2,
            ),
            values: [_lowerValue, _upperValue],
            rangeSlider: true,
            tooltip: RangeSliderFlutterTooltip(
              boxStyle: const RangeSliderFlutterTooltipBox(),
              alwaysShowTooltip: true,
            ),
            max: 50,
            minimumDistance: 5,
            textPositionTop: -100,
            handlerHeight: 20,
            trackBar: RangeSliderFlutterTrackBar(
              activeDisabledTrackBarColor: AppColors.kPOrangeColor,
              inactiveDisabledTrackBarColor: AppColors.kPOrangeColor,
              activeTrackBarHeight: 8,
              inactiveTrackBarHeight: 8,
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPOrangeColor,
              ),
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kGreyWhite,
              ),
            ),
            min: 0,
            textColor: Colors.black,
            fontSize: 15,
            textBackgroundColor: Colors.white,
            visibleTouchArea: false,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              _lowerValue = lowerValue;
              _upperValue = upperValue;
              _lowerValue = _lowerValue.floorToDouble();
              _upperValue = _upperValue.floorToDouble();
              widget.lowerValue(lowerValue);
              widget.upperValue(upperValue);

              setState(() {});
            },
          ),
          SizedBox(
            height: 27.h,
          ),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Premium only'.tr(),
                style: AppTheme.subtitle2.copyWith(fontSize: 16),
              ),
              side: const BorderSide(
                width: 2,
                color: AppColors.kPDarkBlueColor,
              ),
              activeColor: AppColors.kPDarkBlueColor,
              value: widget.value1,
              onChanged: (val) {
                setState(() {
                  widget.value1 = val!;
                  widget.isPremiumOnly(val);
                  print(",,,,,,,,,,,,,,,,,,${widget.value1}");
                });
              }),
          CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Favourites only'.tr(),
                style: AppTheme.subtitle2.copyWith(fontSize: 16),
              ),
              side: const BorderSide(
                width: 2,
                color: AppColors.kPDarkBlueColor,
              ),
              activeColor: AppColors.kPDarkBlueColor,
              value: widget.value2,
              onChanged: (val2) {
                setState(() {
                  widget.value2 = val2!;
                  widget.isFavirate(val2);
                });
              }),
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              Expanded(
                child: CoustomButton(
                  function: () {
                    Navigator.pop(context);
                  },
                  buttonName: "Apply".tr(),
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
