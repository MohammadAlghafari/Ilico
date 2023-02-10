import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/model/add_media_model.dart';
import 'package:charja_charity/features/add_section/data/model/deleteEventModel.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_media_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_service_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/base_error.dart';
import '../../../core/results/result.dart';
import '../../../core/utils/image_helper.dart';
import '../data/model/get_article_model.dart';
import '../data/usecase/add_article_usecase.dart';
import '../data/usecase/add_event_usecase.dart';
import '../data/usecase/delete_article_usecase.dart';
import '../data/usecase/edit_article.dart';
import '../data/usecase/update_event_usecase.dart';
import '../data/usecase/update_service_usecase.dart';
import '../data/usecase/upload_file_usecase.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());
  static AddServiceCubit get(context) => BlocProvider.of(context);

  Future<void> addService({required GetFileParams params, required AddServiceParams addServiceParams}) async {
    emit(AddServiceLoading());
    Result<FileData> uploadResult;

    Result editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddServiceError(
            error: uploadResult.error,
            callback: () {
              addService(params: params, addServiceParams: addServiceParams);
            }));
        return Future.value();
      } else {
        List<String>? images = [];
        List<String>? videos = [];
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            videos.add(element.url!);
            print(element.url);
          } else {
            images.add(element.url!);
            print(element.url);
          }
        });
        addServiceParams.images = images;
        addServiceParams.videos = videos;
      }
    } else {
      addServiceParams.images = [];
      addServiceParams.videos = [];
    }

    editResult = await AddServiceUseCase(AddSectionRepostory()).call(params: addServiceParams);
    if (editResult.hasDataOnly) {
      emit(AddServiceLoaded(data: editResult.data));
    } else if (editResult.hasErrorOnly) {
      emit(AddServiceError(
          error: editResult.error,
          callback: () {
            addService(params: params, addServiceParams: addServiceParams);
          }));
    }
  }

  Future<void> updateService({required GetFileParams params, required UpdateServiceParams updateServiceParams}) async {
    emit(AddServiceLoading());
    Result<FileData> uploadResult;

    Result<AddService> editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddServiceError(
            error: uploadResult.error,
            callback: () {
              updateService(params: params, updateServiceParams: updateServiceParams);
            }));
        return Future.value();
      } else {
        List<String>? images = [];
        List<String>? videos = [];
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            videos.add(element.url!);
          } else {
            images.add(element.url!);
          }
        });
        images.addAll(updateServiceParams.images!);
        videos.addAll(updateServiceParams.videos!);
        updateServiceParams.images = images;
        updateServiceParams.videos = videos;
      }
    } /*else {
      updateServiceParams.images = images;
      updateServiceParams.videos = videos;
    }*/
    editResult = await UpdateServiceUseCase(AddSectionRepostory()).call(params: updateServiceParams);
    if (editResult.hasDataOnly) {
      emit(AddServiceLoaded(data: editResult.data!));
    } else if (editResult.hasErrorOnly) {
      emit(AddServiceError(
          error: editResult.error,
          callback: () {
            updateService(params: params, updateServiceParams: updateServiceParams);
          }));
    }
  }

  Future<void> addEvent({required GetFileParams params, required AddEventParams addEventParams}) async {
    emit(AddEventLoading());
    Result uploadResult;

    Result<AddEventModel> editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddEventError(
            error: uploadResult.error,
            callback: () {
              addEvent(params: params, addEventParams: addEventParams);
            }));
        return Future.value();
      } else {
        List<String>? images = [];
        List<String>? videos = [];
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            videos.add(element.url!);
            print(element.url);
          } else {
            images.add(element.url!);
            print(element.url);
          }
        });
        addEventParams.images = images;
        addEventParams.videos = videos;
      }
    } else {
      addEventParams.images = [];
      addEventParams.videos = [];
    }
    editResult = await AddEventUseCase(AddSectionRepostory()).call(params: addEventParams);
    if (editResult.hasDataOnly) {
      emit(AddEventLoaded(data: editResult.data!));
    } else if (editResult.hasErrorOnly) {
      emit(AddEventError(
          error: editResult.error,
          callback: () {
            addEvent(params: params, addEventParams: addEventParams);
          }));
    }
  }

  Future<void> updateEvent({required GetFileParams params, required UpdateEventParams updateEventParams}) async {
    emit(AddEventLoading());
    Result<FileData> uploadResult;

    Result<AddEventModel> editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddEventError(
            error: uploadResult.error,
            callback: () {
              updateEvent(params: params, updateEventParams: updateEventParams);
            }));
        return Future.value();
      } else {
        List<String>? images = [];
        List<String>? videos = [];
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            videos.add(element.url!);
          } else {
            images.add(element.url!);
          }
        });
        images.addAll(updateEventParams.images!);
        videos.addAll(updateEventParams.videos!);
        updateEventParams.images = images;
        updateEventParams.videos = videos;
      }
    } /*else {
      updateEventParams.images = [];
      updateEventParams.videos = [];
    }*/
    editResult = await UpdateEventUseCase(AddSectionRepostory()).call(params: updateEventParams);
    if (editResult.hasDataOnly) {
      emit(AddEventLoaded(data: editResult.data!));
    } else if (editResult.hasErrorOnly) {
      emit(AddEventError(
          error: editResult.error,
          callback: () {
            updateEvent(params: params, updateEventParams: updateEventParams);
          }));
    }
  }

  Future<void> deleteEvent({required DeleteEventParams deleteEventParams}) async {
    emit(DeleteEventLoading());
    Result<DeleteEventModel> result;

    result = await DeleteEventUseCase(AddSectionRepostory()).call(params: deleteEventParams);
    if (result.hasDataOnly) {
      emit(DeleteEventLoaded());
    } else if (result.hasErrorOnly) {
      emit(DeleteEventError(
          error: result.error,
          callback: () {
            deleteEvent(deleteEventParams: deleteEventParams);
          }));
    }
  }

  Future<void> deleteServiceOrProduct({required DeleteServiceProductParams deleteServiceProductParams}) async {
    emit(DeleteServiceOrProductLoading());
    Result<bool> result;

    result = await DeleteServiceProductUseCase(AddSectionRepostory()).call(params: deleteServiceProductParams);
    if (result.hasDataOnly) {
      emit(DeleteServiceOrProductLoaded());
    } else if (result.hasErrorOnly) {
      emit(DeleteServiceOrProductError(
          error: result.error,
          callback: () {
            deleteServiceOrProduct(
              deleteServiceProductParams: deleteServiceProductParams,
            );
          }));
    }
  }

  Future<void> createArticle({required GetFileParams params, required AddArticleParams addArticleParams}) async {
    emit(CreateArticleLoading());
    Result<FileData> uploadResult;
    Result editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(CreateArticleError(
            error: uploadResult.error,
            callback: () {
              createArticle(params: params, addArticleParams: addArticleParams);
            }));
        return Future.value();
      } else {
        List<String>? images = [];
        List<String>? videos = [];
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            videos.add(element.url!);
            print(element.url);
          } else {
            images.add(element.url!);
            print(element.url);
          }
        });
        addArticleParams.images = images;
        addArticleParams.videos = videos;
      }
    } else {
      addArticleParams.images = [];
      addArticleParams.videos = [];
    }

    editResult = await AddArticleUseCase(AddSectionRepostory()).call(params: addArticleParams);
    if (editResult.hasDataOnly) {
      emit(CreateArticleLoaded(data: editResult.data));
    } else if (editResult.hasErrorOnly) {
      emit(CreateArticleError(
          error: editResult.error,
          callback: () {
            createArticle(params: params, addArticleParams: addArticleParams);
          }));
    }
  }

  Future<void> editArticle({required GetFileParams params, required EditArticleParams editArticleParams}) async {
    emit(CreateArticleLoading());
    Result<FileData> uploadResult;

    Result<CreateArticle> editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddEventError(
            error: uploadResult.error,
            callback: () {
              editArticle(params: params, editArticleParams: editArticleParams);
            }));
        return Future.value();
      } else {
        List<String>? images = [];
        List<String>? videos = [];
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            videos.add(element.url!);
          } else {
            images.add(element.url!);
          }
        });
        images.addAll(editArticleParams.images!);
        videos.addAll(editArticleParams.videos!);
        editArticleParams.images = images;
        editArticleParams.videos = videos;
      }
    }
    editResult = await EditArticleUseCase(AddSectionRepostory()).call(params: editArticleParams);
    if (editResult.hasDataOnly) {
      emit(CreateArticleLoaded(data: editResult.data!));
    } else if (editResult.hasErrorOnly) {
      emit(CreateArticleError(
          error: editResult.error,
          callback: () {
            editArticle(params: params, editArticleParams: editArticleParams);
          }));
    }
  }

  Future<void> deleteArticle({required DeleteArticleParams deleteArticleParams}) async {
    emit(DeleteArticleLoading());
    final result = await DeleteArticleUseCase(AddSectionRepostory()).call(params: deleteArticleParams);
    if (result.hasDataOnly) {
      emit(DeleteArticleLoaded(data: result.data!));
    } else if (result.hasErrorOnly) {
      emit(DeleteArticleError(
          error: result.error,
          callback: () {
            deleteArticle(deleteArticleParams: deleteArticleParams);
          }));
    }
  }

  Future<void> addMedia({required GetFileParams params, required AddMediaParams addMediaParams}) async {
    emit(AddMediaLoading());
    Result<FileData> uploadResult;
    String? media, type;

    Result<AddMediaModel> editResult;
    if (params.file != null && params.file.isNotEmpty) {
      uploadResult = await GetUploadFileUseCase(AddSectionRepostory()).call(params: params);
      if (uploadResult.hasErrorOnly) {
        emit(AddMediaError(
            error: uploadResult.error,
            callback: () {
              addMedia(params: params, addMediaParams: addMediaParams);
            }));
        return Future.value();
      } else {
        uploadResult.data!.data!.forEach((element) {
          if (ImageHelper.isVideo(element.url!)) {
            media = element.url;
            type = "Video";
          } else if (ImageHelper.isImage(element.url!)) {
            media = element.url;
            type = "Image";
          }
        });
        addMediaParams.media = media;
        addMediaParams.type = type;
      }
    }
    editResult = await AddMediaUseCase(AddSectionRepostory()).call(params: addMediaParams);
    if (editResult.hasDataOnly) {
      emit(AddMediaLoaded(data: editResult.data!));
    } else if (editResult.hasErrorOnly) {
      emit(AddMediaError(
          error: editResult.error,
          callback: () {
            addMedia(params: params, addMediaParams: addMediaParams);
          }));
    }
  }
}
