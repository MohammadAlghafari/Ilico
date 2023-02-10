import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/resetPasswordModel.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resetpasswordusecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  ResetPasswordUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = ResetPasswordUseCase(repository: authRepository!);
  });

  ResetPasswordParams resetPasswordParams = ResetPasswordParams(
      oldPassword: "123123@Asds", confirmNewPassword: '12345678oeojfiehf4#Q', newPassword: '12345678oeojfiehf4#Q');
  ResetPasswordModel resetPasswordModel = ResetPasswordModel(message: "test");

  HttpError error = const HttpError(message: ['test error']);

  test('Success change password', () async {
    when(authRepository?.changePassword(params: resetPasswordParams))
        .thenAnswer((_) async => Result<ResetPasswordModel>(
              data: resetPasswordModel,
            ));
    final result = await useCase!.call(params: resetPasswordParams);

    expect(result.hasDataOnly, true);
    expect(result.data, resetPasswordModel);
    verify(useCase!.call(params: resetPasswordParams));
  });
  test('fail change password', () async {
    when(authRepository!.changePassword(params: resetPasswordParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: resetPasswordParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: resetPasswordParams));
  });
}
