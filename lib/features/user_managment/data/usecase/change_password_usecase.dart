import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class ChangePasswordParams extends BaseParams {
  final String? email;
  final int? otpCode;
  final String? newPassword;
  final String? confirmNewPassword;
  ChangePasswordParams({this.email, this.otpCode, this.newPassword, this.confirmNewPassword});
  toJson() {
    return {
      "email": email?.trim(),
      "otpCode": otpCode,
      "newPassword": newPassword?.trim(),
      "confirmNewPassword": confirmNewPassword?.trim()
    };
  }
}

class ChangePasswordUseCase extends UseCase<bool, ChangePasswordParams> {
  final AuthRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Result<bool>> call({required ChangePasswordParams params}) {
    return repository.ChangePassword(params: params);
  }
}
