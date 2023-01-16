import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_product_model.dart';
import '../profile_repository/profile_repository.dart';

class GetProductParams extends BaseParams {
  GetProductParams({required this.request, required this.type});
  final GetListRequest request;
  final String type; //getService,getProduct,getEvent//

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(request.toJson());

    return data;
  }
}

class GetProductUseCase extends UseCase<List<GetproductModel>, GetProductParams> {
  final ProfileRepository profileRepostory;

  GetProductUseCase(this.profileRepostory);

  @override
  Future<Result<List<GetproductModel>>> call({required GetProductParams params}) {
    return profileRepostory.getProduct(params: params);
  }
}
