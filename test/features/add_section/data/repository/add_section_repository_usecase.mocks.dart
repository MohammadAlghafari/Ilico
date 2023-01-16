// Mocks generated by Mockito 5.3.2 from annotations
// in charja_charity/test/features/add_section/data/repository/add_section_repository_usecase.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:charja_charity/core/data_source/model.dart' as _i9;
import 'package:charja_charity/core/errors/base_error.dart' as _i11;
import 'package:charja_charity/core/results/result.dart' as _i2;
import 'package:charja_charity/features/add_section/data/model/file_data.dart'
    as _i5;
import 'package:charja_charity/features/add_section/data/model/new_service.dart'
    as _i7;
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart'
    as _i3;
import 'package:charja_charity/features/add_section/data/usecase/add_service_usecase.dart'
    as _i8;
import 'package:charja_charity/features/add_section/data/usecase/upload_file_usecase.dart'
    as _i6;
import 'package:dartz/dartz.dart' as _i10;
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
  String getServiceURL(int? type) => (super.noSuchMethod(
        Invocation.method(
          #getServiceURL,
          [type],
        ),
        returnValue: '',
      ) as String);
  @override
  _i2.Result<Model> call<Model extends _i9.BaseModel>(
          {required _i10.Either<_i11.BaseError, _i9.BaseModel>? result}) =>
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
  _i2.Result<List<Model>> paginatedCall<Model extends _i9.BaseModel>(
          {required _i10.Either<_i11.BaseError, _i9.BaseModel>? result}) =>
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
          {required _i10.Either<_i11.BaseError, bool>? result}) =>
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