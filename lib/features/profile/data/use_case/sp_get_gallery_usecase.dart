import 'package:charja_charity/features/profile/data/model/SpMediaModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SPGetGalleryParams extends BaseParams {
  final String id;
  final double longitude;
  final double latitude;
  final String query;

  SPGetGalleryParams({required this.longitude, required this.latitude, required this.id, required this.query})
      : super(query: query);

  toJson() {
    return {
      "getProfileDto": {
        "latitude": latitude,
        "longitude": longitude,
        "serviceProviderId": "bbf943b0-6d9d-4832-a52e-2eb130bfc13b"
      }
    };
  }
}

class SPGetGalleryUseCase extends UseCase<SPGallery, SPGetGalleryParams> {
  final ProfileRepository repository;

  SPGetGalleryUseCase(this.repository);

  @override
  Future<Result<SPGallery>> call({required SPGetGalleryParams params}) {
    return repository.getSPGalleryById(params: params);
  }
}
