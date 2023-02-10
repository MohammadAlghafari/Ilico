import 'package:charja_charity/features/profile/data/model/delete_account_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/queries.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteAccountParams extends BaseParams {
  String? password;
  DeleteAccountParams({this.password}) : super(query: deleteAccountQueries);

  toJson() {
    return {
      "deleteMyAccountDto": {"password": password}
    };
  }
}

class DeleteAccountUseCase extends UseCase<DeleteAccountModel, DeleteAccountParams> {
  final ProfileRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Result<DeleteAccountModel>> call({required DeleteAccountParams params}) {
    return repository.deleteAccount(params: params);
  }
}
