import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/login_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/verify_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositoy/auth_repository_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  UserInfoUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = UserInfoUseCase(repository: authRepository!);
  });
  LoginModel loginModel = LoginModel(
      refreshTokenExpirationDate: 'fg',
      accessToken: 'en',
      accessTokenExpirationDate: 'lll',
      refreshToken: 'lllllllllllllllll');
  GetUserInfoParams getUserInfoParams = GetUserInfoParams(phoneNumber: "ibrahem@gmail.com", otpCode: 12345);

  HttpError error = const HttpError(message: ['test error']);

  test('Success Verify', () async {
    when(authRepository!.getUserInfo(params: getUserInfoParams)).thenAnswer((_) async => Result(
          data: loginModel,
        ));

    final result = await useCase!.call(params: getUserInfoParams);

    expect(result.hasDataOnly, true);
    expect(result.data, loginModel);
    verify(useCase!.call(params: getUserInfoParams));
  });

  test('fail Verify', () async {
    when(authRepository!.getUserInfo(params: getUserInfoParams)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: getUserInfoParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: getUserInfoParams));
  });
}
