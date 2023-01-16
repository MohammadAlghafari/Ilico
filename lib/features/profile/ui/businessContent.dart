import 'package:charja_charity/core/constants/app_icons.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/add_section/ui/edit_Product_Service_Event.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/ui/product_screen.dart';
import 'package:charja_charity/features/profile/ui/services_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/app_bar/app_bar_widget.dart';
import '../widgets/company_Widget.dart';

class BusinessContent extends StatefulWidget {
  final ValueChanged callBack;
  UserInfo profileModel;

  BusinessContent({Key? key, required this.profileModel, required this.callBack}) : super(key: key);

  @override
  _BusinessContentState createState() => _BusinessContentState();
}

class _BusinessContentState extends State<BusinessContent> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int SelectedTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Business content',
        withBackButton: true,
        action: [
          SelectedTabIndex == 1 || SelectedTabIndex == 2 || SelectedTabIndex == 3
              ? IconButton(
                  onPressed: () {
                    print("index **********************" + tabController.index.toString());

                    if (SelectedTabIndex == 1) {
                      //  print(widget.profileModel.activities![0]);
                      Navigation.push(EditProductServicEvent(
                        appBar_title: " Service",
                        page_type: 1,
                        activites: widget.profileModel.activities,
                      ));
                    } else if (SelectedTabIndex == 2) {
                      Navigation.push(EditProductServicEvent(
                        appBar_title: " Products",
                        page_type: 2,
                        activites: widget.profileModel.activities,
                      ));
                    } else if (SelectedTabIndex == 3) {
                      Navigation.push(EditProductServicEvent(
                        appBar_title: " Events",
                        page_type: 3,
                        activites: widget.profileModel.activities,
                      ));
                    } else {
                      //  print(SelectedTabIndex);
                    }
                  },
                  icon: SvgPicture.asset(addIcon))
              : Container(),
        ],
      ),
      body: Container(
        // height: 80.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // height: 80.h,
              color: AppColors.kWhiteProfileCardIconArea,
              child: TabBar(
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                indicatorColor: AppColors.kPDarkBlueColor,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                onTap: (int index) {
                  //  SelectedTabIndex = index;
                  setState(() {
                    SelectedTabIndex = index;
                  });
                },
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                labelColor: Colors.black,
                unselectedLabelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black.withOpacity(0.5)),
                labelStyle: AppTheme.subtitle2.copyWith(fontSize: 14, color: Colors.black),
                tabs: const [
                  Tab(
                    child: Text(
                      'Company',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Services',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Products',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Events',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Gallery',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Articles ',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Container(
                    //height: 100.h,
                    child: CompanyWidget(
                      callBack: widget.callBack,
                      profileModel: widget.profileModel as ProfileSpModel,
                    ),
                  ),
                  ServicesScreen(),
                  ProductScreen(),
                  Container(), //event
                  Container(), //gallary
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
