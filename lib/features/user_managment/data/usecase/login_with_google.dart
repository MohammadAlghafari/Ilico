import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/login_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class GetLoginWithGoogleParams extends BaseParams {
  GetLoginWithGoogleParams({this.googleProfileId, this.email}) : super(query: googleLogin);
  final String? email;
  final String? googleProfileId;

  toJson() {
    return {
      "auth": {"email": email, "googleProfileId": googleProfileId}
    };
  }
}

class GetLoginWithGoogleUseCase extends UseCase<LoginModel, GetLoginWithGoogleParams> {
  final AuthRepository authRepository;

  GetLoginWithGoogleUseCase(this.authRepository);

  @override
  Future<Result<LoginModel>> call({required GetLoginWithGoogleParams params}) {
    return authRepository.loginWithGoogle(params: params);
  }
}
