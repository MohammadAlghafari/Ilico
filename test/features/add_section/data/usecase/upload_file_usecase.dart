import 'dart:io';

import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  GetUploadFileUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = GetUploadFileUseCase(addSectionRepostory!);
  });

  Data data = Data(url: "url", key: "key");
  List<Data> dataList = [data, data];
  FileData filedata = FileData(data: dataList);
  List<File> file = [File("test"), File("test")];

  GetFileParams params = GetFileParams(file: file, type: 'string');
  HttpError error = const HttpError(message: ['Http error']);
  test('Success upload file usecase', () async {
    when(addSectionRepostory?.uploadFiles(params: params)).thenAnswer((_) async => RemoteResult(
          data: filedata,
        ));
    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, filedata);
    verify(useCase!.call(params: params));
  });
  test('fail upload file usecase', () async {
    when(addSectionRepostory!.uploadFiles(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
