import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateServiceParams extends BaseParams {
  UpdateServiceParams(
      {this.id, this.name, this.description, this.price, this.images, this.videos, this.categoryId, this.type});
  String? id;
  String? name;
  String? description;
  double? price;
  List<String>? images;
  List<String>? videos;
  String? categoryId;
  int? type;

  toJson() {
    return {
      // "id": id,
      "name": name?.trim() ?? " ",
      "description": description?.trim() ?? " ",
      "price": price ?? " ",
      "images": images ?? [],
      "videos": videos ?? [] /*files?.where((element) => element.type == 2).toList()*/,
      "categoryId": categoryId,
    };
  }
}

class UpdateServiceUseCase extends UseCase<AddService, UpdateServiceParams> {
  final AddSectionRepostory repository;

  UpdateServiceUseCase(this.repository);

  @override
  Future<Result<AddService>> call({required UpdateServiceParams params}) {
    return repository.updateService(params: params);
  }
}
