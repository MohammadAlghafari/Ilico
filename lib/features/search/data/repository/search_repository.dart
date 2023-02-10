import 'package:charja_charity/core/repository/core_repository.dart';

import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/graphQl_provider.dart';
import '../../../../core/results/result.dart';
import '../model/auto_complete_model.dart';
import '../model/search_model.dart';
import '../model/storeLocationModel.dart';
import '../usecase/auto_complete_usecase.dart';
import '../usecase/search_usecase.dart';
import '../usecase/store_location_usecase.dart';

class SearchRepository extends CoreRepository {
  Future<Result<StoreLocation>> storeLocation({
    required StoreLocationParams params,
  }) async {
    final result = await RemoteDataSource.qlRequest(
        withAuthentication: false,
        params: params.toJson(),
        query: params.query!,
        method: QlMethod.mutations,
        responseStr: 'StoreLocation',
        modelKey: '',
        converter: (json) => StoreLocation.fromJson(json));
    return call(result: result);
  }

  Future<Result<List<AutoCompleteSearchItem>>> getAutoCompleteResult({required AutoCompleteSearchParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withCash: false,
        withAuthentication: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'GetAutoCompleteList',
        converter: (json) => GetAutoCompleteList.fromJson(json),
        query: params.query!,
        modelKey: 'autocompleteSearch');
    return paginatedCall(result: result);
  }

  Future<Result<List<SearchOfServiceProvider>>> getSearchResult({required SearchParams params}) async {
    final result = await RemoteDataSource.qlRequest(
        withCash: false,
        method: QlMethod.query,
        params: params.toJson(),
        responseStr: 'SearchModel',
        converter: (json) => SearchModel.fromJson(json),
        query: params.query!,
        modelKey: '');
    return paginatedCall(result: result);
  }
}
