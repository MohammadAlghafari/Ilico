import 'package:charja_charity/features/profile/data/model/SpMediaModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class InfluncerGetGalleryParams extends BaseParams {
  final String id;
  final String query;

  InfluncerGetGalleryParams({required this.id, required this.query}) : super(query: query);

  toJson() {
    return {
      "getInfluencerProfileDto": {"serviceProviderId": id}
    };
  }
}

class InfluncerGetGalleryUseCase extends UseCase<SPGallery, InfluncerGetGalleryParams> {
  final ProfileRepository repository;

  InfluncerGetGalleryUseCase(this.repository);

  @override
  Future<Result<SPGallery>> call({required InfluncerGetGalleryParams params}) {
    return repository.getInfluncerGalleryById(params: params);
  }
}
