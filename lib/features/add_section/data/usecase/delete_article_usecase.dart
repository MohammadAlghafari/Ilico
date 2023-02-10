import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_article_model.dart';
import '../queries.dart';

class DeleteArticleParams extends BaseParams {
  DeleteArticleParams({this.id}) : super(query: deleteArticle);
  final String? id;

  Map<String, dynamic> toJson() {
    return {"id": id};
  }
}

class DeleteArticleUseCase extends UseCase<GetMyArticles, DeleteArticleParams> {
  final AddSectionRepostory repository;

  DeleteArticleUseCase(this.repository);

  @override
  Future<Result<GetMyArticles>> call({required DeleteArticleParams params}) {
    return repository.deleteArticle(params: params);
  }
}
