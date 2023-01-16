import 'package:charja_charity/features/user_managment/data/model/user_model.dart';
import 'package:charja_charity/features/user_managment/data/repository/auth_repository.dart';

import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';

class PaymentParams extends BaseParams {
  PaymentParams({this.paymentMethodID, this.packageID});
  String? paymentMethodID;
  String? packageID;
  toJson() {
    return {"packageId": packageID, "paymentMethodId": paymentMethodID};
  }
}

class PaymentUseCase extends UseCase<UserModel, PaymentParams> {
  final AuthRepository repository;

  PaymentUseCase(this.repository);

  @override
  Future<Result<UserModel>> call({required PaymentParams params}) {
    return repository.addPayment(params: params);
  }
}
