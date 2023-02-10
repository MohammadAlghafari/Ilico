import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/search/data/model/auto_complete_model.dart';
import 'package:charja_charity/features/search/data/model/storeLocationModel.dart';
import 'package:charja_charity/features/search/data/repository/search_repository.dart';
import 'package:charja_charity/features/search/data/usecase/auto_complete_usecase.dart';
import 'package:charja_charity/features/search/data/usecase/store_location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_repository_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  SearchRepository? searchRepository;
  setUp(() {
    searchRepository = MockSearchRepository();
  });
  GetListRequest request = GetListRequest(limit: 10, order: "asc", page: 1);
  HttpError error = const HttpError(message: ['Http error']);
  AutoCompleteSearchParams autoCompleteSearchParams = AutoCompleteSearchParams(
    request: request,
    search: "k",
    type: "Product",
  );
  AutoCompleteSearchItem autoCompleteSearchItem = AutoCompleteSearchItem(
    name: "kdkd",
    id: "444",
  );
  List<AutoCompleteSearchItem> autocompleteList = [autoCompleteSearchItem, autoCompleteSearchItem];

  StoreLocationParams storeLocationParams = StoreLocationParams(longitude: 33.3666565, latitude: 33.1233233);
  StoreLocation storeLocation = StoreLocation(message: "test");

  test('Success get autoCompleteResult', () async {
    when(searchRepository?.getAutoCompleteResult(params: autoCompleteSearchParams))
        .thenAnswer((_) async => PaginatedResult(
              data: autocompleteList,
            ));
    final result = await searchRepository!.getAutoCompleteResult(params: autoCompleteSearchParams);

    expect(result.hasDataOnly, true);
    expect(result.data, autocompleteList);
    verify(searchRepository!.getAutoCompleteResult(params: autoCompleteSearchParams));
  });
  test('fail get autoCompleteResult', () async {
    when(searchRepository!.getAutoCompleteResult(params: autoCompleteSearchParams))
        .thenAnswer((_) async => PaginatedResult(error: error));

    final result = await searchRepository!.getAutoCompleteResult(params: autoCompleteSearchParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(searchRepository!.getAutoCompleteResult(params: autoCompleteSearchParams));
  });

  test('Success storeLocation', () async {
    when(searchRepository?.storeLocation(params: storeLocationParams)).thenAnswer((_) async => Result<StoreLocation>(
          data: storeLocation,
        ));
    final result = await searchRepository!.storeLocation(params: storeLocationParams);

    expect(result.hasDataOnly, true);
    expect(result.data, storeLocation);
    verify(searchRepository!.storeLocation(params: storeLocationParams));
  });
  test('fail storeLocation', () async {
    when(searchRepository!.storeLocation(params: storeLocationParams))
        .thenAnswer((_) async => Result<StoreLocation>(error: error));

    final result = await searchRepository!.storeLocation(params: storeLocationParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(searchRepository!.storeLocation(params: storeLocationParams));
  });
}
