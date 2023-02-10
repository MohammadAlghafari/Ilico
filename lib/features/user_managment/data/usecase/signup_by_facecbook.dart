import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/user_model.dart';
import '../queries.dart';
import '../repository/auth_repository.dart';

class SignUpByFacebookParams extends BaseParams {
  SignUpByFacebookParams(
      {this.phone,
      this.email,
      this.firstName,
      this.lastName,
      this.roleKey,
      this.photoUrl,
      this.facebookProfileId,
      this.isCustomer})
      : super(query: signupUserByFacebook);

  final String? phone;
  final String? email;
  final String? facebookProfileId;
  final String? firstName;
  final String? lastName;
  final String? roleKey;
  final String? photoUrl;
  final bool? isCustomer;

  toJson() {
    return {
      "signupUserFacebook": {
        "photoUrl": photoUrl,
        "facebookProfileId": facebookProfileId,
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

class SignUpByFacebookUseCase extends UseCase<UserModel, SignUpByFacebookParams> {
  final AuthRepository repository;

  SignUpByFacebookUseCase(this.repository);

  @override
  Future<Result<UserModel>> call({required SignUpByFacebookParams params}) {
    return repository.signUpByFacebook(params: params);
  }
}
