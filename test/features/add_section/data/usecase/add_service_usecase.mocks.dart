// Mocks generated by Mockito 5.3.2 from annotations
// in charja_charity/test/features/add_section/data/usecase/add_service_usecase.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:charja_charity/core/data_source/model.dart' as _i29;
import 'package:charja_charity/core/errors/base_error.dart' as _i31;
import 'package:charja_charity/core/results/result.dart' as _i2;
import 'package:charja_charity/features/add_section/data/model/add_media_model.dart'
    as _i25;
import 'package:charja_charity/features/add_section/data/model/addEvent_model.dart'
    as _i11;
import 'package:charja_charity/features/add_section/data/model/deleteEventModel.dart'
    as _i14;
import 'package:charja_charity/features/add_section/data/model/file_data.dart'
    as _i5;
import 'package:charja_charity/features/add_section/data/model/get_article_model.dart'
    as _i17;
import 'package:charja_charity/features/add_section/data/model/new_service.dart'
    as _i7;
import 'package:charja_charity/features/add_section/data/model/search_article.dart'
    as _i19;
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart'
    as _i3;
import 'package:charja_charity/features/add_section/data/usecase/add_article_usecase.dart'
    as _i21;
import 'package:charja_charity/features/add_section/data/usecase/add_event_usecase.dart'
    as _i12;
import 'package:charja_charity/features/add_section/data/usecase/add_media_usecase.dart'
    as _i26;
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart'
    as _i8;
import 'package:charja_charity/features/add_section/data/usecase/delete_article_usecase.dart'
    as _i23;
import 'package:charja_charity/features/add_section/data/usecase/delete_event_usecase.dart'
    as _i15;
import 'package:charja_charity/features/add_section/data/usecase/delete_media_usecase.dart'
    as _i28;
import 'package:charja_charity/features/add_section/data/usecase/delete_service_product_usecase.dart'
    as _i9;
import 'package:charja_charity/features/add_section/data/usecase/edit_article.dart'
    as _i22;
import 'package:charja_charity/features/add_section/data/usecase/get_article_usecase.dart'
    as _i18;
import 'package:charja_charity/features/add_section/data/usecase/get_event_usecase.dart'
    as _i24;
import 'package:charja_charity/features/add_section/data/usecase/get_media_usecase.dart'
    as _i27;
import 'package:charja_charity/features/add_section/data/usecase/get_product_usecase.dart'
    as _i16;
import 'package:charja_charity/features/add_section/data/usecase/search_of_service_by_name_usecase.dart'
    as _i20;
import 'package:charja_charity/features/add_section/data/usecase/update_event_usecase.dart'
    as _i13;
import 'package:charja_charity/features/add_section/data/usecase/update_service_usecase.dart'
    as _i10;
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart'
    as _i6;
import 'package:dartz/dartz.dart' as _i30;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0<Data> extends _i1.SmartFake implements _i2.Result<Data> {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddSectionRepostory].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddSectionRepostory extends _i1.Mock
    implements _i3.AddSectionRepostory {
  MockAddSectionRepostory() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.FileData>> uploadFiles(
          {required _i6.GetFileParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadFiles,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i5.FileData>>.value(
            _FakeResult_0<_i5.FileData>(
          this,
          Invocation.method(
            #uploadFiles,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.FileData>>);
  @override
  _i4.Future<_i2.Result<_i7.AddService>> addService(
          {required _i8.AddServiceParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addService,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i7.AddService>>.value(
            _FakeResult_0<_i7.AddService>(
          this,
          Invocation.method(
            #addService,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i7.AddService>>);
  @override
  _i4.Future<_i2.Result<bool>> deleteServiceOrProduct(
          {required _i9.DeleteServiceProductParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteServiceOrProduct,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<bool>>.value(_FakeResult_0<bool>(
          this,
          Invocation.method(
            #deleteServiceOrProduct,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<bool>>);
  @override
  _i4.Future<_i2.Result<_i7.AddService>> updateService(
          {required _i10.UpdateServiceParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateService,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i7.AddService>>.value(
            _FakeResult_0<_i7.AddService>(
          this,
          Invocation.method(
            #updateService,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i7.AddService>>);
  @override
  _i4.Future<_i2.Result<_i11.AddEventModel>> addEvent(
          {required _i12.AddEventParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addEvent,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i11.AddEventModel>>.value(
            _FakeResult_0<_i11.AddEventModel>(
          this,
          Invocation.method(
            #addEvent,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i11.AddEventModel>>);
  @override
  _i4.Future<_i2.Result<_i11.AddEventModel>> updateEvent(
          {required _i13.UpdateEventParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateEvent,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i11.AddEventModel>>.value(
            _FakeResult_0<_i11.AddEventModel>(
          this,
          Invocation.method(
            #updateEvent,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i11.AddEventModel>>);
  @override
  _i4.Future<_i2.Result<_i14.DeleteEventModel>> deleteEvent(
          {required _i15.DeleteEventParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteEvent,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i14.DeleteEventModel>>.value(
            _FakeResult_0<_i14.DeleteEventModel>(
          this,
          Invocation.method(
            #deleteEvent,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i14.DeleteEventModel>>);
  @override
  _i4.Future<_i2.Result<List<_i7.AddService>>> getProduct(
          {required _i16.GetProductParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProduct,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<List<_i7.AddService>>>.value(
            _FakeResult_0<List<_i7.AddService>>(
          this,
          Invocation.method(
            #getProduct,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i7.AddService>>>);
  @override
  _i4.Future<_i2.Result<List<_i17.GetMyArticles>>> getArticle(
          {required _i18.GetArticleParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getArticle,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<List<_i17.GetMyArticles>>>.value(
            _FakeResult_0<List<_i17.GetMyArticles>>(
          this,
          Invocation.method(
            #getArticle,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i17.GetMyArticles>>>);
  @override
  _i4.Future<_i2.Result<_i19.SearchList>> getSearch(
          {required _i20.SearchArticleParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSearch,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i19.SearchList>>.value(
            _FakeResult_0<_i19.SearchList>(
          this,
          Invocation.method(
            #getSearch,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i19.SearchList>>);
  @override
  _i4.Future<_i2.Result<_i17.CreateArticle>> createArticle(
          {required _i21.AddArticleParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createArticle,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i17.CreateArticle>>.value(
            _FakeResult_0<_i17.CreateArticle>(
          this,
          Invocation.method(
            #createArticle,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i17.CreateArticle>>);
  @override
  _i4.Future<_i2.Result<_i17.CreateArticle>> editArticle(
          {required _i22.EditArticleParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #editArticle,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i17.CreateArticle>>.value(
            _FakeResult_0<_i17.CreateArticle>(
          this,
          Invocation.method(
            #editArticle,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i17.CreateArticle>>);
  @override
  _i4.Future<_i2.Result<_i17.GetMyArticles>> deleteArticle(
          {required _i23.DeleteArticleParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteArticle,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i17.GetMyArticles>>.value(
            _FakeResult_0<_i17.GetMyArticles>(
          this,
          Invocation.method(
            #deleteArticle,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i17.GetMyArticles>>);
  @override
  _i4.Future<_i2.Result<List<_i11.AddEventModel>>> getEvent(
          {required _i24.GetEventParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEvent,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<List<_i11.AddEventModel>>>.value(
            _FakeResult_0<List<_i11.AddEventModel>>(
          this,
          Invocation.method(
            #getEvent,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i11.AddEventModel>>>);
  @override
  _i4.Future<_i2.Result<_i25.AddMediaModel>> addMedia(
          {required _i26.AddMediaParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addMedia,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i25.AddMediaModel>>.value(
            _FakeResult_0<_i25.AddMediaModel>(
          this,
          Invocation.method(
            #addMedia,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i25.AddMediaModel>>);
  @override
  _i4.Future<_i2.Result<List<_i25.AddMediaModel>>> getMedia(
          {required _i27.GetMediaParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMedia,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<List<_i25.AddMediaModel>>>.value(
            _FakeResult_0<List<_i25.AddMediaModel>>(
          this,
          Invocation.method(
            #getMedia,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i25.AddMediaModel>>>);
  @override
  _i4.Future<_i2.Result<_i25.AddMediaModel>> deleteMedia(
          {required _i28.DeleteMediaParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteMedia,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i25.AddMediaModel>>.value(
            _FakeResult_0<_i25.AddMediaModel>(
          this,
          Invocation.method(
            #deleteMedia,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i25.AddMediaModel>>);
  @override
  String getServiceURL(int? type) => (super.noSuchMethod(
        Invocation.method(
          #getServiceURL,
          [type],
        ),
        returnValue: '',
      ) as String);
  @override
  String getdeleteServiceProductsURL(int? type) => (super.noSuchMethod(
        Invocation.method(
          #getdeleteServiceProductsURL,
          [type],
        ),
        returnValue: '',
      ) as String);
  @override
  String updateServiceURL(int? type) => (super.noSuchMethod(
        Invocation.method(
          #updateServiceURL,
          [type],
        ),
        returnValue: '',
      ) as String);
  @override
  String urlAccordingType({required _i16.GetProductParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #urlAccordingType,
          [],
          {#params: params},
        ),
        returnValue: '',
      ) as String);
  @override
  _i2.Result<Model> call<Model extends _i29.BaseModel>(
          {required _i30.Either<_i31.BaseError, _i29.BaseModel>? result}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#result: result},
        ),
        returnValue: _FakeResult_0<Model>(
          this,
          Invocation.method(
            #call,
            [],
            {#result: result},
          ),
        ),
      ) as _i2.Result<Model>);
  @override
  _i2.Result<List<Model>> paginatedCall<Model extends _i29.BaseModel>(
          {required _i30.Either<_i31.BaseError, _i29.BaseModel>? result}) =>
      (super.noSuchMethod(
        Invocation.method(
          #paginatedCall,
          [],
          {#result: result},
        ),
        returnValue: _FakeResult_0<List<Model>>(
          this,
          Invocation.method(
            #paginatedCall,
            [],
            {#result: result},
          ),
        ),
      ) as _i2.Result<List<Model>>);
  @override
  _i2.Result<bool> noModelCall(
          {required _i30.Either<_i31.BaseError, bool>? result}) =>
      (super.noSuchMethod(
        Invocation.method(
          #noModelCall,
          [],
          {#result: result},
        ),
        returnValue: _FakeResult_0<bool>(
          this,
          Invocation.method(
            #noModelCall,
            [],
            {#result: result},
          ),
        ),
      ) as _i2.Result<bool>);
}
