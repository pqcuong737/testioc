import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/customer/CreateCustomerRepose.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';

class CreateCustomerUseCase
    extends UseCase<SwapperCustomerResponse, DataCustomer> {
  final CustomerRespository customerRespository;

  ///Contructer
  CreateCustomerUseCase(this.customerRespository);

  @override
  Future<Stream<SwapperCustomerResponse>> buildUseCaseStream(
      DataCustomer dataCustomer) async {
    final StreamController<SwapperCustomerResponse> controller =
        StreamController();
    try {
      CreateCustomerResponse createCustomerResponse = await customerRespository
          .createCustomerRepository(dataCustomer.objectCreateCustomer);
      controller.add(SwapperCustomerResponse(createCustomerResponse));
      controller.close();
    } catch (e) {
      logger.e('Create customer unsuccessful');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class DataCustomer {
  final Map objectCreateCustomer;

  DataCustomer(this.objectCreateCustomer);
}

class SwapperCustomerResponse {
  final CreateCustomerResponse createCustomerResponse;

  SwapperCustomerResponse(this.createCustomerResponse);
}
