import 'package:charja_charity/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/cachedImage.dart';
import '../../add_section/ui/edit_Product_Service_Event.dart';

class ServiceItem extends StatelessWidget {
  List<Activities>? activites;
  final int type;
  final String image;
  final String name;
  var price;
  final String description;
  final dynamic service;
  PaginationCubit? cubit;
  final bool canUpdate;

  ServiceItem(
      {Key? key,
      this.service,
      required this.name,
      required this.image,
      required this.description,
      this.price,
      this.activites,
      required this.type,
      this.cubit,
      this.canUpdate = true})
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
              decoration: BoxDecoration(color: AppColors.kGreyLight),
              child: CachedImage(
                imageUrl: image,
                fit: BoxFit.fill,
                // errorBuilder: (context, error, stackTrace) {
                //   return Center(
                //     child: Icon(
                //       Icons.hourglass_empty,
                //       color: AppColors.kWhiteColor,
                //     ),
                //   );
                // },
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
                    canUpdate
                        ? Text(name, style: AppTheme.subtitle2.copyWith(fontSize: 14))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(name, style: AppTheme.subtitle2.copyWith(fontSize: 14)),
                              if (price != null)
                                Text(
                                  '${price} EUR',
                                  style: AppTheme.subtitle2.copyWith(fontSize: 14),
                                ),
                            ],
                          ),
                    // Text(name, style: AppTheme.subtitle2.copyWith(fontSize: 14)),

                    if (price != null && canUpdate)
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
          if (canUpdate)
            IconButton(
              icon: SvgPicture.asset(
                editIcon,
                height: 50,
                width: 50,
              ),
              onPressed: () {
                String appbartitle;
                if (type == 1) {
                  appbartitle = "Service";
                } else if (type == 2) {
                  appbartitle = "Products";
                } else if (type == 3) {
                  appbartitle = "Events";
                } else {
                  appbartitle = "";
                }
                Navigation.push(EditProductServicEvent(
                  valueChanged: (val) {
                    cubit!.getList();
                  },
                  appBar_title: appbartitle,
                  page_type: type,
                  activites: activites,
                  service: service!,
                ));
              },
            )
        ],
      ),
    );
  }
}
