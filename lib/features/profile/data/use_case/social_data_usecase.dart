import 'dart:core';

import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/profile_model.dart';

class SocialDataParams extends BaseParams {
  String facebookUrl;
  int facebookFollowers;
  String instagramUrl;
  int instagramFollowers;
  String tiktokUrl;
  int tiktokFollowers;
  String youtubeUrl;
  int youtubeFollowers;
  String twitterUrl;
  int twitterFollowers;
  String snapchatUrl;
  int snapchatFollowers;

  SocialDataParams(
      {required this.facebookUrl,
      required this.facebookFollowers,
      required this.instagramUrl,
      required this.instagramFollowers,
      required this.tiktokUrl,
      required this.tiktokFollowers,
      required this.youtubeUrl,
      required this.youtubeFollowers,
      required this.twitterUrl,
      required this.twitterFollowers,
      required this.snapchatUrl,
      required this.snapchatFollowers});
  toJson() {
    return {
      "facebookUrl": facebookUrl.trim(),
      "facebookFollowers": facebookFollowers,
      "instagramUrl": instagramUrl.trim(),
      "instagramFollowers": instagramFollowers,
      "tiktokUrl": tiktokUrl.trim(),
      "tiktokFollowers": tiktokFollowers,
      "youtubeUrl": youtubeUrl.trim(),
      "youtubeFollowers": youtubeFollowers,
      "twitterUrl": twitterUrl.trim(),
      "twitterFollowers": twitterFollowers,
      "snapchatUrl": snapchatUrl.trim(),
      "snapchatFollowers": snapchatFollowers
    };
  }
}

class SocialDataUseCase extends UseCase<UserInfo, SocialDataParams> {
  final ProfileRepository repository;

  SocialDataUseCase(this.repository);

  @override
  Future<Result<UserInfo>> call({required SocialDataParams params}) {
    return repository.update_social_media_data(params: params);
  }
}
