import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_styles.dart';
import '../../utils/cashe_helper.dart';
import 'Coustom_Button.dart';

class ViewProfileCard extends StatefulWidget {
  const ViewProfileCard({Key? key, this.withIcon = false}) : super(key: key);
  final bool? withIcon;

  @override
  State<ViewProfileCard> createState() => _ViewProfileCardState();
}

class _ViewProfileCardState extends State<ViewProfileCard> {
  late double height;
  late bool isExpanded;

  @override
  void initState() {
    height = widget.withIcon! ? 250.h : 225.h;
    isExpanded = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      width: 338.w,
      clipBehavior: Clip.none,

      height: height,
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.kGreyLight)),
      //padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: SingleChildScrollView(
        reverse: !isExpanded ? false : true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.withIcon!
                ? InkWell(
                    onTap: () async {
                      if (!isExpanded) {
                        height = widget.withIcon! ? 596.h : 581.h;
                        setState(() {});
                        //  await Future.delayed(const Duration(milliseconds: 200));
                        isExpanded = !isExpanded;
                        setState(() {});
                      } else {
                        height = widget.withIcon! ? 250.h : 225.h;
                        setState(() {});
                        await Future.delayed(const Duration(milliseconds: 1500));
                        isExpanded = !isExpanded;
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.kWhiteProfileCardIconArea,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(9), topLeft: Radius.circular(9)),

                        /*border: Border.symmetric(
                        vertical: BorderSide(color: AppColors.kGreyLight))*/
                      ),
                      child: Center(
                        child: Icon(isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  !isExpanded
                      ? ProfilCardItem()
                      //add expanded item for profile card
                      : ProfilCardExpandedItem(),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CoustomButton(
                            buttonName: "View profile",
                            backgoundColor: AppColors.kWhiteColor,
                            borderSideColor: AppColors.kPDarkBlueColor,
                            borderRadius: 10.0.r,
                            function: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget ProfilCardExpandedItem() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: Colors.red,
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/icons/chare.png',
                scale: 4,
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: UnicornOutlineButton(
                    minHeight: 170,
                    minWidth: 170,
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
                    child: Image.asset('assets/images/Rectangle.png', scale: 2),
                    onPressed: () {},
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 5.7, left: 9.8),
                  // width: 70.w,
                  // height: 28.45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.kGreyWhite),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/star.png', scale: 4.3),
                        Text(
                          '4.0',
                          style: AppTheme.subtitle2.copyWith(fontSize: 17, color: AppColors.kDimBlue),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.green,
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/icons/heart.png',
                scale: 4,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15.h,
      ),
      Text(
        "Spencer Smith",
        style: AppTheme.subtitle2.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 5.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.kSFlashyGreenColor),
            height: 8.h,
            width: 8.h,
          ),
          SizedBox(
            width: 4.h,
          ),
          Text(
            "Available",
            style: AppTheme.subtitle2
                .copyWith(color: AppColors.kSFlashyGreenColor, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      SizedBox(
        height: 5.h,
      ),
      Text(
        "Hairdresser, 2 kms",
        style: AppTheme.bodyText1.copyWith(
          color: AppColors.kPDarkBlueColor,
          //fontSize: 18,
          /* fontWeight: FontWeight.w500*/
        ),
      ),
      SizedBox(
        height: 5.h,
      ),
      Text(
        "Event in progress",
        style: AppTheme.subtitle1.copyWith(color: AppColors.kPDarkBlueColor, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 12.h,
      ),
      Text(
        "Expedita amet voluptate sequi qui sit asperiores non veniam veniam. Et ut dolorum repellat ea voluptas repellendus ipsam ipsam id. Id a quam...",
        style: AppTheme.subtitle1.copyWith(
          //color: AppColors.kPDarkBlueColor,
          fontSize: 10,
        ),
      ),
      SizedBox(
        height: 5.h,
      ),
      SizedBox(
        height: 118.h,
        child: ListView.separated(
          itemCount: 5,
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    height: 70.h,
                    width: 70.w,
                    child: Image.asset(aboutUS1, fit: BoxFit.fill),
                  ),
                  Expanded(
                    child: Text(
                      "Service name long text ldsak;djasdja;sjas;ljas;lsa;assa;d;",
                      style: AppTheme.subtitle2.copyWith(
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Text(
                    "00.00 EUR",
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
        ),
      ),
    ],
  );
}

Widget ProfilCardItem() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: UnicornOutlineButton(
              minHeight: 100,
              minWidth: 100,
              strokeWidth: 2,
              radius: 200,
              // gradient: const LinearGradient(
              //   colors: [
              //     AppColors.kPDarkBlueColor,
              //     AppColors.kSFlashyGreenColor,
              //   ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
              child: Image.asset('assets/images/Rectangle.png', scale: 4),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 5.7, left: 9.8),
            /*width: 70.w,
            height: 28.45.h,*/
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.kGreyWhite),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/icons/star.png', scale: 4.3),
                Text(
                  '4.0',
                  style: AppTheme.subtitle2.copyWith(fontSize: 17, color: AppColors.kDimBlue),
                ),
              ],
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
            // SizedBox(
            //   height: 15.h,
            // ),
            Text(
              "Spencer Smith",
              style: AppTheme.subtitle2.copyWith(fontSize: 16, color: AppColors.kPDarkBlueColor),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              "2 km away, Available",
              style: AppTheme.bodyText1.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              "Hairdresser",
              style: AppTheme.bodyText1.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              "Aperiam dolor aliquam. Nesciunt suscipit aut minus repellat quis. Voluptatum blanditiis corporis labori",
              style: AppTheme.bodyText1.copyWith(
                fontSize: 10,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
          InkWell(
            onTap: () {},
            child: Image.asset(
              'assets/icons/heart.png',
              scale: 4,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {},
            child: Image.asset(
              'assets/icons/chare.png',
              scale: 4,
            ),
          ),
        ],
      )
    ],
  );
}

class UnicornOutlineButton extends StatefulWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback? _callback;
  final double _radius;
  final double minWidth;
  final double minHeight;

  UnicornOutlineButton({
    double strokeWidth = 2,
    double radius = 200,
    Gradient? gradient,
    required Widget child,
    this.minHeight = 100,
    this.minWidth = 100,
    VoidCallback? onPressed,
  })  : this._painter = _GradientPainter(
          strokeWidth: strokeWidth,
          radius: radius,
          gradient: LinearGradient(
            colors: CashHelper.getRole() == 'Influencer'
                ? [AppColors.kPOrangeColor, AppColors.kPink]
                : [
                    AppColors.kPDarkBlueColor,
                    AppColors.kSFlashyGreenColor,
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        this._child = child,
        this._callback = onPressed,
        this._radius = radius;

  @override
  State<UnicornOutlineButton> createState() => _UnicornOutlineButtonState();
}

class _UnicornOutlineButtonState extends State<UnicornOutlineButton> {
  get role => CashHelper.getRole();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget._painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget._callback,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(widget._radius),
            onTap: widget._callback,
            child: Container(
              constraints: BoxConstraints(minWidth: widget.minWidth, minHeight: widget.minHeight),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget._child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required double strokeWidth, required double radius, Gradient? gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient!;

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect =
        Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class ImageAndNameWidget extends StatefulWidget {
  final String name;
  final List<Color>? colors;
  final double? minWidth;
  final double? maxHeight;
  final double? scale;

  const ImageAndNameWidget({super.key, required this.name, this.colors, this.minWidth, this.maxHeight, this.scale});

  @override
  State<ImageAndNameWidget> createState() => _ImageAndNameWidgetState();
}

class _ImageAndNameWidgetState extends State<ImageAndNameWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        UnicornOutlineButton(
          minWidth: widget.minWidth ?? 50,
          minHeight: widget.maxHeight ?? 50,
          strokeWidth: 5,
          radius: 100,
          child: Image.asset('assets/images/Rectangle.png', scale: widget.scale ?? 8),
          onPressed: () {},
        ),
        SizedBox(
          width: 15.w,
        ),
        Text(
          widget.name,
          style: AppTheme.bodyText1.copyWith(fontSize: 14),
        )
      ],
    );
  }
}
