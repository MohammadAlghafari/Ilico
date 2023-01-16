import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/assign_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'assign_category_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  AssignCategoryUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = AssignCategoryUseCase(authRepository!);
  });
  List<Activities> activities = [
    Activities(isSelected: true, description: "lllllllll", name: "ll", id: "kkk", isActive: true)
  ];
  GeneralInformation generalInformation = GeneralInformation(
      email: 'angham@gmail.com',
      firstName: 'angham',
      lastName: "kkk",
      dob: 'hhh',
      gender: 'll',
      phoneNumber: '1236445478');
  Address address = Address(address: 'hhhh', cityId: 'jjj', postalCode: 'kjnk', state: 'LLLL', country: 'KKK');
  ProfileCustomerModel customerModel = ProfileCustomerModel(
      activities: activities,
      id: 'kkkkkk',
      photoUrl: ';;;;;;;;;;',
      userStatus: 'hhhhhhh',
      address: address,
      generalInformation: generalInformation,
      completePercent: 2);
  ProfileSpModel profileSpModel = ProfileSpModel(
      activities: activities,
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
      activities: activities,
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

  AssignCategoryParams Params = AssignCategoryParams(categoriesIds: ["llll"]);

  HttpError error = const HttpError(message: ['Http error']);
  test('Success', () async {
    when(authRepository?.assignCategory(params: Params)).thenAnswer((_) async => RemoteResult(
          data: customerModel,
        ));
    final result = await useCase!.call(params: Params);

    expect(result.hasDataOnly, true);
    expect(result.data, customerModel);
    verify(useCase?.call(params: Params));
  });
  test('fail customer', () async {
    when(authRepository?.assignCategory(params: Params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: Params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: Params));
  });

  test('Success influncer ', () async {
    when(authRepository?.assignCategory(params: Params)).thenAnswer((_) async => RemoteResult(
          data: profileInfluencerModel,
        ));
    final result = await useCase!.call(params: Params);

    expect(result.hasDataOnly, true);
    expect(result.data, profileInfluencerModel);
    verify(useCase?.call(params: Params));
  });
  test('fail influncer', () async {
    when(authRepository!.assignCategory(params: Params)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await useCase!.call(params: Params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: Params));
  });
}
