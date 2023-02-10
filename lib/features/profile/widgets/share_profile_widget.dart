import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/widgets/Coustom_Button.dart';
import '../../../core/ui/widgets/unicorn_outline_button.dart';
import 'category_item.dart';

class ShareProfileWidget extends StatefulWidget {
  const ShareProfileWidget({Key? key}) : super(key: key);

  @override
  State<ShareProfileWidget> createState() => _ShareProfileWidgetState();
}

class _ShareProfileWidgetState extends State<ShareProfileWidget> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UnicornOutlineButton(
          minWidth: 85,
          minHeight: 85,
          strokeWidth: 2,
          radius: 200,
          gradient: const LinearGradient(
            colors: [
              AppColors.kPDarkBlueColor,
              AppColors.kSFlashyGreenColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          photoUrl: null,
          onPressed: () {},
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          'Jane Doe',
          style: AppTheme.headline3.copyWith(color: AppColors.kPDarkBlueColor),
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CategoryWidget(categoryName: "test"),
            SizedBox(
              width: 12.w,
            ),
            const CategoryWidget(
              categoryName: "test",
            )
          ],
        ),
        SizedBox(
          height: 25.h,
        ),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.kPDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: QrImage(
            data: 'This QR code has an embedded image as well'.tr(),
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            embeddedImage: const AssetImage(shareLogo),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(50, 50),
            ),
          ),
        ),
        SizedBox(
          height: 48.h,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: CoustomButton(
                  widgetContent: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(downloadIcon),
                      Text(
                        'Save to gallery'.tr(),
                        textAlign: TextAlign.center,
                        style: AppTheme.button.copyWith(color: AppColors.kPDarkBlueColor),
                      )
                    ],
                  ),

                  // buttonName: "Sign in",
                  backgoundColor: AppColors.kWhiteColor,
                  borderSideColor: AppColors.kPDarkBlueColor,
                  borderRadius: 10.0.r,
                  function: () {}, buttonName: '',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w),
                child: CoustomButton(
                    widgetContent: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(shareIcon),
                        Text(
                          'Share the profile'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTheme.button.copyWith(color: AppColors.kPDarkBlueColor),
                        )
                      ],
                    ),

                    // buttonName: "Sign in",
                    backgoundColor: AppColors.kWhiteColor,
                    borderSideColor: AppColors.kPDarkBlueColor,
                    borderRadius: 10.0.r,
                    function: () {}),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Future<void> _captureAndSharePng() async {
  //   try {
  //     RenderRepaintBoundary boundary = (globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary);
  //     var image = await boundary.toImage();
  //     ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
  //     Uint8List? pngBytes = byteData?.buffer.asUint8List();
  //
  //     final tempDir = await getTemporaryDirectory();
  //     final file = await new File('${tempDir.path}/image.png').create();
  //     await file.writeAsBytes(pngBytes);
  //
  //     final channel = const MethodChannel('channel:me.alfian.share/share');
  //     channel.invokeMethod('shareFile', 'image.png');
  //
  //   } catch(e) {
  //     print(e.toString());
  //   }
  // }
}
