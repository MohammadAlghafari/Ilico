import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

class SignUpParams extends BaseParams {
  SignUpParams(
      {this.phone,
      this.email,
      this.firstName,
      this.lastName,
      this.roleKey,
      this.password,
      this.isCustomer});

  final String? phone;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? roleKey;
  final String? password;
  final bool? isCustomer;

  toJson() {
    return {
      "roleKey": roleKey?.trim(),
      "firstName": firstName?.trim(),
      "lastName": lastName?.trim(),
      "phoneNumber": phone?.trim(),
      "email": email?.trim(),
      "password": password?.trim(),
      "isCustomer": isCustomer
    };
  }
}

class SignUpUseCase extends UseCase<UserModel, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Result<UserModel>> call({required SignUpParams params}) {
    return repository.signUp(params: params);
  }
}
