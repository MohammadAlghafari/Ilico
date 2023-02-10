import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  AddEventUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = AddEventUseCase(addSectionRepostory!);
  });
  AddEventParams addEventParams =
      AddEventParams(startdate: "2023-01-03", images: [], videos: [], name: "test", description: "test");
  AddEventModel addEventModel =
      AddEventModel(description: "desc", name: "test", videos: [], images: [], startDate: "2023-01-03", id: "test");
  HttpError error = const HttpError(message: ['Http error']);
  test('Success add event usecase', () async {
    when(addSectionRepostory?.addEvent(params: addEventParams)).thenAnswer((_) async => RemoteResult(
          data: addEventModel,
        ));
    final result = await useCase!.call(params: addEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addEventModel);
    verify(useCase!.call(params: addEventParams));
  });
  test('fail add service,product,event usecase', () async {
    when(addSectionRepostory!.addEvent(params: addEventParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: addEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: addEventParams));
  });
}
