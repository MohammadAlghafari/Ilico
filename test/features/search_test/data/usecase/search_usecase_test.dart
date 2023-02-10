import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/search/data/model/auto_complete_model.dart';
import 'package:charja_charity/features/search/data/repository/search_repository.dart';
import 'package:charja_charity/features/search/data/usecase/auto_complete_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_usecase_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  MockSearchRepository? searchRepository;
  AutoCompleteSearchUseCase? useCase;

  setUp(() {
    searchRepository = MockSearchRepository();
    useCase = AutoCompleteSearchUseCase(searchRepository!);
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
  test('Success', () async {
    when(searchRepository?.getAutoCompleteResult(params: autoCompleteSearchParams))
        .thenAnswer((_) async => PaginatedResult(
              data: autocompleteList,
            ));
    final result = await useCase!.call(params: autoCompleteSearchParams);

    expect(result.hasDataOnly, true);
    expect(result.data, autocompleteList);
    verify(useCase?.call(params: autoCompleteSearchParams));
  });
  test('fail customer', () async {
    when(searchRepository?.getAutoCompleteResult(params: autoCompleteSearchParams))
        .thenAnswer((_) async => PaginatedResult(error: error));

    final result = await useCase!.call(params: autoCompleteSearchParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: autoCompleteSearchParams));
  });
}
