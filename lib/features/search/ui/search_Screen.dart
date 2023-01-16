import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/constants/app_styles.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/search/ui/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../../../core/ui/widgets/Search_Text_filled.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: Colors.transparent,
        // title: "search",
        isCenterTitle: true,
        withBackButton: true,
        titleWidget: Image.asset(logoBlueIllico), action: [],
        /* action: [
          InkWell(
            onTap: () {
              setState(() {
                showSearchField = !showSearchField;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                search,
              ),
            ),
          ),
          isMap
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isMap = !isMap;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(listIcon),
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      isMap = !isMap;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(mapIcon),
                  ),
                ),
        ],*/
      ),
      /* AppBar(
        toolbarHeight: 64.h,
        elevation: 0,
        backgroundColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: true,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.kBlackColor,
        ),
        centerTitle: true,
        //  title:
        title: Text(
          "Search",
          style: AppTheme.headline3,
        ),
      ),*/
      body: Container(
        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
        height: 1.sh,
        width: 0.98.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.kWhiteColor,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 10.h),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: SearchTextFilled(
                  onChanged: (value) {
                    print(value);
                  },
                  isSuffixIcon: true,
                  isPrefixIcon: true,
                  controller: controller,
                ),
              ),
              ListView.builder(
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print("test");
                        Navigation.push(SearchResult());
                      },
                      leading: Image.asset(search_pin),
                      title: Text(
                        "Hair Salon",
                        style: AppTheme.headline5,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
