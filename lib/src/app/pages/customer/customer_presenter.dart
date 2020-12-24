import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/clean_arch/presenter.dart';
import 'package:mobile/src/domain/entities/customer/CreateCustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerResponseById.dart';
import 'package:mobile/src/domain/entities/customer/UpdateCustomer.dart';
import 'package:mobile/src/domain/usecases/customer/create_customer.dart';
import 'package:mobile/src/domain/usecases/customer/get_all_customer.dart';
import 'package:mobile/src/domain/usecases/customer/get_customer_by_id.dart';
import 'package:mobile/src/domain/usecases/customer/update_customer.dart';

class CustomerPresenter extends Presenter {
  ///Get Customer
  Function getCusOnComplete;
  Function getCusOnError;
  Function getCusOnNext;

  ///Create Customer
  Function createCustomerComplete;
  Function createCustomerError;
  Function createCustomerOnNext;

  ///GET CUSTOMER BY ID
  Function getCustomerByIdOnNext;
  Function getCustomerByIdOnComplete;
  Function getCustomerByIdOnError;

  ///UPDATE CUSTOMER
  Function updateCustomerOnNext;
  Function updateCustomerOnComplete;
  Function updateCustomerOnError;

  ///Use case
  final GetAllUserUseCase getAllUserUseCase;
  final CreateCustomerUseCase createCustomerUseCase;
  final GetCustomerByIdUseCase getCustomerByIdUseCase;
  final UpdateCustomerUseCase updateCustomerUseCase;

  CustomerPresenter(customerRepo)
      : getAllUserUseCase = GetAllUserUseCase(customerRepo),
        createCustomerUseCase = CreateCustomerUseCase(customerRepo),
        getCustomerByIdUseCase = GetCustomerByIdUseCase(customerRepo),
        updateCustomerUseCase = UpdateCustomerUseCase(customerRepo);

  CustomerRespose getAllCustomer(Map object) {
    getAllUserUseCase.execute(
        GetAllCustomerUseCaseObserver(this), Params(object));
  }

  CreateCustomerResponse functionCreateCustomerPresenter(
      Map objectCreateCustomer) {
    createCustomerUseCase.execute(CreateCustomerUseCaseObserver(this),
        DataCustomer(objectCreateCustomer));
  }

  CustomerResposeById functionGetCustomerByIdPresenter(int idCustomer) {
    getCustomerByIdUseCase.execute(
        GetCustomerUseCaseObserver(this), IdCustomer(idCustomer));
  }

  CustomerUpdateReponse functionUpdateCustomerPresenter(
      Map objectCreateCustomer) {
    updateCustomerUseCase.execute(UpdateCustomerUseCaseObserver(this),
        DataCustomerUpdate(objectCreateCustomer));
  }

  @override
  void dispose() {
    getAllUserUseCase.dispose();
  }
}

///GET ALL CUSTOMER
class GetAllCustomerUseCaseObserver extends Observer<GetAllCustomerResponse> {
  CustomerPresenter customerPresenter;

  GetAllCustomerUseCaseObserver(this.customerPresenter);

  @override
  void onComplete() {
    if (customerPresenter.getCusOnComplete != null)
      customerPresenter.getCusOnComplete();
  }

  @override
  void onError(e) {
    if (customerPresenter.getCusOnError != null)
      customerPresenter.getCusOnError(e);
  }

  @override
  void onNext(response) {
    if (customerPresenter.getCusOnNext != null)
      customerPresenter.getCusOnNext(response.customerRespose);
  }
}

///CREATE CUSTOMER
class CreateCustomerUseCaseObserver extends Observer<SwapperCustomerResponse> {
  CustomerPresenter customerPresenter;

  CreateCustomerUseCaseObserver(this.customerPresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
    if (customerPresenter.createCustomerComplete != null)
      customerPresenter.createCustomerComplete();
  }

  @override
  void onError(e) {
    // TODO: implement onError
    if (customerPresenter.createCustomerError != null)
      customerPresenter.createCustomerError(e);
  }

  @override
  void onNext(response) {
    // TODO: implement onNext
    if (customerPresenter.createCustomerOnNext != null) {
      customerPresenter.createCustomerOnNext(response.createCustomerResponse);
    }
  }
}

///GET CUSTOMER
class GetCustomerUseCaseObserver extends Observer<GetCustomerResponseSwap> {
  CustomerPresenter customerPresenter;
  GetCustomerUseCaseObserver(this.customerPresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
    if (customerPresenter.getCustomerByIdOnComplete != null)
      customerPresenter.getCustomerByIdOnComplete();
  }

  @override
  void onError(e) {
    // TODO: implement onError
    if (customerPresenter.getCustomerByIdOnError != null)
      customerPresenter.getCustomerByIdOnError(e);
  }

  @override
  void onNext(response) {
    // TODO: implement onNext
    if (customerPresenter.getCustomerByIdOnNext != null) {
      customerPresenter.getCustomerByIdOnNext(response.customerResposeById);
    }
  }
}


///UPDATE CUSTOMER
class UpdateCustomerUseCaseObserver extends Observer<SwapperUpdateCustomerResponse> {
  CustomerPresenter customerPresenter;

  UpdateCustomerUseCaseObserver(this.customerPresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
    if (customerPresenter.updateCustomerOnComplete != null)
      customerPresenter.updateCustomerOnComplete();
  }

  @override
  void onError(e) {
    // TODO: implement onError
    if (customerPresenter.updateCustomerOnError != null)
      customerPresenter.updateCustomerOnError(e);
  }

  @override
  void onNext(response) {
    // TODO: implement onNext
    if (customerPresenter.updateCustomerOnNext != null) {
      customerPresenter.updateCustomerOnNext(response.customerUpdateReponse);
    }
  }
}
