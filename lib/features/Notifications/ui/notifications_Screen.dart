import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../widget/notificationListItem.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: const AppBarWidget(
        title: 'Notifications',
        withBackButton: true,
        action: [],
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return NotificationListItem(
              type: 1,
              image: aboutUSCircleImage,
              index: index,
              supTitle:
                  'Quod dolor rerum totam. In delectus ipsam quidem. Dolor omnis quia. ',
              title: "Lola Connelly",
              time: ' 7 hours ago',
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: const Divider(
                height: 1,
                color: AppColors.kWhiteColor,
              ),
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
