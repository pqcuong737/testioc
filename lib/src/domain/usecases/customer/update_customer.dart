import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/customer/CreateCustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/UpdateCustomer.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';

class UpdateCustomerUseCase
    extends UseCase<SwapperUpdateCustomerResponse, DataCustomerUpdate> {
  final CustomerRespository customerRespository;

  ///Contructer
  UpdateCustomerUseCase(this.customerRespository);

  @override
  Future<Stream<SwapperUpdateCustomerResponse>> buildUseCaseStream(
      DataCustomerUpdate dataCustomer) async {
    final StreamController<SwapperUpdateCustomerResponse> controller =
    StreamController();
    try {
      CustomerUpdateReponse customerUpdateReponse = await customerRespository
          .updateCustomerRepository(dataCustomer.objectCreateCustomer);
      controller.add(SwapperUpdateCustomerResponse(customerUpdateReponse));
      controller.close();
    } catch (e) {
      logger.e('Create customer unsuccessful');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class DataCustomerUpdate {
  final Map objectCreateCustomer;
  DataCustomerUpdate(this.objectCreateCustomer);
}

class SwapperUpdateCustomerResponse {
  final CustomerUpdateReponse customerUpdateReponse;
  SwapperUpdateCustomerResponse(this.customerUpdateReponse);
}
