import 'package:charja_charity/core/ui/widgets/share_widget.dart';
import 'package:charja_charity/core/ui/widgets/unicorn_outline_button.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/profile/ui/service_provider_profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/search/data/model/search_model.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_styles.dart';
import 'Coustom_Button.dart';
import 'cachedImage.dart';
import 'favorite_widget.dart';

class ViewProfileCard extends StatefulWidget {
  const ViewProfileCard(
      {Key? key, required this.type, this.withIcon = false, required this.isInfluencer, this.searchOfServiceProvider})
      : super(key: key);
  final bool withIcon;
  final String type;
  final bool isInfluencer;
  final SearchOfServiceProvider? searchOfServiceProvider;

  @override
  State<ViewProfileCard> createState() => _ViewProfileCardState();
}

class _ViewProfileCardState extends State<ViewProfileCard> with SingleTickerProviderStateMixin {
  late double height;
  late bool isExpanded;
  bool isFav = false;

  bool get isInFluencer => widget.isInfluencer;

  @override
  void initState() {
    height = widget.withIcon ? 250.h : 229.h;
    isExpanded = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (_) {},
      child: AnimatedSize(
        // vsync: this,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        // width: 338.w,
        //height: height,
        clipBehavior: Clip.none,
        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        // decoration: BoxDecoration(
        //     color: AppColors.kWhiteColor,
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: AppColors.kGreyLight)),
        // //padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Container(
          width: 0.9.sw,
          //height: height,
          //clipBehavior: Clip.none,
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.kGreyLight)),
          child: SingleChildScrollView(
            physics: widget.withIcon ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.withIcon
                    ? InkWell(
                        onTap: () async {
                          // if (!isExpanded) {
                          //   height = widget.withIcon ? 650.h : 540.h;
                          //   setState(() {});
                          //   //  await Future.delayed(const Duration(milliseconds: 200));
                          isExpanded = !isExpanded;
                          setState(() {});
                          // } else {
                          //   height = widget.withIcon ? 260.h : 225.h;
                          //   setState(() {});
                          //   await Future.delayed(const Duration(milliseconds: 1500));
                          //   isExpanded = !isExpanded;
                          //   setState(() {});
                          // }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: isExpanded ? 20.h : 0),
                          child: Container(
                            width: 0.9.sw,
                            decoration: const BoxDecoration(
                              color: AppColors.kWhiteProfileCardIconArea,
                              borderRadius:
                                  BorderRadius.only(topRight: Radius.circular(9), topLeft: Radius.circular(9)),
                            ),
                            child: Center(
                              child: Icon(isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      !isExpanded
                          ? ProfilCardItem(searchItem: widget.searchOfServiceProvider!)
                          //add expanded item for profile card
                          : ProfilCardExpandedItem(type: widget.type),
                      Padding(
                        padding: EdgeInsets.only(top: isExpanded ? 15.h : 10.h, bottom: isExpanded ? 10.h : 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: CoustomButton(
                                  buttonName: "View profile".tr(),
                                  backgoundColor: AppColors.kWhiteColor,
                                  borderSideColor: AppColors.kPDarkBlueColor,
                                  borderRadius: 10.0.r,
                                  function: () {
                                    print(widget.searchOfServiceProvider!.id);
                                    Navigation.push(ServiceProviderProfileScreen(
                                      isMyProfile: false,
                                      data: widget.searchOfServiceProvider!,
                                    ))?.then((val) {
                                      setState(() {});
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProfilCardExpandedItem({required String type}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child:
                  ShareWidget(id: widget.searchOfServiceProvider!.id!, role: widget.searchOfServiceProvider!.userType!),
            ),
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: UnicornOutlineButton(
                      isInfluencer: isInFluencer,
                      minHeight: 170,
                      minWidth: 170,
                      strokeWidth: 3,
                      radius: 300,
                      photoUrl: widget.searchOfServiceProvider!.photoUrl != null
                          ? widget.searchOfServiceProvider!.photoUrl!
                          : "",
                      onPressed: () {},
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 13.h, left: 17.w),
                      child: Container(
                        height: 20.w,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: (widget.searchOfServiceProvider!.isAvailable != null &&
                                  widget.searchOfServiceProvider!.isAvailable!)
                              ? AppColors.kSFlashyGreenColor
                              : AppColors.kGreyDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 0,
                    right: 30,
                    top: 150,
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

                  // Container(width: 100.w, height: 100.h, color: Colors.red, child: SvgPicture.asset(onlineIcon)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FavoriteWidget(
                isFavorite: (widget.searchOfServiceProvider?.isFav)!,
                id: widget.searchOfServiceProvider!.id!,
                onChange: (value) {
                  if (value) {
                    widget.searchOfServiceProvider?.isFav = !(widget.searchOfServiceProvider?.isFav)!;
                    setState(() {});
                  }
                },
                type: 'ServiceProvider',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${widget.searchOfServiceProvider?.generalInformation!.fullName}",
              style: AppTheme.subtitle2
                  .copyWith(color: AppColors.kPDarkBlueColor, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 8.w,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.asset(
                isInFluencer ? 'assets/icons/chare.png' : checkpng,
                scale: 4,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: (widget.searchOfServiceProvider!.isAvailable != null &&
                        widget.searchOfServiceProvider!.isAvailable!)
                    ? AppColors.kSDarkGreenColor
                    : AppColors.kGreyDark,
              ),
              height: 8.h,
              width: 8.h,
            ),
            SizedBox(
              width: 4.h,
            ),
            Text(
              "Available".tr(),
              style: AppTheme.subtitle2.copyWith(
                fontSize: 12,
                color: (widget.searchOfServiceProvider!.isAvailable != null &&
                        widget.searchOfServiceProvider!.isAvailable!)
                    ? AppColors.kSDarkGreenColor
                    : AppColors.kGreyDark,
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.searchOfServiceProvider!.generalInformation?.distance != null ? 5.h : 0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            "${widget.searchOfServiceProvider?.companyModel?.name ?? ""}, ${widget.searchOfServiceProvider?.generalInformation?.distance?.floor() ?? ""} kms",

            // "Hairdresser, 2 kms",
            style: AppTheme.bodyText1.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        (widget.searchOfServiceProvider!.isEventProgress != null && widget.searchOfServiceProvider!.isEventProgress!)
            ? Text(
                "Event in progress".tr(),
                style: AppTheme.subtitle1
                    .copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14, fontWeight: FontWeight.w500),
              )
            : SizedBox(),
        SizedBox(
          height: 12.h,
        ),
        widget.searchOfServiceProvider?.companyModel?.description != null
            ? Text(
                "${widget.searchOfServiceProvider?.companyModel?.description}",
                style: AppTheme.subtitle1.copyWith(
                  //color: AppColors.kPDarkBlueColor,
                  fontSize: 10,
                ),
              )
            : SizedBox(height: 27.h),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(height: 118.h, child: getListViewType(type: widget.type)),
      ],
    );
  }

  Widget getListViewType({required String type}) {
    switch (type) {
      case 'Product':
        return ListView.separated(
          itemCount: (widget.searchOfServiceProvider!.products?.length)!,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              //height: 110.h,
              width: 70.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 67.h,
                    width: 70.w,
                    child: (widget.searchOfServiceProvider?.products?[index].images?.isNotEmpty)!
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                height: 67.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.kGreyLight,
                                ),
                                child: CachedImage(
                                  imageUrl: ((widget.searchOfServiceProvider?.products?[index].images?.first)!),
                                  fit: BoxFit.cover,
                                )),
                          )
                        : Image.asset(aboutUS1, fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "${widget.searchOfServiceProvider?.products?[index].name}",
                    style: AppTheme.subtitle2.copyWith(
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    "${widget.searchOfServiceProvider?.products?[index].description}",
                    style: AppTheme.subtitle2.copyWith(
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                  Text(
                    "${widget.searchOfServiceProvider?.products?[index].price}" " EUR",
                    style: AppTheme.subtitle1.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 8.w,
            );
          },
        );
      case 'Service':
        return ListView.separated(
          itemCount: (widget.searchOfServiceProvider?.services?.length)!,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              //height: 110.h,
              width: 70.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      height: 67.h,
                      width: 70.w,
                      child: (widget.searchOfServiceProvider?.services?[index].images?.isNotEmpty)!
                          ? Container(
                              height: 67.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.kGreyLight,
                              ),
                              child: CachedImage(
                                imageUrl: ((widget.searchOfServiceProvider?.services?[index].images?.first)!),
                                fit: BoxFit.cover,
                              ))
                          : Image.asset(aboutUS1, fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        "${widget.searchOfServiceProvider?.services?[index].name}",
                        style: AppTheme.subtitle2.copyWith(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Text(
                    "${widget.searchOfServiceProvider?.services?[index].description}",
                    style: AppTheme.subtitle2.copyWith(
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                  Text(
                    "${widget.searchOfServiceProvider?.services?[index].price}" " EUR",
                    style: AppTheme.subtitle1.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 8.w,
            );
          },
        );
      case 'Event':
        return ListView.separated(
          itemCount: (widget.searchOfServiceProvider?.events?.length)!,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              //height: 110.h,
              width: 70.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      height: 67.h,
                      width: 70.w,
                      child: (widget.searchOfServiceProvider?.events?[index].images?.isNotEmpty)!
                          ? Container(
                              height: 67.h,
                              width: 70.w,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: AppColors.kGreyLight),
                              child: CachedImage(
                                imageUrl: ((widget.searchOfServiceProvider?.events?[index].images?.first)!),
                                fit: BoxFit.cover,
                              ))
                          : Image.asset(aboutUS1, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        "${widget.searchOfServiceProvider?.events?[index].name}",
                        style: AppTheme.subtitle2.copyWith(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Text(
                    "${widget.searchOfServiceProvider?.events?[index].description}",
                    style: AppTheme.subtitle2.copyWith(
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                  // Text(
                  //   "${widget.searchOfServiceProvider?.events?[index].price}" " EUR",
                  //   style: AppTheme.subtitle1.copyWith(
                  //     fontSize: 10,
                  //   ),
                  // ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 8.w,
            );
          },
        );
    }
    return SizedBox();
  }

  Widget ProfilCardItem({required SearchOfServiceProvider searchItem}) {
    return Padding(
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
                    isInfluencer: false,
                    minHeight: 97,
                    minWidth: 97,
                    strokeWidth: 3,
                    radius: 200,
                    photoUrl: searchItem.photoUrl,
                    onPressed: () {},
                  ),
                  // if ((widget.searchOfServiceProvider?.isAvailable != null &&
                  //     widget.searchOfServiceProvider!.isAvailable!))
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 13.h, left: 2.w),
                      child: Container(
                        height: 16.w,
                        width: 16.w,
                        decoration: BoxDecoration(
                          color: (widget.searchOfServiceProvider?.isAvailable != null &&
                                  widget.searchOfServiceProvider!.isAvailable!)
                              ? AppColors.kSFlashyGreenColor
                              : AppColors.kGreyDark,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
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
                      searchItem.generalInformation!.fullName!,
                      style: AppTheme.subtitle2.copyWith(fontSize: 16, color: AppColors.kPDarkBlueColor),
                    ),
                    (searchItem.isAvailable!)
                        ? SizedBox(
                            height: 7.h,
                          )
                        : SizedBox(
                            height: 1.h,
                          ),
                    Row(
                      children: [
                        Container(
                          height: 6.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (searchItem.isAvailable != null && searchItem.isAvailable!)
                                  ? AppColors.kSDarkGreenColor
                                  : AppColors.kGreyDark),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          "Available",
                          style: AppTheme.subtitle2.copyWith(
                              fontSize: 12,
                              color: (searchItem.isAvailable != null && searchItem.isAvailable!)
                                  ? AppColors.kSDarkGreenColor
                                  : AppColors.kGreyDark),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        "${widget.searchOfServiceProvider?.companyModel?.name ?? ""}, ${searchItem.generalInformation?.distance?.floor() ?? ""} kms",

                        // "Hairdresser, 2 kms",
                        style: AppTheme.bodyText1.copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    (widget.searchOfServiceProvider!.isEventProgress != null &&
                            widget.searchOfServiceProvider!.isEventProgress!)
                        ? Text(
                            "Event in progress",
                            style: AppTheme.subtitle2.copyWith(fontSize: 12, color: AppColors.kPDarkBlueColor),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 7.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: widget.searchOfServiceProvider?.companyModel?.description != null
                          ? Text(
                              "${widget.searchOfServiceProvider?.companyModel?.description}",
                              style: AppTheme.bodyText1.copyWith(
                                fontSize: 10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox(),
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
                    isFavorite: (widget.searchOfServiceProvider?.isFav)!,
                    id: widget.searchOfServiceProvider!.id!,
                    onChange: (value) {
                      if (value) {
                        widget.searchOfServiceProvider?.isFav = !(widget.searchOfServiceProvider?.isFav)!;
                        setState(() {});
                      }
                    },
                    type: 'ServiceProvider',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      checkpng,
                      scale: 4,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
