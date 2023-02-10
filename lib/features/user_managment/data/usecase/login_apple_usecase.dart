import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/login_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class LoginWithAppleParams extends BaseParams {
  LoginWithAppleParams({this.appleProfileId, this.email}) : super(query: appleLogin);
  final String? email;
  final String? appleProfileId;

  toJson() {
    return {
      "auth": {"email": email, "appleProfileId": appleProfileId}
    };
  }
}

class LoginWithAppleUseCase extends UseCase<LoginModel, LoginWithAppleParams> {
  final AuthRepository authRepository;

  LoginWithAppleUseCase(this.authRepository);

  @override
  Future<Result<LoginModel>> call({required LoginWithAppleParams params}) {
    return authRepository.loginWithApple(params: params);
  }
}
