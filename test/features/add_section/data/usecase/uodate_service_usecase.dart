import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/get_product_model.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/update_service_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  UpdateServiceUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = UpdateServiceUseCase(addSectionRepostory!);
  });
  Data data = Data(url: "url", key: "key");
  List<Data> dataList = [data, data];
  FileData filedata = FileData(data: dataList);
  UpdateServiceParams updateServiceParams =
      UpdateServiceParams(name: "test", description: "test", categoryId: "test", price: 10.5);
  Category category = Category(name: "test", id: "sdsds", description: "sfafaf", isActive: true);
  AddService addService = AddService(
      id: "123123", price: 10, category: category, description: "test", name: "test", images: ['url'], videos: ['url']);
  HttpError error = const HttpError(message: ['Http error']);
  test('Success update service,product,event usecase', () async {
    when(addSectionRepostory?.updateService(params: updateServiceParams)).thenAnswer((_) async => RemoteResult(
          data: addService,
        ));
    final result = await useCase!.call(params: updateServiceParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addService);
    verify(useCase!.call(params: updateServiceParams));
  });
  test('fail add service,product,event usecase', () async {
    when(addSectionRepostory!.updateService(params: updateServiceParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: updateServiceParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: updateServiceParams));
  });
}
