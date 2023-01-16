import 'package:charja_charity/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/ui/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../data/usecase/supscription_usecase.dart';
import '../widgets/sign_header_widget.dart';

class SpSingUpSubscriptions extends StatefulWidget {
  const SpSingUpSubscriptions({Key? key}) : super(key: key);

  @override
  _SpSingUpSubscriptionsState createState() => _SpSingUpSubscriptionsState();
}

class _SpSingUpSubscriptionsState extends State<SpSingUpSubscriptions> {
  bool select = false;

  Supscription? supscription;
  @override
  void initState() {
    //test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 232.h,
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back),
        centerTitle: true,
        //  title:
        flexibleSpace: SignHeader(
          // height: 283.h,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 34.w,
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 34.w,
                    ),
                    Text(
                      "Create your account",
                      style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(iconFilled),
                        SizedBox(
                          width: 19.w,
                        ),
                        Image.asset(centerLine),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "Subscriptions",
                      style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //
                    //     Text(
                    //       "Social networks",
                    //       style: AppTheme.headline5.copyWith(
                    //           color: AppColors.kWhiteColor,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Select your plan",
                    style: AppTheme.headline5.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                ],
              ),
              Expanded(
                // height: 0.52.sh,
                child: PaginationList<Supscription>(
                  withPagination: true,
                  repositoryCallBack: (model) {
                    return SupscriptionUseCase(AuthRepository()).call(params: SupscriptionParams(request: model));
                  },
                  listBuilder: (list) {
                    return ListView.separated(
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return /*index == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Text(
                                    "Select your plan",
                                    style: AppTheme.headline5.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                ],
                              )
                            : */
                            InkWell(
                          onTap: () {
                            setState(() {
                              list.forEach((element) {
                                element.isSelected = false;
                              });

                              list[index].isSelected = !list[index].isSelected;
                              supscription = list[index];
                              print(list[index].isSelected);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                            // height: 100,
                            // width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.kWhiteColor,
                              border: Border.all(color: AppColors.kPDarkBlueColor, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    list[index].isSelected
                                        ? Image.asset(selectedSupscription)
                                        : Image.asset(un_selectedSupscription),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      list[index].title!,
                                      style: AppTheme.headline5
                                          .copyWith(color: AppColors.kPDarkBlueColor, fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${list[index].price} €‎/mo.",
                                          style: AppTheme.headline5
                                              .copyWith(color: AppColors.kPDarkBlueColor, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "${list[index].description}",
                                  style: AppTheme.headline5
                                      .copyWith(color: AppColors.kGrayTextField, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 15.h,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CoustomButton(
                        buttonName: "continue",
                        backgoundColor: AppColors.kWhiteColor,
                        borderSideColor: AppColors.kPDarkBlueColor,
                        borderRadius: 10.0.r,
                        function: () {
                          setState(() {
                            //TODO add supscription model to payment page
                            if (supscription != null) {
                              Navigation.push(PaymentScreen(
                                supscription: supscription!,
                              ));
                            }
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
