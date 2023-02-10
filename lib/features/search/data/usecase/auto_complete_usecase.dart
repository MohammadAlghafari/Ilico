import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/auto_complete_model.dart';
import '../queries.dart';
import '../repository/search_repository.dart';

class AutoCompleteSearchParams extends BaseParams {
  AutoCompleteSearchParams({this.type, this.latitude, this.longitude, this.search, this.request})
      : super(query: searchQueries);
  final String? latitude;
  final String? longitude;
  final String? search;
  final String? type;
  final GetListRequest? request;

  Map<String, dynamic> toJson() {
    return {
      "searchInput": {"latitude": latitude, "longitude": longitude, "search": search, "type": type},
      "pageOptionsDto": request!.toJson(),
    };
  }
}

class AutoCompleteSearchUseCase extends UseCase<List<AutoCompleteSearchItem>, AutoCompleteSearchParams> {
  final SearchRepository repository;

  AutoCompleteSearchUseCase(this.repository);

  @override
  Future<Result<List<AutoCompleteSearchItem>>> call({required AutoCompleteSearchParams params}) {
    return repository.getAutoCompleteResult(params: params);
  }
}
