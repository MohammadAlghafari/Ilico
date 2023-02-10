import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/boilerplate/pagination/widgets/pagination_list.dart';
import '../../../core/constants/app_colors.dart';
import '../../profile/widgets/article_item.dart';
import '../data/model/get_article_model.dart';
import '../data/repository/add_section_repostory.dart';
import '../data/usecase/get_article_usecase.dart';

class ArticleScreen extends StatefulWidget {
  final ValueChanged voidCallback;
  ArticleScreen({Key? key, required this.voidCallback}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return PaginationList<GetMyArticles>(
      onCubitCreated: (PaginationCubit cub) {
        cubit = cub;
        widget.voidCallback(cubit);
      },
      withPagination: true,
      repositoryCallBack: (model) {
        return GetArticleUseCase(AddSectionRepostory()).call(params: GetArticleParams(request: model));
      },
      listBuilder: (list) {
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 27.w, right: 27.w, top: 24.h),
                child: Container(
                  width: 336.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.kGreyLight)),
                  child: ArticleItem(
                    cubit: cubit,
                    articleItem: list[index],
                    article: GetMyArticles(
                      text: list[index].text,
                      title: list[index].title,
                      images: list[index].images,
                      videos: list[index].videos,
                      id: list[index].id,
                    ),
                  ),
                ),
              );
            }));
      },
    );
  }
}
