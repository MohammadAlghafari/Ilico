import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/get_product_model.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  GetProductUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = GetProductUseCase(addSectionRepostory!);
  });
  Category category = Category(name: "test", id: "sdsds", description: "sfafaf", isActive: true);
  AddService getproductModel =
      AddService(price: 10, category: category, description: "test", name: "test", images: ['url'], videos: ['url']);
  List<AddService> services = [getproductModel, getproductModel, getproductModel];
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  GetProductParams getProductParams = GetProductParams(request: request, type: 'getService');
  HttpError error = const HttpError(message: ['Http error']);
  test('Success get service usecase', () async {
    when(addSectionRepostory?.getProduct(params: getProductParams)).thenAnswer((_) async => PaginatedResult(
          data: services,
        ));
    final result = await useCase!.call(params: getProductParams);

    expect(result.hasDataOnly, true);
    expect(result.data, services);
    verify(useCase!.call(params: getProductParams));
  });
  test('fail get service usecase', () async {
    when(addSectionRepostory!.getProduct(params: getProductParams))
        .thenAnswer((_) async => PaginatedResult(error: error));

    final result = await useCase!.call(params: getProductParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: getProductParams));
  });
}
