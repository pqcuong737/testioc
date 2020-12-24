import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/customer/CustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerResponseById.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';

class GetCustomerByIdUseCase extends UseCase<GetCustomerResponseSwap, IdCustomer> {
  final CustomerRespository customerRespository;
  GetCustomerByIdUseCase(this.customerRespository);

  @override
  Future<Stream<GetCustomerResponseSwap>> buildUseCaseStream(
      IdCustomer idCustomer) async {
    final StreamController<GetCustomerResponseSwap> controller =
        StreamController();
    try {
      CustomerResposeById customerResposeById =
          await customerRespository.getCustomerByIdRepository(idCustomer.idCustomer);
      controller.add(GetCustomerResponseSwap(customerResposeById));
      controller.close();
    } catch (e) {
      logger.e('Get customer usecase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class IdCustomer {
  final idCustomer;
  IdCustomer(this.idCustomer);
}

class GetCustomerResponseSwap {
  final CustomerResposeById customerResposeById;
  GetCustomerResponseSwap(this.customerResposeById);
}
