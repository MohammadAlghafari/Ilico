import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/change_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  ChangePasswordUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = ChangePasswordUseCase(repository: authRepository!);
  });

  ChangePasswordParams changePasswordParams = ChangePasswordParams(
      email: 'angham@yopmail.com',
      otpCode: 4561,
      confirmNewPassword: '12345678oeojfiehf4#Q',
      newPassword: '12345678oeojfiehf4#Q');

  HttpError error = const HttpError(message: ['test error']);

  test('Success change password', () async {
    when(authRepository?.ChangePassword(params: changePasswordParams)).thenAnswer((_) async => Result<bool>(
          data: true,
        ));
    final result = await useCase!.call(params: changePasswordParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(useCase!.call(params: changePasswordParams));
  });
  test('fail change password', () async {
    when(authRepository!.ChangePassword(params: changePasswordParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: changePasswordParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: changePasswordParams));
  });
}
