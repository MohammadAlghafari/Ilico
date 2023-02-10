import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/profile/data/model/SPEventModel.dart';
import 'package:charja_charity/features/profile/data/model/SPProductsModel.dart';
import 'package:charja_charity/features/profile/data/model/SPServiceModel.dart';
import 'package:charja_charity/features/profile/data/model/delete_account_model.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/model/sp_general_information_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';
import 'package:charja_charity/features/profile/data/use_case/delete_account_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/profile_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/social_data_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_general_information_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_event_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_products_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/sp_get_services_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  ProfileRepository? profileRepository;
  setUp(() {
    profileRepository = MockProfileRepository();
  });
  GeneralInformation generalInformation = GeneralInformation(
      email: 'angham@gmail.com',
      firstName: 'angham',
      lastName: "kk",
      dob: 'hhh',
      gender: 'll',
      phoneNumber: '1236445478');
  Address address = Address(address: 'hhhh', cityId: 'jjj', postalCode: 'kjnk');
  ProfileCustomerModel customerModel = ProfileCustomerModel(
      id: 'kkkkkk',
      photoUrl: ';;;;;;;;;;',
      userStatus: 'hhhhhhh',
      address: address,
      generalInformation: generalInformation,
      completePercent: 2);
  ProfileSpModel profileSpModel = ProfileSpModel(
      completePercent: 2,
      generalInformation: generalInformation,
      address: address,
      userStatus: 'Pending',
      photoUrl: 'kmdjo',
      id: 'klsmcksdncjdn',
      companyModel: Company(
          id: 'djknhndnv',
          phoneNumber: '12346789',
          name: 'hbjhbj',
          description: 'klnl',
          iban: 'hbjhb',
          job: 'jfnvjk',
          sirenNumber: 'ndjkcn'),
      customerModel: Customer(
        id: 'jfnkjv',
        generalInformation: generalInformation,
      ),
      isAvailable: true,
      isCustomer: false,
      stripeCustomerId: 'hhjb');
  ProfileInfluencerModel profileInfluencerModel = ProfileInfluencerModel(
      generalInformation: generalInformation,
      id: 'fbjbvdjfbvdhfb',
      photoUrl: 'hfbvhjfdbv',
      userStatus: 'jnjfkd',
      address: address,
      completePercent: 1,
      facebookFollowers: 2,
      facebookUrl: 'fjdnkj',
      instagramFollowers: 2,
      instagramUrl: 'dcnkjdnc',
      snapchatFollowers: 1,
      snapchatUrl: 'dkmlkd',
      tiktokFollowers: 2,
      tiktokUrl: 'kjfdndn',
      twitterFollowers: 2,
      twitterUrl: 'lkmfjkd',
      youtubeFollowers: 1,
      youtubeUrl: 'kndkd');

  ProfileParams profileParams = ProfileParams();

  SocialDataParams params = SocialDataParams(
      facebookUrl: "https//",
      facebookFollowers: 50,
      instagramUrl: "https//",
      instagramFollowers: 50,
      tiktokUrl: "https//",
      tiktokFollowers: 50,
      youtubeUrl: "https//",
      youtubeFollowers: 50,
      twitterUrl: "https//",
      twitterFollowers: 50,
      snapchatUrl: "https//",
      snapchatFollowers: 50);

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

  AddEventModel addEventModel = AddEventModel(name: "test", description: "test", images: [], videos: []);
  SPEvent spEvent = SPEvent(event: [addEventModel, addEventModel, addEventModel]);
  SPGetEventParams spGetEventParamsUser =
      SPGetEventParams(id: "id", query: getEventByServiceProvideIdQueriesUser, latitude: 33.2323, longitude: 36.36362);

  AddService addService = AddService(id: "sdd", videos: [], images: [], description: "des", name: "name");
  SPProduct spProduct = SPProduct(products: [addService, addService, addService]);
  SPGetProductsParams spGetProductsParamsUser = SPGetProductsParams(
      id: "id", query: getProductsByServiceProvideIdQueriesUser, latitude: 33.2323, longitude: 36.36362);

  SPService spService = SPService(services: [addService, addService, addService]);
  SPGetServicesParams SPGetServicesParamsUser = SPGetServicesParams(
      id: "id", query: getServiceProviderGeneralInfoByIDQueriesUser, latitude: 33.2323, longitude: 36.36362);

  DeleteAccountModel deleteAccountModel = DeleteAccountModel(message: "test");
  DeleteAccountParams deleteAccountParams = DeleteAccountParams(password: "1321233215@Aa");
  HttpError error = const HttpError(message: ['Http error']);

  test('Success customer profile', () async {
    when(profileRepository?.getProfile(params: profileParams)).thenAnswer((_) async => RemoteResult(
          data: customerModel,
        ));
    final result = await profileRepository!.getProfile(params: profileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, customerModel);
    verify(profileRepository?.getProfile(params: profileParams));
  });
  test('fail customer profile', () async {
    when(profileRepository!.getProfile(params: profileParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await profileRepository!.getProfile(params: profileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getProfile(params: profileParams));
  });

  test('Success influncer profile', () async {
    when(profileRepository?.getProfile(params: profileParams)).thenAnswer((_) async => RemoteResult(
          data: profileInfluencerModel,
        ));
    final result = await profileRepository!.getProfile(params: profileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, profileInfluencerModel);
    verify(profileRepository?.getProfile(params: profileParams));
  });
  test('fail influncer profile', () async {
    when(profileRepository!.getProfile(params: profileParams)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await profileRepository!.getProfile(params: profileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getProfile(params: profileParams));
  });

  test('Success service profile', () async {
    when(profileRepository?.getProfile(params: profileParams)).thenAnswer((_) async => RemoteResult(
          data: profileSpModel,
        ));
    final result = await profileRepository!.getProfile(params: profileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, profileSpModel);
    verify(profileRepository?.getProfile(params: profileParams));
  });
  test('fail service profile', () async {
    when(profileRepository!.getProfile(params: profileParams)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await profileRepository!.getProfile(params: profileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getProfile(params: profileParams));
  });

  test('Success Social Data', () async {
    when(profileRepository?.update_social_media_data(params: params)).thenAnswer((_) async => RemoteResult(
          data: profileInfluencerModel,
        ));
    final result = await profileRepository!.update_social_media_data(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, profileInfluencerModel);
    verify(profileRepository?.update_social_media_data(params: params));
  });
  test('fail Social Data', () async {
    when(profileRepository!.update_social_media_data(params: params))
        .thenAnswer((_) async => RemoteResult(error: error));
    final result = await profileRepository!.update_social_media_data(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.update_social_media_data(params: params));
  });

  test('Success delete account,', () async {
    when(profileRepository?.deleteAccount(params: deleteAccountParams))
        .thenAnswer((_) async => Result<DeleteAccountModel>(
              data: deleteAccountModel,
            ));
    final result = await profileRepository!.deleteAccount(params: deleteAccountParams);

    expect(result.hasDataOnly, true);
    expect(result.data, deleteAccountModel);
    verify(profileRepository?.deleteAccount(params: deleteAccountParams));
  });
  test('fail delete account', () async {
    when(profileRepository?.deleteAccount(params: deleteAccountParams))
        .thenAnswer((_) async => Result<DeleteAccountModel>(error: error));
    final result = await profileRepository!.deleteAccount(params: deleteAccountParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.deleteAccount(params: deleteAccountParams));
  });
//general information
  test('Success get general information,', () async {
    when(profileRepository?.get_ServiceProviderByID(params: paramsUser))
        .thenAnswer((_) async => Result<SPGeneralInformationModel>(
              data: spGeneralInformationModel,
            ));
    final result = await profileRepository!.get_ServiceProviderByID(params: paramsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spGeneralInformationModel);
    verify(profileRepository?.get_ServiceProviderByID(params: paramsUser));
  });
  test('fail get general information', () async {
    when(profileRepository?.get_ServiceProviderByID(params: paramsUser))
        .thenAnswer((_) async => Result<SPGeneralInformationModel>(error: error));
    final result = await profileRepository!.get_ServiceProviderByID(params: paramsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.get_ServiceProviderByID(params: paramsUser));
  });

  //get events
  test('Success get events,', () async {
    when(profileRepository?.getEventById(params: spGetEventParamsUser)).thenAnswer((_) async => Result<SPEvent>(
          data: spEvent,
        ));
    final result = await profileRepository!.getEventById(params: spGetEventParamsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spEvent);
    verify(profileRepository?.getEventById(params: spGetEventParamsUser));
  });
  test('fail get events', () async {
    when(profileRepository?.getEventById(params: spGetEventParamsUser))
        .thenAnswer((_) async => Result<SPEvent>(error: error));
    final result = await profileRepository!.getEventById(params: spGetEventParamsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getEventById(params: spGetEventParamsUser));
  });
  //get services
  test('Success get services,', () async {
    when(profileRepository?.getServicesById(params: SPGetServicesParamsUser)).thenAnswer((_) async => Result<SPService>(
          data: spService,
        ));
    final result = await profileRepository!.getServicesById(params: SPGetServicesParamsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spService);
    verify(profileRepository?.getServicesById(params: SPGetServicesParamsUser));
  });
  test('fail get services', () async {
    when(profileRepository?.getServicesById(params: SPGetServicesParamsUser))
        .thenAnswer((_) async => Result<SPService>(error: error));
    final result = await profileRepository!.getServicesById(params: SPGetServicesParamsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getServicesById(params: SPGetServicesParamsUser));
  });
  //get products
  test('Success get products,', () async {
    when(profileRepository?.getProductsById(params: spGetProductsParamsUser)).thenAnswer((_) async => Result<SPProduct>(
          data: spProduct,
        ));
    final result = await profileRepository!.getProductsById(params: spGetProductsParamsUser);

    expect(result.hasDataOnly, true);
    expect(result.data, spProduct);
    verify(profileRepository?.getProductsById(params: spGetProductsParamsUser));
  });
  test('fail get products', () async {
    when(profileRepository?.getProductsById(params: spGetProductsParamsUser))
        .thenAnswer((_) async => Result<SPProduct>(error: error));
    final result = await profileRepository!.getProductsById(params: spGetProductsParamsUser);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getProductsById(params: spGetProductsParamsUser));
  });
}
