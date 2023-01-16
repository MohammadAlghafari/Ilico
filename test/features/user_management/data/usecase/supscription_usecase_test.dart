import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/supscription_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'assign_category_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  SupscriptionUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = SupscriptionUseCase(authRepository!);
  });
  GetListRequest request = GetListRequest(limit: 20, order: "asc", page: 1);
  SupscriptionParams params = SupscriptionParams(request: request);
  Supscription supscription = Supscription(
      description: "test", price: 120, id: "1230", title: "title", isSelected: false, duration: 12, activityCount: 2);
  List<Supscription> supscriptionList = [supscription, supscription];
  HttpError error = const HttpError(message: ['Http error']);
  test('Success get Supscription', () async {
    when(authRepository?.getPackegs(params: params)).thenAnswer((_) async => PaginatedResult(
          data: supscriptionList,
        ));
    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, supscriptionList);
    verify(useCase?.call(params: params));
  });
  test('fail get Supscription', () async {
    when(authRepository?.getPackegs(params: params)).thenAnswer((_) async => PaginatedResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
