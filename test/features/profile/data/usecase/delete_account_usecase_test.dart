import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/delete_account_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/delete_account_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_company_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  DeleteAccountUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = DeleteAccountUseCase(profileRepository!);
  });

  DeleteAccountParams deleteAccountParams = DeleteAccountParams(password: "13456789@As");
  DeleteAccountModel deleteAccountModel = DeleteAccountModel(message: "test");

  HttpError error = const HttpError(message: ['Http error']);
  test('Success delete account', () async {
    when(profileRepository?.deleteAccount(params: deleteAccountParams))
        .thenAnswer((_) async => Result<DeleteAccountModel>(
              data: deleteAccountModel,
            ));
    final result = await useCase!.call(params: deleteAccountParams);

    expect(result.hasDataOnly, true);
    expect(result.data, deleteAccountModel);
    verify(useCase!.call(params: deleteAccountParams));
  });
  test('fail delete account', () async {
    when(profileRepository!.deleteAccount(params: deleteAccountParams))
        .thenAnswer((_) async => Result<DeleteAccountModel>(error: error));

    final result = await useCase!.call(params: deleteAccountParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: deleteAccountParams));
  });
}
