import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/ui/widgets/custom_text_field.dart';
import 'package:charja_charity/core/utils/extension/text_field_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/view_profile_card.dart';
import '../../../core/utils/form_utils/form_state_mixin.dart';

class AddReviewContent extends StatefulWidget {
  const AddReviewContent({Key? key}) : super(key: key);

  @override
  State<AddReviewContent> createState() => _AddReviewContentState();
}

class _AddReviewContentState extends State<AddReviewContent> with FormStateMinxin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ImageAndNameWidget(
          name: 'Saeed abo reem',
        ),
        CustomTextField(
          textEditingController: form.controllers[0],
          focusNode: form.nodes[0],
          labelText: 'Type of service',
          hintText: 'Service name',
        ),
        Padding(
          padding: EdgeInsets.only(top: 18.h, bottom: 4.h),
          child: Text(
            'Rate the service',
            style: AppTheme.bodyText2,
          ),
        ),
        RatingBar.builder(
          initialRating: 3,
          glow: false,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: AppColors.kGreyLight,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          textEditingController: form.controllers[1],
          focusNode: form.nodes[1],
          labelText: 'Your review',
          hintText: 'Type your review',
          maxLine: 10,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: Row(
            children: [
              Expanded(
                child: CoustomButton(
                  buttonName: "Submit",
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0.r,
                  function: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int numberOfFields() => 2;
}
