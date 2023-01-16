import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/get_product_model.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/get_product_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/profile_usecase.dart';
import 'package:charja_charity/features/profile/data/use_case/social_data_usecase.dart';
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
  GetproductModel getproductModel = GetproductModel(
      price: 10, categoryId: "test", description: "test", name: "test", images: ['url'], videos: ['url']);
  List<GetproductModel> services = [getproductModel, getproductModel, getproductModel];
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  GetProductParams getProductParams = GetProductParams(request: request, type: 'getService');
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

  test('Success get service,', () async {
    when(profileRepository?.getProduct(params: getProductParams)).thenAnswer((_) async => PaginatedResult(
          data: services,
        ));
    final result = await profileRepository!.getProduct(params: getProductParams);

    expect(result.hasDataOnly, true);
    expect(result.data, services);
    verify(profileRepository?.getProduct(params: getProductParams));
  });
  test('fail get service', () async {
    when(profileRepository?.getProduct(params: getProductParams))
        .thenAnswer((_) async => PaginatedResult(error: error));
    final result = await profileRepository!.getProduct(params: getProductParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(profileRepository!.getProduct(params: getProductParams));
  });
}
