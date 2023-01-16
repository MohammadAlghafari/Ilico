import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_icons.dart';

class AddImageOrVideosWidget extends StatefulWidget {
  const AddImageOrVideosWidget({Key? key, required this.function}) : super(key: key);
  final VoidCallback function;

  @override
  State<AddImageOrVideosWidget> createState() => _AddImageOrVideosWidgetState();
}

class _AddImageOrVideosWidgetState extends State<AddImageOrVideosWidget> {
  @override
  Widget build(BuildContext context) {
    return //imageSelected == null
        InkWell(
      onTap: widget.function,
      child: Container(
        height: 100.w,
        width: 100.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.kGreyWhite),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SvgPicture.asset(plusIcon),
        ),
      ),
    );
  }
}
