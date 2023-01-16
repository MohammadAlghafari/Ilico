import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  AddServiceUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = AddServiceUseCase(addSectionRepostory!);
  });
  Data data = Data(url: "url", key: "key");
  List<Data> dataList = [data, data];
  FileData filedata = FileData(data: dataList);
  AddServiceParams addServiceParams =
      AddServiceParams(name: "test", description: "test", categoryId: "test", price: 10.5, files: filedata);
  AddService addService =
      AddService(price: 10, categoryId: "test", description: "test", name: "test", images: ['url'], videos: ['url']);
  HttpError error = const HttpError(message: ['Http error']);
  test('Success add service,product,event usecase', () async {
    when(addSectionRepostory?.addService(params: addServiceParams)).thenAnswer((_) async => RemoteResult(
          data: addService,
        ));
    final result = await useCase!.call(params: addServiceParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addService);
    verify(useCase!.call(params: addServiceParams));
  });
  test('fail add service,product,event usecase', () async {
    when(addSectionRepostory!.addService(params: addServiceParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: addServiceParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: addServiceParams));
  });
}
