import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/update_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  UpdateEventUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = UpdateEventUseCase(addSectionRepostory!);
  });

  UpdateEventParams updateEventParams = UpdateEventParams(
      id: "123", startDate: "2023-01-03", images: [], videos: [], name: "test", description: "test", type: 3);
  AddEventModel addEventModel =
      AddEventModel(description: "test", name: "test", videos: [], images: [], startDate: "2023-01-03", id: "1313");
  HttpError error = const HttpError(message: ['Http error']);

  test('Success update event usecase', () async {
    when(addSectionRepostory?.updateEvent(params: updateEventParams)).thenAnswer((_) async => RemoteResult(
          data: addEventModel,
        ));
    final result = await useCase!.call(params: updateEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addEventModel);
    verify(useCase!.call(params: updateEventParams));
  });
  test('fail update event usecase', () async {
    when(addSectionRepostory!.updateEvent(params: updateEventParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: updateEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: updateEventParams));
  });
}
