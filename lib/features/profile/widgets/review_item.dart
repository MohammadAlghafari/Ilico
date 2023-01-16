import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/view_profile_card.dart';

class ReviewItem extends StatefulWidget {
  const ReviewItem({Key? key}) : super(key: key);

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ImageAndNameWidget(
                name: 'Ethel Bechtelar',
                colors: [AppColors.kPOrangeColor, AppColors.kSDarkPinkColor],
              ),
              RatingBar(
                itemSize: 20,
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset('assets/icons/star2.svg'),
                  half: SvgPicture.asset('assets/icons/star1.svg'),
                  empty: SvgPicture.asset('assets/icons/star.svg'),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
              'Ipsum enim eos. Aliquam odit quaerat laudantium '
              'quia culpa autem adipisci. Voluptas est iusto doloribus illo. '
              'Laudantium non sapiente nihil veniam ipsam doloremque. Ea rerum sed  perferendis dolores velit fugiat. ',
              style: AppTheme.bodyText1.copyWith(fontSize: 10))
        ],
      ),
    );
  }
}
