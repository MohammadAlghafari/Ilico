import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositoy/auth_repository_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  LogOutUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = LogOutUseCase(authRepository!);
  });

  //ResendOTPParams params = ResendOTPParams(email: "ibrahim@gmail.com");
  LogOutParams params = LogOutParams();
  HttpError error = const HttpError(message: ['test error']);

  test('Success logout', () async {
    when(authRepository!.LogOut(params: params)).thenAnswer((_) async => Result(
          data: true,
        ));

    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(useCase!.call(params: params));
  });

  test('fail logout', () async {
    when(authRepository!.LogOut(params: params))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
