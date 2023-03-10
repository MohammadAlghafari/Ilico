import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/login_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class GetUserInfoParams extends BaseParams {
  String phoneNumber;
  int otpCode;
  GetUserInfoParams({required this.phoneNumber, required this.otpCode}) : super(query: verifyUserQuery);

  Map<String, dynamic> toJson() {
    return {
      "VerifyUserDto": {'phoneNumber': phoneNumber.trim(), 'otpCode': otpCode}
    };
  }
}

class UserInfoUseCase extends UseCase<LoginModel, GetUserInfoParams> {
  final AuthRepository repository;

  UserInfoUseCase({required this.repository});

  @override
  Future<Result<LoginModel>> call({required GetUserInfoParams params}) {
    return repository.getUserInfo(params: params);
  }
}
