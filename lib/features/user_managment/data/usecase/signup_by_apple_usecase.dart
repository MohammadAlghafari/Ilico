import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/user_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class SignUpByAppleParams extends BaseParams {
  SignUpByAppleParams(
      {this.phone,
      this.email,
      this.isFromLogin,
      this.firstName,
      this.lastName,
      this.roleKey,
      this.photoUrl,
      this.appleProfileId,
      this.isCustomer})
      : super(query: signupUserByApple);

  final String? phone;
  final String? email;
  final String? appleProfileId;
  final String? firstName;
  final String? lastName;
  final String? roleKey;
  final String? photoUrl;
  final bool? isCustomer;

  final bool? isFromLogin;

  toJson() {
    return {
      "signupUserApple": {
        "photoUrl": photoUrl,
        "appleProfileId": appleProfileId,
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

class SignUpByAppleUseCase extends UseCase<UserModel, SignUpByAppleParams> {
  final AuthRepository repository;

  SignUpByAppleUseCase(this.repository);

  @override
  Future<Result<UserModel>> call({required SignUpByAppleParams params}) {
    return repository.signUpByApple(params: params);
  }
}
