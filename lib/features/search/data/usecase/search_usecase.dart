import 'package:charja_charity/features/search/data/model/search_model.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../queries.dart';
import '../repository/search_repository.dart';

class SearchParams extends BaseParams {
  SearchParams(
      {this.searchKey,
      required this.isUser,
      this.latitude,
      this.longitude,
      this.search,
      this.request,
      this.to,
      this.isFavorite,
      this.isPremium})
      : super(query: isUser ? searchOfServiceProviderForUser : searchOfServiceProviderForGuest);
  final double? latitude;
  final double? longitude;
  final String? search;
  final String? searchKey;
  final bool? isFavorite;
  final bool? isPremium;
  final bool isUser;
  final double? to;
  final GetListRequest? request;

  Map<String, dynamic> toJson() {
    return {
      "searchDto": {
        "isPremium": isPremium,
        "latitude": latitude,
        "longitude": longitude,
        "search": search,
        "searchKey": searchKey,
        if (isUser) "isFavorite": isFavorite,
        "to": to
      },
      "pageOptionsDto": request!.toJson(),
    };
  }
}

class SearchUseCase extends UseCase<List<SearchOfServiceProvider>, SearchParams> {
  final SearchRepository repository;

  SearchUseCase(this.repository);

  @override
  Future<Result<List<SearchOfServiceProvider>>> call({required SearchParams params}) {
    return repository.getSearchResult(params: params);
  }
}
