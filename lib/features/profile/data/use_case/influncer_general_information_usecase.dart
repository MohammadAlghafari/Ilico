import 'package:charja_charity/features/profile/data/model/influncer_general_information_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class InfluncerGeneralInformationParams extends BaseParams {
  final String id;
  final String query;
  InfluncerGeneralInformationParams({required this.id, required this.query}) : super(query: query);
  Map<String, dynamic> toJson() {
    return {
      "getInfluencerProfileDto": {"serviceProviderId": id}
    };
  }
}

class InfluncerGeneralInformationUseCase
    extends UseCase<InfluncerGeneralInformationModel, InfluncerGeneralInformationParams> {
  final ProfileRepository repository;

  InfluncerGeneralInformationUseCase(this.repository);

  @override
  Future<Result<InfluncerGeneralInformationModel>> call({required InfluncerGeneralInformationParams params}) {
    return repository.get_InfluncerById(params: params);
  }
}
