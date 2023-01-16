import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/resend_otp_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositoy/auth_repository_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  ResendOTPUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = ResendOTPUseCase(authRepository!);
  });

  ResendOTPParams params = ResendOTPParams(email: "ibrahim@gmail.com");

  HttpError error = const HttpError(message: ['test error']);

  test('Success Resend OTP Code', () async {
    when(authRepository!.ResendOTP(params: params))
        .thenAnswer((_) async => Result(
              data: true,
            ));

    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(useCase!.call(params: params));
  });

  test('fail Resend OTP Code', () async {
    when(authRepository!.ResendOTP(params: params))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
