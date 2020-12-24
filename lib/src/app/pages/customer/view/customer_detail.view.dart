import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/app/pages/customer/view/customer_edit_form.view.dart';
import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class CustomerDetail extends View {
  static const routeName = '/detail-customer';
  final idCustomer;
  final param;
  int idOwner;

  CustomerDetail({Key key, this.idCustomer, this.param, this.idOwner
//        @required this.item
      })
      : super(key: key);

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState
    extends ViewState<CustomerDetail, CustomerController> {
  _CustomerDetailState() : super(CustomerController(CustomerRespository()));
  bool isOwner = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getDataCustomer(widget.idCustomer, controller));
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUserOwner());

  }

  Future getDataCustomer(int idCustomer, CustomerController controller) async {
    await controller.funcGetCustomerByIdController(idCustomer);
  }

  Future<void> checkUserOwner() async {
    final resultIsOwner = await Utils.isUserCanAction(widget.idOwner);
    isOwner = resultIsOwner;
    setState(() {
      isOwner = resultIsOwner;
    });
  }

  @override
  Widget buildPage() {
    final customerDetail = controller.customerResposeById?.result;
    final customerData = controller.customerResposeById;
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[100],
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        key: globalKey,
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          title: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    iconSize: 30.0,
                    icon: Icon(Icons.keyboard_backspace),
                    color: Colors.white,
                    onPressed: () {
                      final menuToListCustomer = Strings.key_ceate_customer;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CustomerListPage(param: menuToListCustomer),
                        ),
                      );
                    }),
                Text(Strings.customer_detail,
                    style: TextStyle(color: Colors.white, fontSize: 25.0)),
              ],
            ),
          ),
          actions: <Widget>[
          isOwner ?  IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.edit),
              color: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return CustomerEditFrom(
                          param: widget.param, customer: customerData);
                    });
              },
            ) : SizedBox()
          ],
        ),
        body: SafeArea(
          bottom: true,
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                        child: Row(
                          children: <Widget>[
                            Text(
                              Strings.infor_basic,
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.7),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.4),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.type_customer,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  height: 25.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: customerDetail.type ==
                                            Strings.key_personal
                                        ? Colors.orange
                                        : Colors.green[800],
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Text(
                                      customerDetail.type ==
                                              Strings.key_personal
                                          ? Strings.personal
                                          : Strings.company,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          height: 1.0),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                //TODO Status
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.6),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.status,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.status == "ACTIVE"
                                        ? Strings.status_active
                                        : (customerDetail.status == "NEW"
                                            ? Strings.status_new
                                            : Strings.status_lock),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: customerDetail.status == "ACTIVE"
                                            ? Colors.green[800]
                                            : (customerDetail.status == "NEW"
                                                ? Colors.blue
                                                : Colors.grey)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                //TODO Create at
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.create_at,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.createdAt != null
                                        ?
//                                     '${DateFormat.yMd().format(DateTime.parse('${customerDetail.createdAt}'))}'
                                        '${DateTime.parse('${customerDetail.createdAt}').day}/${DateTime.parse('${customerDetail.createdAt}').month}/${DateTime.parse('${customerDetail.createdAt}').year} ${DateFormat.jm().format(DateTime.parse('${customerDetail.createdAt}'))}'
                                        : '---',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                //TODO THÔNG TIN CÁ NHÂN
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                        child: Row(
                          children: <Widget>[
                            Text(
                              Strings.infor_peronal,
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.7),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                //TODO name
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.6),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.name,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.fullName,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                //TODO Identity
                customerDetail == null
                    //!
                    ? SizedBox()
                    : (customerDetail.type == Strings.key_personal
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.6),
                              )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        Strings.identity,
                                        style: TextStyle(fontSize: 16.0),
                                      )),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        customerDetail.identity ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.6),
                              )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        Strings.tax_code,
                                        style: TextStyle(fontSize: 16.0),
                                      )),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        customerDetail?.identity ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                //TODO brithday
                customerDetail == null
                    //!
                    ? SizedBox()
                    : (customerDetail?.type == Strings.key_personal
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.6),
                              )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        Strings.brithday,
                                        style: TextStyle(fontSize: 16.0),
                                      )),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        customerDetail.birthday != null
                                            ?
//                                        '${DateFormat.yMd().format(DateTime.parse('${customerDetail.birthday}'))}'
                                            '${DateTime.parse('${customerDetail.birthday}').day}/${DateTime.parse('${customerDetail.birthday}').month}/${DateTime.parse('${customerDetail.birthday}').year}'
                                            : '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox()),
                //TODO Gender
                customerDetail == null
                    //!
                    ? SizedBox()
                    : (customerDetail?.type == Strings.key_personal
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.6),
                              )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        Strings.gender,
                                        style: TextStyle(fontSize: 16.0),
                                      )),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        customerDetail.gender ==
                                                Strings.key_male
                                            ? Strings.male
                                            : (customerDetail.gender ==
                                                    Strings.key_female
                                                ? Strings.female
                                                : '---'),
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox()),
                //TODO Phone
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.6),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.phone,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.phone ?? "---",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.6),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.email ?? "---",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                //TODO career
                customerDetail == null
                    //!
                    ? SizedBox()
                    : (customerDetail.type == Strings.key_personal
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.6),
                              )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        Strings.job,
                                        style: TextStyle(fontSize: 16.0),
                                      )),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        customerDetail.job ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : SizedBox()),
                //TODO Address
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.6),
                          )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.address,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.address ?? "---",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                customerDetail == null
                    //!
                    ? SizedBox()
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    Strings.note,
                                    style: TextStyle(fontSize: 16.0),
                                  )),
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 210),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    customerDetail.note ?? "---",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}
