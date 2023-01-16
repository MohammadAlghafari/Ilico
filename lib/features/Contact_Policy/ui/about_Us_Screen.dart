import 'package:carousel_slider/carousel_slider.dart';
import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../user_managment/widgets/sign_header_widget.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> item = [];
  @override
  void initState() {
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    item.add(_BuildCarouselItem());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 232.h,
        automaticallyImplyLeading: true,
        // leading: Icon(Icons.arrow_back),
        centerTitle: true,

        leading: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigation.pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        //  title:
        flexibleSpace: SignHeader(
          // height: 283.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_login.png",
                  width: 60,
                  height: 88.3,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "About us",
                  style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("We are qualified & of experience\n in this field",
                textAlign: TextAlign.start, style: AppTheme.subtitle2.copyWith(fontSize: 18)),
            SizedBox(
              height: 8.h,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. ",
                textAlign: TextAlign.start,
                style:
                    AppTheme.subtitle2.copyWith(fontSize: 14, color: AppColors.kDimBlue, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 32.h,
            ),
            Text("Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris.",
                textAlign: TextAlign.start, style: AppTheme.subtitle2.copyWith(fontSize: 18)),
            SizedBox(
              height: 24.h,
            ),
            Image.asset(handAboutUs),
            //TODO add Card Inside Image
            SizedBox(
              height: 24.h,
            ),
            Text(
                "Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum.Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia",
                textAlign: TextAlign.start,
                style:
                    AppTheme.headline5.copyWith(fontSize: 14, color: AppColors.kDimBlue, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 32.h,
            ),
            Text("Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris.",
                textAlign: TextAlign.center, style: AppTheme.subtitle2.copyWith(fontSize: 18)),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              width: 1.sw,
              height: 500.h,
              child: GridView(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 24.h, crossAxisSpacing: 24, childAspectRatio: 0.8),
                children: [
                  gridItem(handIcon, "Nulla quis sem at nibh ",
                      "Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh"),
                  Image.asset(
                    aboutUS1,
                    // width: 156,
                  ),
                  Image.asset(
                    aboutUS2,
                    //width: 156,
                  ),
                  gridItem(handIcon, "Nulla quis sem at nibh ",
                      "Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh"),
                  //ass
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Center(
              child: Text("What our clients say",
                  textAlign: TextAlign.center,
                  style: AppTheme.headline4.copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
            ),
            CarouselSlider(
              items: item,
              carouselController: _controller,
              options: CarouselOptions(
                height: 440.h,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: item.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.kGrayIndicator
                                : AppColors.kPDarkBlueColor)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),

            //TODO Add Dots Indicator
          ],
        ),
      ),
    );
  }

  Widget _BuildCarouselItem() {
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),
        Center(
          child: Image.asset(aboutUSCircleImage),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
            "Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum.Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia",
            textAlign: TextAlign.center,
            style: AppTheme.headline5.copyWith(fontSize: 14, color: AppColors.kDimBlue, fontWeight: FontWeight.w400)),
        SizedBox(
          height: 16.h,
        ),
        Center(
          child: Text("Jane Doe",
              textAlign: TextAlign.center,
              style: AppTheme.headline4
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.kPDarkBlueColor)),
        ),
        SizedBox(
          height: 4.h,
        ),
        Center(
          child: Text("Brussels",
              textAlign: TextAlign.center,
              style: AppTheme.headline5.copyWith(fontSize: 14, color: AppColors.kDimBlue, fontWeight: FontWeight.w300)),
        )
      ],
    );
  }

  Widget gridItem(String icon, String title, String Suptitle) {
    return Container(
      padding: EdgeInsets.all(16.r),
      // height: 202.h,
      width: 156.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.kWhiteColor,
        border: Border.all(color: AppColors.kPDarkBlueColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(handIcon),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.subtitle2.copyWith(fontWeight: FontWeight.w500, color: AppColors.kPDarkBlueColor),
          ),
          Text(
            Suptitle,
            textAlign: TextAlign.center,
            style: AppTheme.subtitle2.copyWith(fontWeight: FontWeight.w400, color: AppColors.kDimBlue),
          ),
        ],
      ),
    );
  }
}
