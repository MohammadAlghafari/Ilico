import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/user_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class SignUpByGoogleParams extends BaseParams {
  SignUpByGoogleParams(
      {this.phone,
      this.email,
      this.isFromLogin,
      this.firstName,
      this.lastName,
      this.roleKey,
      this.photoUrl,
      this.googleProfileId,
      this.isCustomer})
      : super(query: signupUserByGoogle);

  final String? phone;
  final String? email;
  final String? googleProfileId;
  final String? firstName;
  final String? lastName;
  final String? roleKey;
  final String? photoUrl;
  final bool? isCustomer;

  final bool? isFromLogin;

  toJson() {
    return {
      "signupUserGoogle": {
        "photoUrl": photoUrl,
        "googleProfileId": googleProfileId,
        "roleKey": roleKey,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phone?.trim(),
        "email": email,
        "isCustomer": isCustomer
      }
    };
  }
}

class SignUpByGoogleUseCase extends UseCase<UserModel, SignUpByGoogleParams> {
  final AuthRepository repository;

  SignUpByGoogleUseCase(this.repository);

  @override
  Future<Result<UserModel>> call({required SignUpByGoogleParams params}) {
    return repository.signUpByGoogle(params: params);
  }
}
