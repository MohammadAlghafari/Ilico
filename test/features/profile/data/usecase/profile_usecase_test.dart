import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  ProfileUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = ProfileUseCase(profileRepository!);
  });
  GeneralInformation generalInformation = GeneralInformation(
      email: 'angham@gmail.com',
      firstName: 'angham',
      lastName: "kkk",
      dob: 'hhh',
      gender: 'll',
      phoneNumber: '1236445478');
  Address address = Address(address: 'hhhh', cityId: 'jjj', postalCode: 'kjnk', state: 'LLLL', country: 'KKK');
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

  ProfileParams Params = ProfileParams();

  HttpError error = const HttpError(message: ['Http error']);
  test('Success customer profile', () async {
    when(profileRepository?.getProfile(params: Params)).thenAnswer((_) async => RemoteResult(
          data: customerModel,
        ));
    final result = await useCase!.call(params: Params);

    expect(result.hasDataOnly, true);
    expect(result.data, customerModel);
    verify(useCase?.call(params: Params));
  });
  test('fail customer profile', () async {
    when(profileRepository!.getProfile(params: Params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: Params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: Params));
  });

  test('Success influncer profile', () async {
    when(profileRepository?.getProfile(params: Params)).thenAnswer((_) async => RemoteResult(
          data: profileInfluencerModel,
        ));
    final result = await useCase!.call(params: Params);

    expect(result.hasDataOnly, true);
    expect(result.data, profileInfluencerModel);
    verify(useCase?.call(params: Params));
  });
  test('fail influncer profile', () async {
    when(profileRepository!.getProfile(params: Params)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await useCase!.call(params: Params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: Params));
  });

  test('Success service profile', () async {
    when(profileRepository?.getProfile(params: Params)).thenAnswer((_) async => RemoteResult(
          data: profileSpModel,
        ));
    final result = await useCase!.call(params: Params);

    expect(result.hasDataOnly, true);
    expect(result.data, profileSpModel);
    verify(useCase?.call(params: Params));
  });
  test('fail service profile', () async {
    when(profileRepository!.getProfile(params: Params)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await useCase!.call(params: Params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: Params));
  });
}
