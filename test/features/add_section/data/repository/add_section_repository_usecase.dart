import 'dart:io';

import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  AddSectionRepostory? addSectionRepository;
  setUp(() {
    addSectionRepository = MockAddSectionRepostory();
  });

  HttpError error = const HttpError(message: ['Http error']);
  Data data = Data(url: "url", key: "key");
  List<Data> dataList = [data, data];
  FileData filedata = FileData(data: dataList);
  List<File> file = [File("test"), File("test")];
  AddServiceParams params =
      AddServiceParams(name: "test", description: "test", categoryId: "test", price: 10.5, files: filedata);
  AddService addService =
      AddService(price: 10, categoryId: "test", description: "test", name: "test", images: ['url'], videos: ['url']);
  List<AddService> services = [addService, addService, addService];
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  GetProductParams getServiceParams = GetProductParams(request: request, type: 'test');
  GetFileParams getFileParams = GetFileParams(file: file, type: 'test');
  test('Success add service,product,event', () async {
    when(addSectionRepository?.addService(params: params)).thenAnswer((_) async => RemoteResult(
          data: addService,
        ));
    final result = await addSectionRepository!.addService(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, addService);
    verify(addSectionRepository?.addService(params: params));
  });
  test('fail add service,product,event', () async {
    when(addSectionRepository!.addService(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await addSectionRepository!.addService(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.addService(params: params));
  });
  test('Success upload file', () async {
    when(addSectionRepository?.uploadFiles(params: getFileParams)).thenAnswer((_) async => RemoteResult(
          data: filedata,
        ));
    final result = await addSectionRepository!.uploadFiles(params: getFileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, filedata);
    verify(addSectionRepository?.uploadFiles(params: getFileParams));
  });
  test('fail upload file', () async {
    when(addSectionRepository!.uploadFiles(params: getFileParams)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await addSectionRepository!.uploadFiles(params: getFileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.uploadFiles(params: getFileParams));
  });
}
