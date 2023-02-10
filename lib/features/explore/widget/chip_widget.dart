import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ChipWidget extends StatefulWidget {
  final String label;
  bool isSelected;
  final ValueChanged<bool> callBack;

  ChipWidget({Key? key, required this.label, required this.callBack, required this.isSelected}) : super(key: key);

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: FilterChip(
        showCheckmark: false,
        selectedColor: Colors.white,
        selected: widget.isSelected,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        backgroundColor: Colors.white,
        side: BorderSide(color: widget.isSelected ? AppColors.kPDarkBlueColor : Colors.white),
        label: Text(widget.label,
            style: AppTheme.bodyText2
                .copyWith(fontSize: 15, color: widget.isSelected ? AppColors.kPDarkBlueColor : Colors.black)),
        onSelected: (bool value) {
          widget.callBack(value);
        },
      ),
    );
  }
}
