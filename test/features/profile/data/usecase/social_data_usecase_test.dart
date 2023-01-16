import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/social_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  SocialDataUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = SocialDataUseCase(profileRepository!);
  });

  GeneralInformation generalInformation = GeneralInformation(
      email: 'ibrahim@gmail.com',
      firstName: 'angham',
      lastName: "kkk",
      dob: '1998',
      gender: 'M',
      phoneNumber: '+963144454545');
  Address address = Address(address: 'address', cityId: '10', postalCode: '965482');
  ProfileInfluencerModel profileInfluencerModel = ProfileInfluencerModel(
      generalInformation: generalInformation,
      id: '1',
      photoUrl: 'url',
      userStatus: 'active',
      address: address,
      completePercent: 20,
      facebookFollowers: 50,
      facebookUrl: 'https//',
      instagramFollowers: 50,
      instagramUrl: 'https//',
      snapchatFollowers: 50,
      snapchatUrl: 'https//',
      tiktokFollowers: 50,
      tiktokUrl: 'https//',
      twitterFollowers: 50,
      twitterUrl: 'https//',
      youtubeFollowers: 50,
      youtubeUrl: 'https//');
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
  HttpError error = const HttpError(message: ['Http error']);
  test('Success Social Data usecase', () async {
    when(profileRepository?.update_social_media_data(params: params)).thenAnswer((_) async => RemoteResult(
          data: profileInfluencerModel,
        ));
    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, profileInfluencerModel);
    verify(useCase?.call(params: params));
  });
  test('fail Social Data usecase', () async {
    when(profileRepository!.update_social_media_data(params: params))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
