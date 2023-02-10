import 'package:charja_charity/features/add_section/data/model/new_service.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/add_section_repostory.dart';

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

class GetProductUseCase extends UseCase<List<AddService>, GetProductParams> {
  final AddSectionRepostory profileRepostory;

  GetProductUseCase(this.profileRepostory);

  @override
  Future<Result<List<AddService>>> call({required GetProductParams params}) {
    return profileRepostory.getProduct(params: params);
  }
}
