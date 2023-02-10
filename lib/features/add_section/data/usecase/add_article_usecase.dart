import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_article_model.dart';
import '../queries.dart';
import '../repository/add_section_repostory.dart';

class AddArticleParams extends BaseParams {
  AddArticleParams({
    this.serviceProviderId,
    this.title,
    this.text,
    this.images,
    this.videos,
  }) : super(query: createArticle);
  String? serviceProviderId;
  String? title;
  String? text;

  List<String>? images = [];
  List<String>? videos = [];

  toJson() {
    return {
      "createArticleDto": {
        "serviceProviderId": serviceProviderId,
        "title": title?.trim() ?? " ",
        "text": text?.trim() ?? " ",
        "images": images /*?.where((element) => element.type == 1).toList()*/,
        "videos": videos
      } /*files?.where((element) => element.type == 2).toList()*/,
    };
  }
}

class AddArticleUseCase extends UseCase<CreateArticle, AddArticleParams> {
  final AddSectionRepostory repository;

  AddArticleUseCase(this.repository);

  @override
  Future<Result<CreateArticle>> call({required AddArticleParams params}) {
    return repository.createArticle(params: params);
  }
}
