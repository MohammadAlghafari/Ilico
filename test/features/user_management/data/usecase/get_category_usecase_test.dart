import 'package:charja_charity/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/get_category_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_category_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  GetCategoriesUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = GetCategoriesUseCase(authRepository!);
  });
  List<Activities> activities = [
    Activities(isSelected: true, description: "lllllllll", name: "ll", id: "kkk", isActive: true)
  ];

  GetCategoriesParams params = GetCategoriesParams(request: GetListRequest(order: "l", limit: 5, page: 1));

  HttpError error = const HttpError(message: ['test error']);

  test('Success get category', () async {
    when(authRepository?.getCategories(params: params)).thenAnswer((_) async => Result(
          data: activities,
        ));

    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, activities);
    verify(useCase!.call(params: params));
  });

  test('fail get category', () async {
    when(authRepository!.getCategories(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
