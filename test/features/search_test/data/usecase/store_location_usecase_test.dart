import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/search/data/model/storeLocationModel.dart';
import 'package:charja_charity/features/search/data/repository/search_repository.dart';
import 'package:charja_charity/features/search/data/usecase/store_location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_usecase_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  MockSearchRepository? searchRepository;
  StoreLocationUseCase? useCase;

  setUp(() {
    searchRepository = MockSearchRepository();
    useCase = StoreLocationUseCase(searchRepository!);
  });
  HttpError error = const HttpError(message: ['Http error']);
  StoreLocationParams storeLocationParams = StoreLocationParams(longitude: 33.3666565, latitude: 33.1233233);
  StoreLocation storeLocation = StoreLocation(message: "test");
  test('Success storeLocation', () async {
    when(searchRepository?.storeLocation(params: storeLocationParams)).thenAnswer((_) async => Result<StoreLocation>(
          data: storeLocation,
        ));
    final result = await useCase!.call(params: storeLocationParams);

    expect(result.hasDataOnly, true);
    expect(result.data, storeLocation);
    verify(useCase?.call(params: storeLocationParams));
  });
  test('fail storeLocation', () async {
    when(searchRepository?.storeLocation(params: storeLocationParams))
        .thenAnswer((_) async => Result<StoreLocation>(error: error));

    final result = await useCase!.call(params: storeLocationParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: storeLocationParams));
  });
}
