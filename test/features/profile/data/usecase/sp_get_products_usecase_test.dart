import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/profile/data/model/SPProductsModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  SPGetProductsUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = SPGetProductsUseCase(profileRepository!);
  });
  AddService item = AddService(name: "test", description: "test", images: [], videos: []);
  SPProduct spProduct = SPProduct(products: [item, item, item]);
  SPGetProductsParams spGetProductsParamsUser = SPGetProductsParams(
      id: "id", query: getProductsByServiceProvideIdQueriesUser, latitude: 33.2323, longitude: 36.36362);
  SPGetProductsParams spGetProductsParamsGuest = SPGetProductsParams(
      id: "id", query: getProductsByServiceProvideIdQueriesGuest, latitude: 33.2323, longitude: 36.36362);

  HttpError error = const HttpError(message: ['Http error']);
  test('Success get Products provider event User', () async {
    when(profileRepository?.getProductsById(params: spGetProductsParamsUser)).thenAnswer((_) async => Result<SPProduct>(
          data: spProduct,
        ));
    final result = await useCase!.call(params: spGetProductsParamsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spProduct);
    verify(useCase?.call(params: spGetProductsParamsUser));
  });
  test('fail get Products provider event User', () async {
    when(profileRepository!.getProductsById(params: spGetProductsParamsUser))
        .thenAnswer((_) async => Result<SPProduct>(error: error));

    final result = await useCase!.call(params: spGetProductsParamsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: spGetProductsParamsUser));
  });

  test('Success get Products provider event Guest', () async {
    when(profileRepository?.getProductsById(params: spGetProductsParamsGuest))
        .thenAnswer((_) async => Result<SPProduct>(
              data: spProduct,
            ));
    final result = await useCase!.call(params: spGetProductsParamsGuest);

    expect(result.hasDataOnly, true);
    expect(result.data, spProduct);
    verify(useCase?.call(params: spGetProductsParamsGuest));
  });
  test('fail get Products provider event Guest', () async {
    when(profileRepository!.getProductsById(params: spGetProductsParamsGuest))
        .thenAnswer((_) async => Result<SPProduct>(error: error));

    final result = await useCase!.call(params: spGetProductsParamsGuest);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: spGetProductsParamsGuest));
  });
}
