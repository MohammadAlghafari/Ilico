import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_styles.dart';
import '../../add_section/data/model/new_service.dart';

class ServiceItem extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final String description;
  final AddService? service;
  const ServiceItem(
      {Key? key, this.service, required this.name, required this.image, required this.description, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(color: AppColors.kPDarkBlueColor),
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTheme.subtitle2.copyWith(fontSize: 14)),
                    Text(
                      '${price} EUR',
                      style: AppTheme.subtitle2.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(description, style: AppTheme.bodyText1.copyWith(fontSize: 10)),
                  ],
                ),
              )),
          IconButton(
            icon: SvgPicture.asset(
              editIcon,
              height: 50,
              width: 50,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
