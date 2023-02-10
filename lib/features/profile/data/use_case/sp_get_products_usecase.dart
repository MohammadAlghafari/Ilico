import 'package:charja_charity/features/profile/data/model/SPProductsModel.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class SPGetProductsParams extends BaseParams {
  final String id;
  final double latitude;
  final double longitude;
  final String query;
  SPGetProductsParams({required this.id, required this.query, required this.latitude, required this.longitude})
      : super(query: query);
  toJson() {
    return {
      "getProfileDto": {"latitude": latitude, "longitude": longitude, "serviceProviderId": id}
    };
  }
}

class SPGetProductsUseCase extends UseCase<SPProduct, SPGetProductsParams> {
  final ProfileRepository repository;

  SPGetProductsUseCase(this.repository);

  @override
  Future<Result<SPProduct>> call({required SPGetProductsParams params}) {
    return repository.getProductsById(params: params);
  }
}
