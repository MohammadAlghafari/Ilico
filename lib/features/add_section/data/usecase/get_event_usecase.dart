import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/queries.dart';

import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/add_section_repostory.dart';

class GetEventParams extends BaseParams {
  final GetListRequest request;
  final String type; //getService,getProduct,getEvent//
  GetEventParams({required this.request, required this.type}) : super(query: getEventQueries);
  Map<String, dynamic> toJson() {
    return {
      "pageOptionsDto": request.toJson(),
    };
  }
}

class GetEventUseCase extends UseCase<List<AddEventModel>, GetEventParams> {
  final AddSectionRepostory repository;

  GetEventUseCase(this.repository);

  @override
  Future<Result<List<AddEventModel>>> call({required GetEventParams params}) {
    return repository.getEvent(params: params);
  }
}
