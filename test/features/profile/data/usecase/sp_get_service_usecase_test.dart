import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/profile/data/model/SPServiceModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_services_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  SPGetServicesUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = SPGetServicesUseCase(profileRepository!);
  });
  AddService item = AddService(name: "test", description: "test", images: [], videos: []);
  SPService spService = SPService(services: [item, item, item]);
  SPGetServicesParams SPGetServicesParamsUser = SPGetServicesParams(
      id: "id", query: getServiceProviderGeneralInfoByIDQueriesUser, latitude: 33.2323, longitude: 36.36362);
  SPGetServicesParams SPGetServicesParamsGuest = SPGetServicesParams(
      id: "id", query: getServiceProviderGeneralInfoByIDQueriesGuest, latitude: 33.2323, longitude: 36.36362);

  HttpError error = const HttpError(message: ['Http error']);
  test('Success get Service provider Services User', () async {
    when(profileRepository?.getServicesById(params: SPGetServicesParamsUser)).thenAnswer((_) async => Result<SPService>(
          data: spService,
        ));
    final result = await useCase!.call(params: SPGetServicesParamsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spService);
    verify(useCase?.call(params: SPGetServicesParamsUser));
  });
  test('fail get Service provider Services User', () async {
    when(profileRepository!.getServicesById(params: SPGetServicesParamsUser))
        .thenAnswer((_) async => Result<SPService>(error: error));

    final result = await useCase!.call(params: SPGetServicesParamsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: SPGetServicesParamsUser));
  });

  test('Success get Service provider Services Guest', () async {
    when(profileRepository?.getServicesById(params: SPGetServicesParamsGuest))
        .thenAnswer((_) async => Result<SPService>(
              data: spService,
            ));
    final result = await useCase!.call(params: SPGetServicesParamsGuest);

    expect(result.hasDataOnly, true);
    expect(result.data, spService);
    verify(useCase?.call(params: SPGetServicesParamsGuest));
  });
  test('fail get Service provider Services Guest', () async {
    when(profileRepository!.getServicesById(params: SPGetServicesParamsGuest))
        .thenAnswer((_) async => Result<SPService>(error: error));

    final result = await useCase!.call(params: SPGetServicesParamsGuest);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: SPGetServicesParamsGuest));
  });
}
