import 'package:charja_charity/core/ui/app_bar/app_bar_widget.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/explore/ui/article_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/ui/widgets/Search_Text_filled.dart';
import '../widget/article_explor_item.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late TextEditingController articlesController;

  @override
  void initState() {
    articlesController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLightColor,
      appBar: AppBarWidget(
        title: 'Articles',
        backgroundColor: Colors.white,
        appBarHeight: 64.h,
        withBackButton: true,
        action: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child:  SearchTextFilled(
                // controller: articlesController,
                hintText: 'Search an article...',
                isSuffixIcon: false,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 20.h),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: ArticleExplorItem(
                            fromListArticle: true,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigation.push(ArticleDetail());
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
