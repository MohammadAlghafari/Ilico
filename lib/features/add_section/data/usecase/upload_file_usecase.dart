import 'dart:io';

import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class GetFileParams extends BaseParams {
  List<File> file;
  String type;
  GetFileParams({required this.file, required this.type});
}

class GetUploadFileUseCase extends UseCase<FileData, GetFileParams> {
  final AddSectionRepostory addSectionRepostory;

  GetUploadFileUseCase(this.addSectionRepostory);

  @override
  Future<Result<FileData>> call({required GetFileParams params}) {
    return addSectionRepostory.uploadFiles(params: params);
  }
}
