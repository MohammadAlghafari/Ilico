import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/get_product_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../profile/data/repository/profile_repository_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? addProfileRepository;
  GetProductUseCase? useCase;

  setUp(() {
    addProfileRepository = MockProfileRepository();
    useCase = GetProductUseCase(addProfileRepository!);
  });

  GetproductModel getproductModel = GetproductModel(
      price: 10, categoryId: "test", description: "test", name: "test", images: ['url'], videos: ['url']);
  List<GetproductModel> services = [getproductModel, getproductModel, getproductModel];
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  GetProductParams getProductParams = GetProductParams(request: request, type: 'getService');
  HttpError error = const HttpError(message: ['Http error']);
  test('Success get service usecase', () async {
    when(addProfileRepository?.getProduct(params: getProductParams)).thenAnswer((_) async => PaginatedResult(
          data: services,
        ));
    final result = await useCase!.call(params: getProductParams);

    expect(result.hasDataOnly, true);
    expect(result.data, services);
    verify(useCase!.call(params: getProductParams));
  });
  test('fail get service usecase', () async {
    when(addProfileRepository!.getProduct(params: getProductParams))
        .thenAnswer((_) async => PaginatedResult(error: error));

    final result = await useCase!.call(params: getProductParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: getProductParams));
  });
}
