import 'package:charja_charity/features/profile/data/model/profile_model.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../profile_repository/profile_repository.dart';

class EditProfileParams extends BaseParams {
  EditProfileParams(
      {this.firstName,
      this.lastName,
      this.photoUrl,
      this.address,
      this.postalCode,
      this.phoneNumber,
      this.email,
      this.cityId,
      this.dot,
      this.gender,
      this.passportNumber,
      this.country,
      this.state});

  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  String? photoUrl;
  final String? passportNumber;
  final String? address;
  final DateTime? dot;
  final String? cityId;
  final String? postalCode;
  final String? gender;
  final String? country;
  final String? state;

  toJson() {
    Map<String, dynamic> queryParams = {};
    if (firstName != null) {
      queryParams.putIfAbsent("firstName", () => firstName?.trim());
    }
    if (lastName != null) {
      queryParams.putIfAbsent("lastName", () => lastName?.trim());
    }
    if (phoneNumber != null) {
      queryParams.putIfAbsent("phoneNumber", () => phoneNumber?.trim());
    }
    if (email != null) {
      queryParams.putIfAbsent("email", () => email?.trim());
    }
    if (passportNumber != null) {
      queryParams.putIfAbsent("passportNumber", () => passportNumber?.trim());
    }
    if (address != null) {
      queryParams.putIfAbsent("address", () => address?.trim());
    }
    if (dot != null) {
      queryParams.putIfAbsent("dot", () => dot);
    }
    if (cityId != null) {
      queryParams.putIfAbsent("cityId", () => cityId?.trim());
    }
    if (postalCode != null) {
      queryParams.putIfAbsent("postalCode", () => postalCode?.trim());
    }
    if (gender != null) {
      queryParams.putIfAbsent("gender", () => gender?.trim());
    }
    if (photoUrl != null) {
      queryParams.putIfAbsent("photoUrl", () => photoUrl);
    }
    if (country != null) {
      queryParams.putIfAbsent("country", () => country?.trim());
    }
    if (state != null) {
      queryParams.putIfAbsent("state", () => state?.trim());
    }
    return queryParams;
  }
}

class EditProfileUseCase extends UseCase<UserInfo, EditProfileParams> {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);

  @override
  Future<Result<UserInfo>> call({required EditProfileParams params}) {
    return repository.editProfile(params: params);
  }
}
