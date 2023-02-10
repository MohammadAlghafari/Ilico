import 'package:charja_charity/features/profile/data/model/SPEventModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SPGetEventParams extends BaseParams {
  final String id;
  final double latitude;
  final double longitude;
  final String query;
  SPGetEventParams({required this.id, required this.query, required this.latitude, required this.longitude})
      : super(query: query);
  toJson() {
    return {
      "getProfileDto": {"latitude": latitude, "longitude": longitude, "serviceProviderId": id}
    };
  }
}

class SPGetEventUseCase extends UseCase<SPEvent, SPGetEventParams> {
  final ProfileRepository repository;

  SPGetEventUseCase(this.repository);

  @override
  Future<Result<SPEvent>> call({required SPGetEventParams params}) {
    return repository.getEventById(params: params);
  }
}
