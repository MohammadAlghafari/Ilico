import 'package:charja_charity/features/search/data/repository/search_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/storeLocationModel.dart';
import '../queries.dart';

class StoreLocationParams extends BaseParams {
  double? latitude;
  double? longitude;
  StoreLocationParams({this.latitude, this.longitude}) : super(query: storeLocationQueries);
  toJson() {
    return {
      "updateUserLocation": {"longitude": longitude, "latitude": latitude}
    };
  }
}

class StoreLocationUseCase extends UseCase<StoreLocation, StoreLocationParams> {
  final SearchRepository repository;

  StoreLocationUseCase(this.repository);

  @override
  Future<Result<StoreLocation>> call({required StoreLocationParams params}) {
    return repository.storeLocation(params: params);
  }
}
