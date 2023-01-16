import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/ui/root_screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

import '../../constants/end_point.dart';
import '../../utils/Navigation/Navigation.dart';
import '../../utils/cashe_helper.dart';
import '../widgets/Coustom_Button.dart';
import '../widgets/coustomOnBoarding.dart' as onBoard;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardigScreen extends StatelessWidget {
  OnboardigScreen();

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPDarkBlueColor,
      body: SafeArea(
          child: Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset("assets/icons/onboardingBackground.png")),
        onBoard.OnBoard(
          descriptionStyles:
              AppTheme.bodyText1.copyWith(color: AppColors.kWhiteColor),
          titleStyles:
              AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
          skipButton: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Skip",
                    //textAlign: TextAlign.center,
                    style:
                        AppTheme.button.copyWith(color: AppColors.kWhiteColor)),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: AppColors.kWhiteColor,
                )
              ],
            ),
            onPressed: () {
              CashHelper.saveData(key: firstTimeOpenApp, value: true);
              Navigation.pushReplacement(const RootScreen());
            },
          ),
          imageHeight: 230,
          imageWidth: 230,
          onBoardData: onBoardData,

          pageController: _pageController,
          nextButton: OnBoardConsumer(builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return CoustomButton(
              buttonName: state.isLastPage ? "Done" : "Next",
              height: 50.h,
              width: 336.w,
              backgoundColor: AppColors.kWhiteColor,
              borderSideColor: AppColors.kPDarkBlueColor,
              borderRadius: 10,
              function: () => _onNextTap(state),
            );
          }),
          pageIndicatorStyle: PageIndicatorStyle(
            width: 50,
            inactiveColor: AppColors.kWhiteColor.withOpacity(0.5),
            activeColor: AppColors.kWhiteColor,
            inactiveSize: const Size(8, 8),
            activeSize: const Size(8, 8),
          ),

          onSkip: () {
            //
            //   print("skip");
          },
          // Either Provide onDone Callback or nextButton Widget to handle done state
          onDone: () {
            //
            //    print("done");
          },
        ),
      ])),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      CashHelper.saveData(key: firstTimeOpenApp, value: true);
      Navigation.pushReplacement(const RootScreen());
      // print("done");
    }
  }

  final List<OnBoardModel> onBoardData = [
    const OnBoardModel(
      title: "Start your journey with us",
      description:
          "Vero molestiae eveniet rerum. Occaecati eligendi sed dolores non expedita culpa.",
      imgUrl: "assets/icons/onboarding1.png",
    ),
    const OnBoardModel(
      title: "Start your journey with us",
      description:
          "Vero molestiae eveniet rerum. Occaecati eligendi sed dolores non expedita culpa.",
      imgUrl: "assets/icons/onboarding1.png",
    ),
    const OnBoardModel(
      title: "Start your journey with us",
      description:
          "Vero molestiae eveniet rerum. Occaecati eligendi sed dolores non expedita culpa.",
      imgUrl: "assets/icons/onboarding1.png",
    ),
  ];
}
