import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../widgets/my_activity_item.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'My Activity',
        action: [
          Padding(
            padding: EdgeInsets.only(right: 30.w),
            child: SvgPicture.asset(notificationIcon),
          )
        ],
      ),
      body: ListView.builder(itemCount: 5, itemBuilder: (context, index) => MyActivityItem()),
    );
  }
}
