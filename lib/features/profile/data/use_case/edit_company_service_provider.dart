import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/profile_model.dart';
import '../profile_repository/profile_repository.dart';

class EditCompanyProfileParams extends BaseParams {
  EditCompanyProfileParams({this.name, this.description, this.iban, this.phoneNumber, this.job, this.sirenNumber});

  final String? phoneNumber;
  final String? name;
  final String? description;
  final String? job;
  final String? iban;
  final String? sirenNumber;

  toJson() {
    return {
      "name": name?.trim(),
      "phoneNumber": phoneNumber?.trim(),
      "description": description?.trim(),
      "job": job?.trim(),
      "iban": iban?.trim(),
      "sirenNumber": sirenNumber?.trim(),
    };
  }
}

class EditCompanyProfileUseCase extends UseCase<Company, EditCompanyProfileParams> {
  final ProfileRepository repository;

  EditCompanyProfileUseCase(this.repository);

  @override
  Future<Result<Company>> call({required EditCompanyProfileParams params}) {
    return repository.editCompany(params: params);
  }
}
