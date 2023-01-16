import 'package:charja_charity/features/profile/data/model/profile_model.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class AssignCategoryParams extends BaseParams {
  AssignCategoryParams({required this.categoriesIds});
  List<String?> categoriesIds;

  toJson() {
    return {"categoriesIds": categoriesIds};
  }
}

class AssignCategoryUseCase extends UseCase<UserInfo, AssignCategoryParams> {
  final AuthRepository;

  AssignCategoryUseCase(this.AuthRepository);

  @override
  Future<Result<UserInfo>> call({required AssignCategoryParams params}) {
    return AuthRepository.assignCategory(params: params);
  }
}
