import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/verfiy_code_forget_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_otp_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  ForgetPasswordOtpUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = ForgetPasswordOtpUseCase(repository: authRepository!);
  });

  ForgetPasswordOtpParams forgetPasswordParams = ForgetPasswordOtpParams(email: 'angham@yopmail.com', otpCode: 4521);

  HttpError error = const HttpError(message: ['test error']);

  test('Success forget password', () async {
    when(authRepository?.ForgetPasswordOtp(params: forgetPasswordParams)).thenAnswer((_) async => Result<bool>(
          data: true,
        ));
    final result = await useCase!.call(params: forgetPasswordParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(useCase!.call(params: forgetPasswordParams));
  });
  test('fail forget password', () async {
    when(authRepository!.ForgetPasswordOtp(params: forgetPasswordParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: forgetPasswordParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: forgetPasswordParams));
  });
}
