import 'package:charja_charity/features/user_managment/data/model/login_model.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class GetLoginParams extends BaseParams {
  String email;
  String password;
  GetLoginParams({required this.email, required this.password});
}

class GetLoginUseCase extends UseCase<LoginModel, GetLoginParams> {
  final AuthRepository;

  GetLoginUseCase(this.AuthRepository);

  @override
  Future<Result<LoginModel>> call({required GetLoginParams params}) {
    return AuthRepository.getLogin(params: params);
  }
}
