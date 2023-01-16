import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class ResendOTPParams extends BaseParams {
  final String? email;
  ResendOTPParams({this.email});
  toJson() {
    return {
      "phoneNumber": email?.trim(),
    };
  }
}

class ResendOTPUseCase extends UseCase<bool, ResendOTPParams> {
  final AuthRepository repository;

  ResendOTPUseCase(this.repository);

  @override
  Future<Result<bool>> call({required ResendOTPParams params}) {
    return repository.ResendOTP(params: params);
  }
}
