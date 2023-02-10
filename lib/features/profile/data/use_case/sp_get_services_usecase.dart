import 'package:charja_charity/features/profile/data/model/SPServiceModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SPGetServicesParams extends BaseParams {
  final String id;
  final double latitude;
  final double longitude;
  final String query;
  SPGetServicesParams({required this.id, required this.query,required this.longitude,required this.latitude}) : super(query: query);
  toJson() {
    return {
      "getProfileDto": {"latitude": latitude, "longitude": longitude, "serviceProviderId": id}
    };
  }
}

class SPGetServicesUseCase extends UseCase<SPService, SPGetServicesParams> {
  final ProfileRepository repository;

  SPGetServicesUseCase(this.repository);

  @override
  Future<Result<SPService>> call({required SPGetServicesParams params}) {
    return repository.getServicesById(params: params);
  }
}
