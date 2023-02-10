import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/login_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class GetLoginWithFacebookParams extends BaseParams {
  GetLoginWithFacebookParams({this.facebookProfileId, this.email}) : super(query: facebookLogin);
  final String? email;
  final String? facebookProfileId;

  toJson() {
    return {
      "auth": {"email": email, "facebookProfileId": facebookProfileId}
    };
  }
}

class GetLoginWithFacebookUseCase extends UseCase<LoginModel, GetLoginWithFacebookParams> {
  final AuthRepository authRepository;

  GetLoginWithFacebookUseCase(this.authRepository);

  @override
  Future<Result<LoginModel>> call({required GetLoginWithFacebookParams params}) {
    return authRepository.loginWithFacebook(params: params);
  }
}
