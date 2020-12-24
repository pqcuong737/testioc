import 'package:mobile/src/domain/entities/customer/CreateCustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerResponseById.dart';
import 'package:mobile/src/domain/entities/customer/UpdateCustomer.dart';
import 'package:mobile/src/utility/APIProvider.dart';

class CustomerRespository {
  APIProvider _apiProvider = APIProvider();

  ///Get all customer
  Future<CustomerRespose> getAllCustomer(Map object) {
    return _apiProvider.getAllCustomer(object);
  }

  ///Create customer
  Future<CreateCustomerResponse> createCustomerRepository(
      Map objectCreateCustomer) {
    return _apiProvider.createCustomer(objectCreateCustomer);
  }

  ///Update customer
  Future<CustomerUpdateReponse> updateCustomerRepository(
      Map objectCreateCustomer) {
    return _apiProvider.updateCustomer(objectCreateCustomer);
  }

  ///Get Customer by id
  Future<CustomerResposeById> getCustomerByIdRepository(int idCustomer) {
    return _apiProvider.getCustomerById(idCustomer);
  }
}
