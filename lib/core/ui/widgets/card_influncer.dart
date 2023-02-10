import 'package:charja_charity/core/ui/widgets/unicorn_outline_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/profile/data/model/profile_model.dart';
import '../../../features/profile/widgets/social_media_count.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../utils/cashe_helper.dart';
import '../../utils/share.dart';
import 'favorite_widget.dart';

class ProfilCardInfluncer extends StatefulWidget {
  final ProfileInfluencerModel profileInfluencer;

  const ProfilCardInfluncer({Key? key, required this.profileInfluencer}) : super(key: key);

  @override
  State<ProfilCardInfluncer> createState() => _ProfilCardInfluncerState();
}

class _ProfilCardInfluncerState extends State<ProfilCardInfluncer> {
  Future<void> share(String id) async {
    await Share.share(id, CashHelper.getRole()!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 269.h,
      width: 338.w,
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.kGreyLight)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          UnicornOutlineButton(
                            isInfluencer: true,
                            minHeight: 97,
                            minWidth: 97,
                            strokeWidth: 3,
                            radius: 200,
                            photoUrl: widget.profileInfluencer.photoUrl,
                            onPressed: () {},
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            right: 0,
                            top: 75,
                            // alignment: const Alignment(0.6, -10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding: const EdgeInsets.only(right: 9, left: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColors.kGreyWhite),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset('assets/icons/star.png', scale: 4),
                                    Text(
                                      '4.0',
                                      style: AppTheme.subtitle2.copyWith(fontSize: 17, color: AppColors.kDimBlue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.profileInfluencer.generalInformation!.fullName!,
                              style: AppTheme.subtitle2.copyWith(fontSize: 16, color: AppColors.kPDarkBlueColor),
                            ),
                            // SizedBox(
                            //   height: 7.h,
                            // ),
                            // Text(
                            //   "${widget.profileInfluencer.generalInformation.?.floor()}" + " km",
                            //   // "Hairdresser, 2 kms",
                            //   style: AppTheme.bodyText1.copyWith(fontSize: 14),
                            // ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                "Aperiam dolor aliquam. Nesciunt suscipit aut minus repellat quis.",
                                style: AppTheme.bodyText1.copyWith(
                                  fontSize: 10,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          FavoriteWidget(
                            isFavorite: (widget.profileInfluencer.isFav)!,
                            id: widget.profileInfluencer.id!,
                            onChange: (value) {
                              if (value) {
                                widget.profileInfluencer.isFav = !(widget.profileInfluencer.isFav)!;
                                setState(() {});
                              }
                            },
                            type: 'Influencer',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            onTap: () {
                              share("${widget.profileInfluencer.id}");
                            },
                            child: Image.asset(
                              'assets/icons/chare.png',
                              scale: 4,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  const SocialMediaCount(
                    assets1: 'assets/icons/instagram.svg',
                    text1: '55k',
                    assets2: 'assets/icons/app.svg',
                    text2: '30k',
                    assets3: 'assets/icons/app2.svg',
                    text3: '20k',
                    assets4: 'assets/icons/youtube.svg',
                    text4: '20k',
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.h),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: CoustomButton(
            //             buttonName: "View profile",
            //             backgoundColor: AppColors.kWhiteColor,
            //             borderSideColor: AppColors.kPDarkBlueColor,
            //             borderRadius: 10.0.r,
            //             function: () {
            //               Navigation.push(ProfileScreen(
            //                 isFav: widget.profileInfluencer.isFav,
            //                 distanse: 2.0,
            //                 id: widget.profileInfluencer.id!,
            //               ));
            //             }),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
