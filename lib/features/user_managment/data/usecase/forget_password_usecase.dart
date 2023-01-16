import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class ForgetPasswordParams extends BaseParams {
  String email;
  ForgetPasswordParams({required this.email});
}

class ForgetPasswordUseCase extends UseCase<bool, ForgetPasswordParams> {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Result<bool>> call({required ForgetPasswordParams params}) {
    return repository.forgetPassword(params: params);
  }
}
