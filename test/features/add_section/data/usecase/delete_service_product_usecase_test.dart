import 'package:charja_charity/core/errors/http_error.dart';
import 'package:charja_charity/core/results/result.dart';
import 'package:charja_charity/features/add_section/data/repository/add_section_repostory.dart';
import 'package:charja_charity/features/add_section/data/usecase/delete_service_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repository/add_section_repository_usecase.mocks.dart';

@GenerateMocks([AddSectionRepostory])
void main() {
  MockAddSectionRepostory? addSectionRepostory;
  DeleteServiceProductUseCase? useCase;

  setUp(() {
    addSectionRepostory = MockAddSectionRepostory();
    useCase = DeleteServiceProductUseCase(addSectionRepostory!);
  });
  DeleteServiceProductParams deleteServiceProductParams = DeleteServiceProductParams(id: "test", type: 1);
  HttpError error = const HttpError(message: ['Http error']);
  test('Success delete service, products usecase', () async {
    when(addSectionRepostory?.deleteServiceOrProduct(params: deleteServiceProductParams))
        .thenAnswer((_) async => Result<bool>(
              data: true,
            ));
    final result = await useCase!.call(params: deleteServiceProductParams);

    expect(result.hasDataOnly, true);
    expect(result.data, true);
    verify(useCase!.call(params: deleteServiceProductParams));
  });
  test('fail delete service, products usecase', () async {
    when(addSectionRepostory!.deleteServiceOrProduct(params: deleteServiceProductParams))
        .thenAnswer((_) async => Result<bool>(error: error));

    final result = await useCase!.call(params: deleteServiceProductParams);

    expect(result.hasErrorOnly, true);
    expect(result.hasDataOnly, false);
    expect(result.error, error);
    verify(useCase!.call(params: deleteServiceProductParams));
  });
}
