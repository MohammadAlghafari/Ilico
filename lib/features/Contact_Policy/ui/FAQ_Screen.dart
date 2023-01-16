import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/features/Contact_Policy/widget/expandable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/app_bar/app_bar_widget.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "FAQ",
        withBackButton: true,
        action: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: ListView.separated(
              itemCount: 25,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const ExpandableWidget(
                  body: "Nulla facilisi. Integer lacinia sollicitudin massa. Cras metus. Sed aliquet risus a tortor.",
                  header: "Nulla facilisi. Integer lacinia sollicitudin massa. Cras metus. Sed aliquet risus a tortor.",
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: AppColors.kGreyWhite,
                  thickness: 1,
                );
              },
            )),
      ),
    );
  }
}
