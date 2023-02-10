import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/profile/data/model/SPEventModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_event_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  SPGetEventUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = SPGetEventUseCase(profileRepository!);
  });
  AddEventModel item = AddEventModel(name: "test", description: "test", images: [], videos: []);
  SPEvent spEvent = SPEvent(event: [item, item, item]);
  SPGetEventParams spGetEventParamsUser =
      SPGetEventParams(id: "id", query: getEventByServiceProvideIdQueriesUser, latitude: 33.2323, longitude: 36.36362);
  SPGetEventParams spGetEventParamsGuest =
      SPGetEventParams(id: "id", query: getEventByServiceProvideIdQueriesGuest, latitude: 33.2323, longitude: 36.36362);

  HttpError error = const HttpError(message: ['Http error']);
  test('Success get service provider event User', () async {
    when(profileRepository?.getEventById(params: spGetEventParamsUser)).thenAnswer((_) async => Result<SPEvent>(
          data: spEvent,
        ));
    final result = await useCase!.call(params: spGetEventParamsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spEvent);
    verify(useCase?.call(params: spGetEventParamsUser));
  });
  test('fail get service provider event User', () async {
    when(profileRepository!.getEventById(params: spGetEventParamsUser))
        .thenAnswer((_) async => Result<SPEvent>(error: error));

    final result = await useCase!.call(params: spGetEventParamsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: spGetEventParamsUser));
  });

  test('Success get service provider event Guest', () async {
    when(profileRepository?.getEventById(params: spGetEventParamsGuest)).thenAnswer((_) async => Result<SPEvent>(
          data: spEvent,
        ));
    final result = await useCase!.call(params: spGetEventParamsGuest);

    expect(result.hasDataOnly, true);
    expect(result.data, spEvent);
    verify(useCase?.call(params: spGetEventParamsGuest));
  });
  test('fail get service provider event Guest', () async {
    when(profileRepository!.getEventById(params: spGetEventParamsGuest))
        .thenAnswer((_) async => Result<SPEvent>(error: error));

    final result = await useCase!.call(params: spGetEventParamsGuest);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: spGetEventParamsGuest));
  });
}
