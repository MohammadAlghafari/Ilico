import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class ForgetPasswordOtpParams extends BaseParams {
  final String? email;
  final int? otpCode;
  ForgetPasswordOtpParams({this.email, this.otpCode});
  toJson() {
    return {"email": email?.trim(), "otpCode": otpCode};
  }
}

class ForgetPasswordOtpUseCase extends UseCase<bool, ForgetPasswordOtpParams> {
  final AuthRepository repository;

  ForgetPasswordOtpUseCase({required this.repository});

  @override
  Future<Result<bool>> call({required ForgetPasswordOtpParams params}) {
    return repository.ForgetPasswordOtp(params: params);
  }
}
