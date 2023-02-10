import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/deleteEventModel.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  DeleteEventUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = DeleteEventUseCase(addSectionRepostory!);
  });
  DeleteEventParams deleteEventParams = DeleteEventParams(id: "123123");
  DeleteEventModel deleteEventModel = DeleteEventModel(message: "test");
  HttpError error = const HttpError(message: ['Http error']);
  test('Success delete event usecase', () async {
    when(addSectionRepostory?.deleteEvent(params: deleteEventParams)).thenAnswer((_) async => RemoteResult(
          data: deleteEventModel,
        ));
    final result = await useCase!.call(params: deleteEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, deleteEventModel);
    verify(useCase!.call(params: deleteEventParams));
  });
  test('fail delete event usecase', () async {
    when(addSectionRepostory!.deleteEvent(params: deleteEventParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: deleteEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: deleteEventParams));
  });
}
