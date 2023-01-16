import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class LogOutParams extends BaseParams {
  LogOutParams();
}

class LogOutUseCase extends UseCase<bool, LogOutParams> {
  final AuthRepository repository;

  LogOutUseCase(this.repository);

  @override
  Future<Result<bool>> call({required LogOutParams params}) {
    return repository.LogOut(params: params);
  }
}
