import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/get_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  GetEventUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = GetEventUseCase(addSectionRepostory!);
  });

  AddEventModel getEventModel = AddEventModel(description: "test", name: "test", images: ['url'], videos: ['url']);
  List<AddEventModel> events = [getEventModel, getEventModel, getEventModel];
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  GetEventParams getEventParams = GetEventParams(request: request, type: 'getService');
  HttpError error = const HttpError(message: ['Http error']);
  test('Success get event usecase', () async {
    when(addSectionRepostory?.getEvent(params: getEventParams)).thenAnswer((_) async => PaginatedResult(
          data: events,
        ));
    final result = await useCase!.call(params: getEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, events);
    verify(useCase!.call(params: getEventParams));
  });
  test('fail get event usecase', () async {
    when(addSectionRepostory!.getEvent(params: getEventParams)).thenAnswer((_) async => PaginatedResult(error: error));

    final result = await useCase!.call(params: getEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: getEventParams));
  });
}
