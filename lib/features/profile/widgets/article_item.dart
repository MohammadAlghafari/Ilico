import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../add_section/data/model/get_article_model.dart';
import '../../add_section/ui/edit_article_screen.dart';

class ArticleItem extends StatelessWidget {
  final GetMyArticles articleItem;
  final PaginationCubit? cubit;
  final dynamic article;
  const ArticleItem({Key? key, required this.articleItem, this.cubit, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              child: Container(
                width: 80.w,
                height: 120.h,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                child: Image.network(articleItem.images!.isNotEmpty ? articleItem.images![0] : "", fit: BoxFit.cover),
              ),
            )),
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${articleItem.title}',
                          style: AppTheme.subtitle2.copyWith(fontSize: 14, color: AppColors.kPDarkBlueColor)),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w, top: 5),
                        child: InkWell(
                          child: SvgPicture.asset(
                            editIcon,
                          ),
                          onTap: () {
                            Navigation.push(EditArticleServiceScreen(
                              article: article,
                              articleId: articleItem.id,
                              isEdit: true,
                              valueChanged: (val) {
                                cubit?.getList();
                              },
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                  Text(
                    convertDate(date: articleItem.createdAt!),
                    style: AppTheme.bodyText1.copyWith(fontSize: 10, color: AppColors.kGrayTextField),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Text(
                      '${articleItem.text}',
                      style: AppTheme.bodyText1.copyWith(fontSize: 12),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  String convertDate({
    required String date,
  }) {
    DateTime dateTime = DateTime.parse(date);
    String dateLocal = dateTime.toLocal().toString();
    String dateFormat = DateFormat('dd/MM/yyyy').format(DateTime.parse(dateLocal));
    return dateFormat;
  }
}
