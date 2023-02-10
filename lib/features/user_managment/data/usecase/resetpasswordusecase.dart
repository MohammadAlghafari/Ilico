import 'package:charja_charity/features/user_managment/data/model/resetPasswordModel.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../queries.dart';

class ResetPasswordParams extends BaseParams {
  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;
  ResetPasswordParams({this.oldPassword, this.newPassword, this.confirmNewPassword})
      : super(query: changePasswordQuery);
  toJson() {
    return {
      "resetMyPasswordDto": {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword
      }
    };
  }
}

class ResetPasswordUseCase extends UseCase<ResetPasswordModel, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  @override
  Future<Result<ResetPasswordModel>> call({required ResetPasswordParams params}) {
    return repository.changePassword(params: params);
  }
}
