import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_article_model.dart';
import '../queries.dart';
import '../repository/add_section_repostory.dart';

class EditArticleParams extends BaseParams {
  EditArticleParams({
    this.id,
    this.serviceProviderId,
    this.title,
    this.text,
    this.images,
    this.videos,
  }) : super(query: editArticle);
  String? serviceProviderId;
  String? title;
  String? text;
  String? id;

  List<String>? images = [];
  List<String>? videos = [];

  toJson() {
    return {
      "id": id,
      "updateArticleDto": {
        "serviceProviderId": serviceProviderId,
        "title": title?.trim() ?? " ",
        "text": text?.trim() ?? " ",
        "images": images /*?.where((element) => element.type == 1).toList()*/,
        "videos": videos
      } /*files?.where((element) => element.type == 2).toList()*/,
    };
  }
}

class EditArticleUseCase extends UseCase<CreateArticle, EditArticleParams> {
  final AddSectionRepostory repository;

  EditArticleUseCase(this.repository);

  @override
  Future<Result<CreateArticle>> call({required EditArticleParams params}) {
    return repository.editArticle(params: params);
  }
}
