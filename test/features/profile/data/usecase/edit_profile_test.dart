import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/edit_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  EditProfileUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = EditProfileUseCase(profileRepository!);
  });

  GeneralInformation generalInformation = GeneralInformation(
      email: 'angham@gmail.com',
      firstName: 'angham',
      lastName: "kkk",
      dob: 'hhh',
      gender: 'll',
      phoneNumber: '1236445478');
  Address address = Address(address: 'hhhh', cityId: 'jjj', postalCode: 'kjnk', country: 'KKK', state: 'JJJJ');
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
  EditProfileParams editCustomerProfileParams = EditProfileParams(
      address: 'jh',
      photoUrl: 'ddddfc',
      firstName: 'angham',
      lastName: "kkk",
      phoneNumber: '123456788',
      gender: 'snkj',
      email: 'salma@yopmail.com',
      postalCode: 'hfdb',
      cityId: 'fjdk',
      dot: DateTime.now(),
      passportNumber: 'nj');
  EditProfileParams editInfluncerProfileParams = EditProfileParams(
      address: 'jh',
      photoUrl: 'ddddfc',
      firstName: 'angham',
      lastName: "kkk",
      phoneNumber: '123456788',
      gender: 'snkj',
      email: 'salma@yopmail.com',
      postalCode: 'hfdb',
      cityId: 'fjdk',
      dot: DateTime.now(),
      passportNumber: 'nj');
  EditProfileParams editServiceProfileParams = EditProfileParams(
      address: 'jh',
      photoUrl: 'ddddfc',
      firstName: 'angham',
      lastName: "kkk",
      phoneNumber: '123456788',
      gender: 'snkj',
      email: 'salma@yopmail.com',
      postalCode: 'hfdb',
      cityId: 'fjdk',
      dot: DateTime.now(),
      passportNumber: 'nj');

  HttpError error = const HttpError(message: ['Http error']);
  test('Success editCustomer profile', () async {
    when(profileRepository?.editProfile(params: editCustomerProfileParams)).thenAnswer((_) async => RemoteResult(
          data: customerModel,
        ));
    final result = await useCase!.call(params: editCustomerProfileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, customerModel);
    verify(useCase?.call(params: editCustomerProfileParams));
  });
  test('fail edit customer profile', () async {
    when(profileRepository!.editProfile(params: editCustomerProfileParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: editCustomerProfileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: editCustomerProfileParams));
  });

  test('Success edit influncer profile', () async {
    when(profileRepository?.editProfile(params: editInfluncerProfileParams)).thenAnswer((_) async => RemoteResult(
          data: profileInfluencerModel,
        ));
    final result = await useCase!.call(params: editInfluncerProfileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, profileInfluencerModel);
    verify(useCase?.call(params: editInfluncerProfileParams));
  });
  test('fail edit influncer profile', () async {
    when(profileRepository!.editProfile(params: editInfluncerProfileParams))
        .thenAnswer((_) async => RemoteResult(error: error));
    final result = await useCase!.call(params: editInfluncerProfileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: editInfluncerProfileParams));
  });

  test('Success edit service profile', () async {
    when(profileRepository?.editProfile(params: editServiceProfileParams)).thenAnswer((_) async => RemoteResult(
          data: profileSpModel,
        ));
    final result = await useCase!.call(params: editServiceProfileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, profileSpModel);
    verify(useCase?.call(params: editServiceProfileParams));
  });
  test('fail edit service profile', () async {
    when(profileRepository!.editProfile(params: editServiceProfileParams))
        .thenAnswer((_) async => RemoteResult(error: error));
    final result = await useCase!.call(params: editServiceProfileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: editServiceProfileParams));
  });
}
