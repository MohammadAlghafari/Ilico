import 'package:charja_charity/features/profile/data/model/sp_general_information_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SPGeneralInformationParams extends BaseParams {
  final String id;
  final double latitude;
  final double longitude;
  final String query;
  SPGeneralInformationParams({required this.id, required this.query, required this.latitude, required this.longitude})
      : super(query: query);
  Map<String, dynamic> toJson() {
    return {
      "getProfileDto": {"latitude": latitude, "longitude": longitude, "serviceProviderId": id}
    };
  }
}

class SPGeneralInformationUseCase extends UseCase<SPGeneralInformationModel, SPGeneralInformationParams> {
  final ProfileRepository repository;

  SPGeneralInformationUseCase(this.repository);

  @override
  Future<Result<SPGeneralInformationModel>> call({required SPGeneralInformationParams params}) {
    return repository.get_ServiceProviderByID(params: params);
  }
}
