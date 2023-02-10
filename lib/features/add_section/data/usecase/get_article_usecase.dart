import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_article_model.dart';
import '../queries.dart';
import '../repository/add_section_repostory.dart';

class GetArticleParams extends BaseParams {
  final GetListRequest request;
  GetArticleParams({
    required this.request,
  }) : super(query: getArticles);
  Map<String, dynamic> toJson() {
    return {
      "pageOptionsDto": request.toJson(),
    };
  }
}

class GetArticleUseCase extends UseCase<List<GetMyArticles>, GetArticleParams> {
  final AddSectionRepostory repository;

  GetArticleUseCase(this.repository);

  @override
  Future<Result<List<GetMyArticles>>> call({required GetArticleParams params}) {
    return repository.getArticle(params: params);
  }
}
