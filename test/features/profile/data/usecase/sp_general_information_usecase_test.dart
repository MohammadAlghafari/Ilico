import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/model/sp_general_information_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_general_information_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  SPGeneralInformationUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = SPGeneralInformationUseCase(profileRepository!);
  });

  GeneralInformation generalInformation = GeneralInformation(
      email: 'ibrahim@gmail.com',
      firstName: 'angham',
      lastName: "kkk",
      dob: '1998',
      gender: 'M',
      phoneNumber: '+963144454545');
  Activities activities = Activities(id: "123", name: "name", description: "des", isSelected: false, isActive: true);
  Company company = Company(description: "des", name: "name", id: "123", phoneNumber: "+963123456789");
  SPGeneralInformationModel spGeneralInformationModel = SPGeneralInformationModel(
      photoUrl: " image",
      activities: [activities, activities, activities],
      company: company,
      generalInformation: generalInformation);
  // Address address = Address(address: 'address', cityId: '10', postalCode: '965482');
  SPGeneralInformationParams paramsUser = SPGeneralInformationParams(
      id: "id", query: getServiceProviderGeneralInfoByIDQueriesUser, latitude: 33.32222, longitude: 36.32523);
  SPGeneralInformationParams paramsGuest = SPGeneralInformationParams(
      id: "id", query: getServiceProviderGeneralInfoByIDQueriesGuest, latitude: 33.32222, longitude: 36.32523);

  HttpError error = const HttpError(message: ['Http error']);
  test('Success get service provider information User', () async {
    when(profileRepository?.get_ServiceProviderByID(params: paramsUser))
        .thenAnswer((_) async => Result<SPGeneralInformationModel>(
              data: spGeneralInformationModel,
            ));
    final result = await useCase!.call(params: paramsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spGeneralInformationModel);
    verify(useCase?.call(params: paramsUser));
  });
  test('fail get service provider information User', () async {
    when(profileRepository!.get_ServiceProviderByID(params: paramsUser))
        .thenAnswer((_) async => Result<SPGeneralInformationModel>(error: error));

    final result = await useCase!.call(params: paramsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: paramsUser));
  });

  test('Success get service provider information Guest', () async {
    when(profileRepository?.get_ServiceProviderByID(params: paramsGuest))
        .thenAnswer((_) async => Result<SPGeneralInformationModel>(
              data: spGeneralInformationModel,
            ));
    final result = await useCase!.call(params: paramsGuest);

    expect(result.hasDataOnly, true);
    expect(result.data, spGeneralInformationModel);
    verify(useCase?.call(params: paramsGuest));
  });
  test('fail get service provider information Guest', () async {
    when(profileRepository!.get_ServiceProviderByID(params: paramsGuest))
        .thenAnswer((_) async => Result<SPGeneralInformationModel>(error: error));

    final result = await useCase!.call(params: paramsGuest);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: paramsGuest));
  });
}
