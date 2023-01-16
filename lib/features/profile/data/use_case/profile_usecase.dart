import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class ProfileParams extends BaseParams {
  ProfileParams() : super(query: """{
  products(first: 5, channel: "default-channel") {
    edges {
      node {
        id
        name
        description
      }
    }
  }
}""");
}

class ProfileUseCase extends UseCase<UserInfo, ProfileParams> {
  final ProfileRepository profileRepository;

  ProfileUseCase(this.profileRepository);

  @override
  Future<Result<UserInfo>> call({required ProfileParams params}) {
    return profileRepository.getProfile(params: params);
  }
}
