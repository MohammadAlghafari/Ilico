import 'package:charja_charity/core/ui/widgets/unicorn_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_styles.dart';

class ImageAndNameWidget extends StatefulWidget {
  final String name;
  final String? job;
  final List<Color>? colors;
  final double? minWidth;
  final double? maxHeight;
  final double? scale;

  const ImageAndNameWidget({super.key, required this.name, this.colors, this.minWidth,this.job, this.maxHeight, this.scale});

  @override
  State<ImageAndNameWidget> createState() => _ImageAndNameWidgetState();
}

class _ImageAndNameWidgetState extends State<ImageAndNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        UnicornOutlineButton(
          minWidth: widget.minWidth ?? 40,
          minHeight: widget.maxHeight ?? 40,
          strokeWidth: 2,
          radius: 100,
          photoUrl: null,
          onPressed: () {},
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: AppTheme.bodyText1.copyWith(fontSize: 16,fontWeight: FontWeight.w500),
            ),
            if(widget.job!= null)
              Text(
                widget.job!,
                style: AppTheme.bodyText1.copyWith(fontSize: 14,fontWeight: FontWeight.w300),
              ),
          ],
        )
      ],
    );
  }
}
