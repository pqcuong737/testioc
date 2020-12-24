import 'package:flutter/cupertino.dart';
import 'package:mobile/src/app/pages/customer/customer_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/customer/CreateCustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerResponseById.dart';
import 'package:mobile/src/domain/entities/customer/UpdateCustomer.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';

class CustomerController extends Controller {
  final CustomerPresenter customerPresenter;

  ///Create Responsen
  CustomerRespose _customerRespose;
  CreateCustomerResponse _createCustomerResponse;
  CustomerResposeById _customerResposeById;
  CustomerUpdateReponse _customerUpdateReponse;
  List totalList = [];
  bool checkLoadMore = false;
  TextEditingController addressController = new TextEditingController();
  TextEditingController jobController = new TextEditingController();

  ///Get response
  CustomerRespose get customerRespose => _customerRespose;
  CreateCustomerResponse get createCustomerResponse => _createCustomerResponse;
  CustomerResposeById get customerResposeById => _customerResposeById;
  CustomerUpdateReponse get customerUpdateReponse => _customerUpdateReponse;

  CustomerController(customerInfo)
      : customerPresenter = CustomerPresenter(customerInfo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    ///Get all customer
    customerPresenter.getCusOnComplete = () {};

    customerPresenter.getCusOnError = () {
      _customerRespose = null;
    };

    customerPresenter.getCusOnNext = (CustomerRespose customerRespose) {
      _customerRespose = customerRespose;
      refreshUI();
    };

    ///Create customer
    customerPresenter.createCustomerOnNext =
        (CreateCustomerResponse createCustomerResponse) {
      _createCustomerResponse = createCustomerResponse;
      refreshUI();
    };

    ///UpdateCustomer
    customerPresenter.updateCustomerOnNext = (CustomerUpdateReponse customerUpdateReponse) {
      _customerUpdateReponse = customerUpdateReponse;
      refreshUI();
    };

    //! GET CUSTOMER BY ID
    customerPresenter.getCustomerByIdOnNext =
        (CustomerResposeById customerResposeById) {
      _customerResposeById = customerResposeById;
      refreshUI();
    };
  }

  final limit = Constant.DEFAULT_LIMIT;
  final page = 1;

  ///Get customer
  Future getAllCustomer(object, bool flagCheckUpdatePage) async {
    object['page'] = page;
    object['limit'] = limit;

    //? Check load more for function getAllCustomersPagination
    checkLoadMore = flagCheckUpdatePage;

    //? Check load more true or false for get list customr provider api
    object['isLoadMore'] = flagCheckUpdatePage;
    
    ///Set limit to show more
    if (flagCheckUpdatePage) {
      final pageStore = await LocalStorageService.getPageList();
      var newPage = pageStore + page;
      if (newPage == page) {
        newPage = newPage + page;
      }

      ///Set limit to local stored
      LocalStorageService.savePageList(newPage);
      object['page'] = newPage;
    }
    _customerRespose = customerPresenter.getAllCustomer(object);
  }

  getAllCustomersPagination() {
    final flagCheckNull =
        customerRespose?.result != null ? customerRespose.result.items : [];
    final oldListCustomers = [...flagCheckNull];

    //TODO check if load more then show new value in memmory;
    if (checkLoadMore == false) {
      totalList = flagCheckNull;
    } else {
      for (int i = 0; i < oldListCustomers.length; i++) {
        totalList.add(oldListCustomers[i]);
      }
    }
    if (totalList != null) {
      return totalList;
    } else {
      return [];
    }
  }

  ///Create customer
  Future<CreateCustomerResponse> functionCreateCustomerController(
      Map objectCreateCustomer) async {
    // final user = await LocalStorageService.getUserInfor();
    objectCreateCustomer['status'] = "ACTIVE";
    // objectCreateCustomer['user_id'] = user?.result?.id;
    _createCustomerResponse =
        customerPresenter.functionCreateCustomerPresenter(objectCreateCustomer);
  }

  ///Update customer
  Future<CustomerUpdateReponse> functionUpdateCustomerController(
      Map objectCreateCustomer) async {
    _customerUpdateReponse =
        customerPresenter.functionUpdateCustomerPresenter(objectCreateCustomer);
  }

  //? GET CUSTOMER BY ID
  Future<void> funcGetCustomerByIdController(int idCustomer) {
    _customerResposeById =
        customerPresenter.functionGetCustomerByIdPresenter(idCustomer);
  }

  MapEntry<String, CarProfileData> createNewProfileData() {
    final profileNumber = LocalStorageService.getProfileCount();
    return MapEntry('PROFILE_$profileNumber', CarProfileData());
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    customerPresenter.dispose();
  }
}
