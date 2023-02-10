// Mocks generated by Mockito 5.3.2 from annotations
// in charja_charity/test/features/search_test/data/repository/search_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:charja_charity/core/data_source/model.dart' as _i11;
import 'package:charja_charity/core/errors/base_error.dart' as _i13;
import 'package:charja_charity/core/results/result.dart' as _i2;
import 'package:charja_charity/features/search/data/model/auto_complete_model.dart'
    as _i7;
import 'package:charja_charity/features/search/data/model/search_model.dart'
    as _i9;
import 'package:charja_charity/features/search/data/model/storeLocationModel.dart'
    as _i5;
import 'package:charja_charity/features/search/data/repository/search_repository.dart'
    as _i3;
import 'package:charja_charity/features/search/data/usecase/auto_complete_usecase.dart'
    as _i8;
import 'package:charja_charity/features/search/data/usecase/search_usecase.dart'
    as _i10;
import 'package:charja_charity/features/search/data/usecase/store_location_usecase.dart'
    as _i6;
import 'package:dartz/dartz.dart' as _i12;
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

/// A class which mocks [SearchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchRepository extends _i1.Mock implements _i3.SearchRepository {
  MockSearchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result<_i5.StoreLocation>> storeLocation(
          {required _i6.StoreLocationParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeLocation,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<_i2.Result<_i5.StoreLocation>>.value(
            _FakeResult_0<_i5.StoreLocation>(
          this,
          Invocation.method(
            #storeLocation,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<_i5.StoreLocation>>);
  @override
  _i4.Future<_i2.Result<List<_i7.AutoCompleteSearchItem>>>
      getAutoCompleteResult({required _i8.AutoCompleteSearchParams? params}) =>
          (super.noSuchMethod(
            Invocation.method(
              #getAutoCompleteResult,
              [],
              {#params: params},
            ),
            returnValue:
                _i4.Future<_i2.Result<List<_i7.AutoCompleteSearchItem>>>.value(
                    _FakeResult_0<List<_i7.AutoCompleteSearchItem>>(
              this,
              Invocation.method(
                #getAutoCompleteResult,
                [],
                {#params: params},
              ),
            )),
          ) as _i4.Future<_i2.Result<List<_i7.AutoCompleteSearchItem>>>);
  @override
  _i4.Future<_i2.Result<List<_i9.SearchOfServiceProvider>>> getSearchResult(
          {required _i10.SearchParams? params}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSearchResult,
          [],
          {#params: params},
        ),
        returnValue:
            _i4.Future<_i2.Result<List<_i9.SearchOfServiceProvider>>>.value(
                _FakeResult_0<List<_i9.SearchOfServiceProvider>>(
          this,
          Invocation.method(
            #getSearchResult,
            [],
            {#params: params},
          ),
        )),
      ) as _i4.Future<_i2.Result<List<_i9.SearchOfServiceProvider>>>);
  @override
  _i2.Result<Model> call<Model extends _i11.BaseModel>(
          {required _i12.Either<_i13.BaseError, _i11.BaseModel>? result}) =>
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
  _i2.Result<List<Model>> paginatedCall<Model extends _i11.BaseModel>(
          {required _i12.Either<_i13.BaseError, _i11.BaseModel>? result}) =>
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
          {required _i12.Either<_i13.BaseError, bool>? result}) =>
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
