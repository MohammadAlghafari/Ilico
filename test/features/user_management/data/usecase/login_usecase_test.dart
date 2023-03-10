import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/login_usecse.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositoy/auth_repository_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  GetLoginUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = GetLoginUseCase(authRepository!);
  });
  LoginModel loginModel = LoginModel(
    refreshTokenExpirationDate: 'fg',
    accessToken: 'en',
    accessTokenExpirationDate: 'lll',
    refreshToken: 'lllllllllllllllll',
    userType: "Customer",
    isVerified: false,
    phoneNumber: "+963147852369",
  );

  GetLoginParams params = GetLoginParams(email: 'ANGHAM@yopmail.com', password: 'jkdbidbfydhbvhd');

  HttpError error = const HttpError(message: ['test error']);

  test('Success login', () async {
    when(authRepository!.getLogin(params: params)).thenAnswer((_) async => Result(
          data: loginModel,
        ));

    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(useCase!.call(params: params));
  });

  test('fail login usecase', () async {
    when(authRepository!.getLogin(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
