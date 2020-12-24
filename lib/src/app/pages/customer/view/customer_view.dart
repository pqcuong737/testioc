import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/app/pages/customer/view/customer_form_create.view.dart';
import 'package:mobile/src/app/pages/customer/view/customer_list.vew.dart';
import 'package:mobile/src/app/pages/customer/view/search_advanced_customer.view.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/app/pages/profile/view/profile_list_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';
import 'package:mobile/src/utility/Loading/LoadingStyleGrid.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/Strings.dart';

class CustomerListPage extends View {
  final String param;
  CarProfileData dataIocOffline;
  CustomerListPage({ this.param, this.dataIocOffline});

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState
    extends ViewState<CustomerListPage, CustomerController> {
  _CustomerPageState() : super(CustomerController(CustomerRespository()));

  double _headerHeight = 0;
  var listCustomerSync;
  var _size;
  final valueSearch = TextEditingController();
  Map<String, dynamic> object = new Map();
  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    controller.getAllCustomer(object, false);
    LocalStorageService.savePageList(1);
    // WidgetsBinding.instance.addPostFrameCallback((_) => triggerIsOnline());
  }
  
  // triggerIsOnline () {
  //   isOnlineInitial = super.isInternetConnected;
  // }

  @override
  void dispose() {
    LocalStorageService.savePageList(1);
    super.dispose();
  }

  @override
  Widget buildPage() {
    _size = MediaQuery.of(context).size;
    _headerHeight = _size.height * .22;
    // final response = controller.customerRespose;
    // var items = response?.result?.items ?? null;
    // final items = listCustomerSync;
    final items = controller.getAllCustomersPagination();
    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
      home: Scaffold(
        key: RIKeys.riKey1,
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          leading: Builder(builder: (BuildContext context) {
            if (widget.param == Strings.key_ceate_customer) {
              return IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.keyboard_backspace),
                color: Colors.white,
                onPressed: () async {
                  final user = await LocalStorageService.getUserInfor();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new MainHomePage(user)));
                },
              );
            } else {
              return IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.keyboard_backspace),
                color: Colors.white,
                onPressed: () {
                  final param = Strings.key_create_profile;
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ListProfilePage(param)));
                },
              );
            }
          }),
          actions: '${widget.param}' != Strings.key_create_profile
              ? <Widget>[
                  IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        final param = Strings.key_ceate_customer;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerCreateForm(param),
                          ),
                        );
                      }),
                  IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.filter_list),
                    color: Colors.white,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ShowDialogSearchCustomer(
                                objectSearch: object, controller: controller);
                          });
                    },
                  )
                ]
              : <Widget>[],
          title: '${widget.param}' != Strings.key_create_profile
              ? Text(Strings.customer,
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(Strings.choose_customer,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0)),
                      ),
                    ),
                    Container(
                      child: Text('Bước 1/4',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
          bottom: PreferredSize(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 13, 20),
                child: Container(
                  height: 50.0,
                  child: TextField(
                    controller: valueSearch,
                    onChanged: (text) {
                      object['value'] = valueSearch.text;
                      controller.getAllCustomer(object, false);
                    },
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[400],
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35.0))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35.0))),
                        labelText: Strings.title_search,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(80.0),
          ),
        ),
        body: (items != null)
            ? ListCustomer(
                items: items,
                params: widget.param,
                controller: controller,
                dataIocOffline: widget.dataIocOffline,
                isOnline: isOnline,
              )
            : LoadingStyleGrid(),
        // body: Text('Text'),
      ),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    setState(() {
      isOnline = result;
    });
  }
}

class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
}
