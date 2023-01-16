import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/profile/data/model/profile_model.dart';
import 'package:charja_charity/features/profile/data/profile_repository/profile_repository.dart';
import 'package:charja_charity/features/profile/data/use_case/edit_company_service_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_company_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  MockProfileRepository? profileRepository;
  EditCompanyProfileUseCase? useCase;

  setUp(() {
    profileRepository = MockProfileRepository();
    useCase = EditCompanyProfileUseCase(profileRepository!);
  });

  Company companyModel = Company(
    id: 'djknhndnv',
    phoneNumber: '12346789',
    name: 'hbjhbj',
    description: 'klnl',
    iban: 'hbjhb',
    job: 'jfnvjk',
    sirenNumber: 'ndjkcn',
  );

  EditCompanyProfileParams editCompanyProfileParams = EditCompanyProfileParams(
      phoneNumber: '123456789', name: 'hskah', sirenNumber: 'jfdfh', job: 'fdjkfjjk', iban: 'ddj', description: 'ddkd');

  HttpError error = const HttpError(message: ['Http error']);
  test('Success company', () async {
    when(profileRepository?.editCompany(params: editCompanyProfileParams)).thenAnswer((_) async => RemoteResult(
          data: companyModel,
        ));
    final result = await useCase!.call(params: editCompanyProfileParams);

    expect(result.hasDataOnly, true);
    expect(result.data, companyModel);
    verify(useCase!.call(params: editCompanyProfileParams));
  });
  test('fail edit company', () async {
    when(profileRepository!.editCompany(params: editCompanyProfileParams))
        .thenAnswer((_) async => RemoteResult(error: error));

    final result = await useCase!.call(params: editCompanyProfileParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: editCompanyProfileParams));
  });
}
