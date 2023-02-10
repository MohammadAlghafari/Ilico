import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/ui/widgets/sheet/coustom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/image_and_name_widget.dart';
import '../widgets/add_review_content.dart';
import '../widgets/my_activity_item.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Job details',
        action: [],
        withBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service provider',
                        style: AppTheme.bodyText2.copyWith(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text(
                            'ID:',
                            style: AppTheme.bodyText2.copyWith(fontSize: 14),
                          ),
                          Text(
                            ' 0000',
                            style: AppTheme.bodyText2.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ImageAndNameWidget(
                        name: 'Saeed abo reem',
                      ),
                      TagWidget(
                        text: 'Done',
                        color: AppColors.kLightGreen,
                        textColor: AppColors.kSDarkGreenColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'Service description',
                    style: AppTheme.bodyText2.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'Service name long text Service name long text Service name long text Service name long text',
                    style: AppTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service description',
                        style: AppTheme.bodyText2.copyWith(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text(
                            'Rating:',
                            style: AppTheme.bodyText2.copyWith(fontSize: 14),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            '4.0',
                            style: AppTheme.bodyText2.copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    'Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum.',
                    style: AppTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Divider(
                    color: AppColors.kGreyWhite,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Last update 00/00/0000',
                        style: AppTheme.bodyText1.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CoustomButton(
                    buttonName: "Add Review",
                    backgoundColor: AppColors.kWhiteColor,
                    borderSideColor: AppColors.kPDarkBlueColor,
                    borderRadius: 10.0.r,
                    function: () {
                      CustomSheet.show(
                        context: context,
                        title: 'Write a review',
                        child: const AddReviewContent(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
