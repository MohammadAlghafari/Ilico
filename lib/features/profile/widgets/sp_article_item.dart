import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/cachedImage.dart';

class SPArticleItem extends StatefulWidget {
  final String image;
  final String name;
  String? date;
  final String description;
  final bool isEvent;

  SPArticleItem({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    this.date,
    this.isEvent = false,
  }) : super(key: key);

  @override
  _SPArticleItemState createState() => _SPArticleItemState();
}

class _SPArticleItemState extends State<SPArticleItem> {
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
                imageUrl: widget.image,
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
                    Text(widget.name, style: AppTheme.subtitle2.copyWith(fontSize: 14)),

                    // Text(name, style: AppTheme.subtitle2.copyWith(fontSize: 14)),
                    !widget.isEvent
                        ? Text(
                            getDateTimeForArticle(widget.date!),
                            style: AppTheme.subtitle2
                                .copyWith(fontSize: 10, fontWeight: FontWeight.w300, color: AppColors.kGrayTextField),
                          )
                        : Text(
                            getDateTimeForEvent(widget.date!),
                            style: AppTheme.subtitle2.copyWith(color: AppColors.kPDarkBlueColor),
                          ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(widget.description, style: AppTheme.bodyText1.copyWith(fontSize: 10)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  String getDateTimeForArticle(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    var df = DateFormat("dd.MMMM.yyyy").format(date.toUtc());
    return df.toString();
  }

  String getDateTimeForEvent(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    var df = DateFormat("E,MMM dd. HH:mm a").format(date.toUtc());
    return df.toString();
  }
}
