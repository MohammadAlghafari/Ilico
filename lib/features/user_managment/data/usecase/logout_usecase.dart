import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/logout_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class LogOutParams extends BaseParams {
  LogOutParams() : super(query: logoutQuery);
}

class LogOutUseCase extends UseCase<LogOutModel, LogOutParams> {
  final AuthRepository repository;

  LogOutUseCase(this.repository);

  @override
  Future<Result<LogOutModel>> call({required LogOutParams params}) {
    return repository.LogOut(params: params);
  }
}
