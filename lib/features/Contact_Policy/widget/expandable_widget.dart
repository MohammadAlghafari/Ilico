import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';

class ExpandableWidget extends StatefulWidget {
  final String header;
  final String body;
  const ExpandableWidget({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  final ExpandableController controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Builder(builder: (context) {
              var exp = ExpandableController.of(context);
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
                trailing: InkWell(
                    onTap: () {
                      exp?.toggle();
                    },
                    child: (exp?.expanded)! ? SvgPicture.asset(mins_square) : SvgPicture.asset(plus_square)),
                title: Text(
                  widget.header,
                  style: AppTheme.subtitle2.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14),
                ),
              );
            }), //header is close
          ]),
          Expandable(
            collapsed: buildCollapsed(),
            expanded: buildExpanded(), //body is open
          ),
        ],
      ),
    );
  }

  buildCollapsed() {
    return Container(
      height: 5,
    );
  }

  buildExpanded() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        widget.body,
        style: AppTheme.subtitle1.copyWith(color: AppColors.kPDarkBlueColor),
      ),
    );
  }
}
