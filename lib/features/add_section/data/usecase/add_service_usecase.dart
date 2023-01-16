import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/file_data.dart';

class AddServiceParams extends BaseParams {
  AddServiceParams({this.name, this.description, this.price, this.files, this.categoryId, this.type});

  String? name;
  String? description;
  double? price;
  FileData? files;
  String? categoryId;
  int? type;

  toJson() {
    return {
      "name": name?.trim() ?? " ",
      "description": description?.trim() ?? " ",
      "price": price ?? " ",
      "images": files?.data?.map((e) => e.url).toList() ?? [] /*?.where((element) => element.type == 1).toList()*/,
      "videos": [] /*files?.where((element) => element.type == 2).toList()*/,
      "categoryId": categoryId,
    };
  }
}

class AddServiceUseCase extends UseCase<AddService, AddServiceParams> {
  final AddSectionRepostory repository;

  AddServiceUseCase(this.repository);

  @override
  Future<Result<AddService>> call({required AddServiceParams params}) {
    return repository.addService(params: params);
  }
}
