import 'package:charja_charity/features/profile/data/model/SPArticleModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class InfluncerGetArticleParams extends BaseParams {
  final String id;
  final String query;
  InfluncerGetArticleParams({required this.id, required this.query}) : super(query: query);
  toJson() {
    return {
      "getInfluencerProfileDto": {"serviceProviderId": id}
    };
  }
}

class InfluncerGetArticleUseCase extends UseCase<SPArticleModel, InfluncerGetArticleParams> {
  final ProfileRepository repository;

  InfluncerGetArticleUseCase(this.repository);

  @override
  Future<Result<SPArticleModel>> call({required InfluncerGetArticleParams params}) {
    return repository.getInfluncerArticleByID(params: params);
  }
}
