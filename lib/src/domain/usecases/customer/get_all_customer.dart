import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/customer/CustomerRepose.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';

class GetAllUserUseCase extends UseCase<GetAllCustomerResponse, Params> {
  final CustomerRespository customerRespository;
  GetAllUserUseCase(this.customerRespository);

  @override
  Future<Stream<GetAllCustomerResponse>> buildUseCaseStream(
      Params params) async {
    final StreamController<GetAllCustomerResponse> controller =
        StreamController();
    try {
      CustomerRespose customerRespose =
          await customerRespository.getAllCustomer(params.object);
      controller.add(GetAllCustomerResponse(customerRespose));
      controller.close();
    } catch (e) {
      logger.e('Get customer usecase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class Params {
  final Map object;
  Params(this.object);
}

class GetAllCustomerResponse {
  final CustomerRespose customerRespose;
  GetAllCustomerResponse(this.customerRespose);
}
