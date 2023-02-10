import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/search_article.dart';
import '../queries.dart';

class SearchArticleParams extends BaseParams {
  SearchArticleParams({this.name, this.count})
      : super(
            query:
                (CashHelper.getRole() == 'ServiceProvider') ? searchOfInfluencerByName : searchOfServiceProviderByName);
  final String? name;
  final int? count;
  Map<String, dynamic> toJson() {
    return {"name": name};
  }
}

class SearchArticleUseCase extends UseCase<SearchList, SearchArticleParams> {
  final AddSectionRepostory repository;

  SearchArticleUseCase(this.repository);

  @override
  Future<Result<SearchList>> call({required SearchArticleParams params}) {
    return repository.getSearch(params: params);
  }
}
