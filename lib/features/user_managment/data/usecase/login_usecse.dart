import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:charja_charity/features/user_managment/data/queries.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class GetLoginParams extends BaseParams {
  String email;
  String password;
  GetLoginParams({required this.email, required this.password}) : super(query: loginUserQuery);

  Map<String, dynamic> toJson() {
    return {
      "auth": {
        "email": email.trim(),
        "password": password.trim(),
      }
    };
  }
}

class GetLoginUseCase extends UseCase<LoginModel, GetLoginParams> {
  final AuthRepository repository;

  GetLoginUseCase(this.repository);

  @override
  Future<Result<LoginModel>> call({required GetLoginParams params}) {
    return repository.getLogin(params: params);
  }
}
