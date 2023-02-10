import 'dart:io';

import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart';
import 'package:charja_charity/features/add_section/data/model/deleteEventModel.dart';
import 'package:charja_charity/features/add_section/data/model/file_data.dart';
import 'package:charja_charity/features/add_section/data/model/get_product_model.dart';
import 'package:charja_charity/features/add_section/data/model/new_service.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_service_product_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/get_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/get_product_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/update_event_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/update_service_usecase.dart';
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../usecase/add_event_usecase_test.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  AddSectionRepostory? addSectionRepository;
  setUp(() {
    addSectionRepository = MockAddSectionRepostory();
  });

  HttpError error = const HttpError(message: ['Http error']);
  Data data = Data(url: "url", key: "key");
  List<Data> dataList = [data, data];
  FileData filedata = FileData(data: dataList);
  List<File> file = [File("test"), File("test")];
  AddServiceParams params = AddServiceParams(name: "test", description: "test", categoryId: "test", price: 10.5);
  UpdateServiceParams updateServiceParams = UpdateServiceParams(
    id: "f8e30c6e-a3b5-4acb-8607-a01e499dc8f8",
    name: "test",
    description: "test",
    categoryId: "test",
    price: 10,
  );

  Category category = Category(name: "test", id: "sdsds", description: "sfafaf", isActive: true);
  AddService getproductModel =
      AddService(price: 10, category: category, description: "test", name: "test", images: ['url'], videos: ['url']);
  List<AddService> services = [getproductModel, getproductModel, getproductModel];
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  GetProductParams getProductParams = GetProductParams(request: request, type: 'getService');

  AddService addService = AddService(
    //  id: "1231321313",
    price: 10,
    category: category,
    description: "test",
    name: "test",
    /* images: ['url'],
      videos: ['url']*/
  );

  AddEventModel addEventModel = AddEventModel(
      id: "12313",
      startDate: "2023-10-03",
      endDate: "2023-01-03",
      images: [],
      videos: [],
      name: "test",
      description: "test");
  AddEventParams addEventParams = AddEventParams(
      description: "test", name: "test", videos: [], images: [], startdate: "2023-01-03", enddate: "2023-10-03");
  UpdateEventParams updateEventParams = UpdateEventParams(
      startDate: "2023-01-03",
      endDate: "2023-01-03",
      images: [],
      videos: [],
      name: "test",
      description: "test",
      id: "test",
      type: 3);
  GetFileParams getFileParams = GetFileParams(file: file, type: 'test');
  GetEventParams getEventParams = GetEventParams(type: "string", request: request);
  AddEventModel getEventModel = AddEventModel(
      id: "131323",
      description: "sdsdsa",
      name: "sdssda",
      videos: [],
      images: [],
      startDate: "date",
      endDate: "2023-01-03");
  List<AddEventModel> events = [getEventModel, getEventModel, getEventModel];
  DeleteEventParams deleteEventParams = DeleteEventParams(id: "123123");
  DeleteEventModel deleteEventModel = DeleteEventModel(message: "test");
  DeleteServiceProductParams deleteServiceProductParams = DeleteServiceProductParams(id: "13456", type: 1);
  test('Success add service,product', () async {
    when(addSectionRepository?.addService(params: params)).thenAnswer((_) async => RemoteResult(
          data: addService,
        ));
    final result = await addSectionRepository!.addService(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, addService);
    verify(addSectionRepository?.addService(params: params));
  });
  test('fail add service,product', () async {
    when(addSectionRepository!.addService(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await addSectionRepository!.addService(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.addService(params: params));
  });
  test('Success upload file', () async {
    when(addSectionRepository?.uploadFiles(params: getFileParams)).thenAnswer((_) async => RemoteResult(
          data: filedata,
        ));
    final result = await addSectionRepository!.uploadFiles(params: getFileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, filedata);
    verify(addSectionRepository?.uploadFiles(params: getFileParams));
  });
  test('fail upload file', () async {
    when(addSectionRepository!.uploadFiles(params: getFileParams)).thenAnswer((_) async => RemoteResult(error: error));
    final result = await addSectionRepository!.uploadFiles(params: getFileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.uploadFiles(params: getFileParams));
  });
  test('Success update service,product', () async {
    when(addSectionRepository?.updateService(params: updateServiceParams)).thenAnswer((_) async => RemoteResult(
          data: addService,
        ));
    final result = await addSectionRepository!.updateService(params: updateServiceParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addService);
    verify(addSectionRepository?.updateService(params: updateServiceParams));
  });
  test('fail update service,product', () async {
    when(addSectionRepository!.updateService(params: updateServiceParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await addSectionRepository!.updateService(params: updateServiceParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.updateService(params: updateServiceParams));
  });

  test('Success get service,', () async {
    when(addSectionRepository?.getProduct(params: getProductParams)).thenAnswer((_) async => PaginatedResult(
          data: services,
        ));
    final result = await addSectionRepository!.getProduct(params: getProductParams);

    expect(result.hasDataOnly, true);
    expect(result.data, services);
    verify(addSectionRepository?.getProduct(params: getProductParams));
  });
  test('fail get service', () async {
    when(addSectionRepository?.getProduct(params: getProductParams))
        .thenAnswer((_) async => PaginatedResult(error: error));
    final result = await addSectionRepository!.getProduct(params: getProductParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.getProduct(params: getProductParams));
  });

  test('Success add event', () async {
    when(addSectionRepository?.addEvent(params: addEventParams)).thenAnswer((_) async => RemoteResult(
          data: addEventModel,
        ));
    final result = await addSectionRepository!.addEvent(params: addEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addEventModel);
    verify(addSectionRepository?.addEvent(params: addEventParams));
  });
  test('fail add event', () async {
    when(addSectionRepository!.addEvent(params: addEventParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await addSectionRepository!.addEvent(params: addEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.addEvent(params: addEventParams));
  });

  test('Success update event', () async {
    when(addSectionRepository?.updateEvent(params: updateEventParams)).thenAnswer((_) async => RemoteResult(
          data: addEventModel,
        ));
    final result = await addSectionRepository!.updateEvent(params: updateEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, addEventModel);
    verify(addSectionRepository?.updateEvent(params: updateEventParams));
  });
  test('fail update event', () async {
    when(addSectionRepository!.updateEvent(params: updateEventParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await addSectionRepository!.updateEvent(params: updateEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.updateEvent(params: updateEventParams));
  });

  test('Success get event,', () async {
    when(addSectionRepository?.getEvent(params: getEventParams)).thenAnswer((_) async => PaginatedResult(
          data: events,
        ));
    final result = await addSectionRepository!.getEvent(params: getEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, events);
    verify(addSectionRepository?.getEvent(params: getEventParams));
  });
  test('fail get event', () async {
    when(addSectionRepository?.getEvent(params: getEventParams)).thenAnswer((_) async => PaginatedResult(error: error));
    final result = await addSectionRepository!.getEvent(params: getEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.getEvent(params: getEventParams));
  });

  test('Success delete event', () async {
    when(addSectionRepository?.deleteEvent(params: deleteEventParams)).thenAnswer((_) async => RemoteResult(
          data: deleteEventModel,
        ));
    final result = await addSectionRepository!.deleteEvent(params: deleteEventParams);

    expect(result.hasDataOnly, true);
    expect(result.data, deleteEventModel);
    verify(addSectionRepository?.deleteEvent(params: deleteEventParams));
  });
  test('fail delete event', () async {
    when(addSectionRepository!.deleteEvent(params: deleteEventParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await addSectionRepository!.deleteEvent(params: deleteEventParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.deleteEvent(params: deleteEventParams));
  });
  test('Success delete service, products', () async {
    when(addSectionRepository?.deleteServiceOrProduct(params: deleteServiceProductParams))
        .thenAnswer((_) async => Result<bool>(
              data: true,
            ));
    final result = await addSectionRepository!.deleteServiceOrProduct(params: deleteServiceProductParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(addSectionRepository?.deleteServiceOrProduct(params: deleteServiceProductParams));
  });
  test('fail delete service, products', () async {
    when(addSectionRepository!.deleteServiceOrProduct(params: deleteServiceProductParams))
        .thenAnswer((_) async => Result<bool>(error: error));

    final result = await addSectionRepository!.deleteServiceOrProduct(params: deleteServiceProductParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(addSectionRepository!.deleteServiceOrProduct(params: deleteServiceProductParams));
  });
}
