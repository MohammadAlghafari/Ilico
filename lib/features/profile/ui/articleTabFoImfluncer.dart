import 'package:charja_charity/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:charja_charity/core/ui/widgets/loading.dart';
import 'package:charja_charity/features/profile/data/model/SPArticleModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/influncer_get_article_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/ui/widgets/no_data_widget.dart';
import '../../../core/utils/cashe_helper.dart';
import '../widgets/sp_article_item.dart';

class ArticleTabForInfluncer extends StatefulWidget {
  final String id;

  const ArticleTabForInfluncer({Key? key, required this.id}) : super(key: key);

  @override
  _ArticleTabForInfluncerState createState() => _ArticleTabForInfluncerState();
}

class _ArticleTabForInfluncerState extends State<ArticleTabForInfluncer> {
  // late PaginationCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GetModel<SPArticleModel>(
      modelBuilder: ((model) {
        if (model.article!.isEmpty) {
          return const Center(child: NoDataWidget());
        }
        return ListView.builder(
            itemCount: model.article!.length,
            itemBuilder: ((context, index) {
              return SPArticleItem(
                description: model.article![index].text!,
                name: model.article![index].title!,
                image: model.article![index].images!.isNotEmpty ? model.article![index].images![0] : "",
                date: model.article![index].createdAt,
                isEvent: false,

                // price: model.products![index].price!,
              );
            }));
      }),
      loading: LoadingIndicator(),
      onSuccess: (SPArticleModel model) {
        print("test");
      },
      useCaseCallBack: () {
        if (CashHelper.authorized) {
          return InfluncerGetArticleUseCase(ProfileRepository())
              .call(params: InfluncerGetArticleParams(id: widget.id, query: getArticlByInfluncerIdQueriesUser));
        } else {
          return InfluncerGetArticleUseCase(ProfileRepository())
              .call(params: InfluncerGetArticleParams(id: widget.id, query: getArticlByInfluncerIdQueriesGuest));
        }
      },
    );
  }
}
