import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';
import 'package:charja_charity/features/user_managment/data/usecase/signup_by_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositoy/auth_repository_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  MockAuthRepository? authRepository;
  SignUpByGoogleUseCase? useCase;

  setUp(() {
    authRepository = MockAuthRepository();
    useCase = SignUpByGoogleUseCase(authRepository!);
  });

  SignUpByGoogleParams params = SignUpByGoogleParams(
      roleKey: "CUSTOMER",
      firstName: "lekaa",
      lastName: "kmlk",
      phone: '0938362440',
      email: "leka.alawad@gmail.com",
      googleProfileId: "id",
      isCustomer: false);
  UserModel userModel = UserModel(id: "1", name: "test", email: "ibrahem@gmail.com", gender: "Male");
  HttpError error = const HttpError(message: ['test error']);

  test('Success google singup usecase', () async {
    when(authRepository!.signUpByGoogle(params: params)).thenAnswer((_) async => RemoteResult(
          data: userModel,
        ));

    final result = await useCase!.call(params: params);

    expect(result.hasDataOnly, true);
    expect(result.data, userModel);
    verify(useCase!.call(params: params));
  });

  test('fail google singup usecase', () async {
    when(authRepository!.signUpByGoogle(params: params)).thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: params);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: params));
  });
}
