import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_view.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

class ReviewCustomerPage extends View {
  CarProfileData dataIocOffline;
  final idCustomer;
  ReviewCustomerPage({Key key, this.dataIocOffline, this.idCustomer})
      : super(key: key);

  @override
  _ReviewCustomerPageState createState() => _ReviewCustomerPageState();
}

class _ReviewCustomerPageState
    extends ViewState<ReviewCustomerPage, CustomerController> {
  _ReviewCustomerPageState() : super(CustomerController(CustomerRespository()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => getDataCustomer(widget.idCustomer, controller));
  }

  Future getDataCustomer(int idCustomer, CustomerController controller) async {
    await controller.funcGetCustomerByIdController(idCustomer);
  }

  @override
  Widget buildPage() {
    final customerInfo = controller.customerResposeById?.result;
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Colors.grey[100]),
      home: Scaffold(
        key: globalKey,
        appBar:
            WidgetUitlites.buildAppBar(context, Strings.choose_customer, '1'),
        body: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(15, 30, 15, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            customerInfo == null
                                ? SizedBox()
                                : Container(
                                    child: Text(
                                    Strings.title_view_customer,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  )),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  final param = Strings.key_create_profile;
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new CustomerListPage(
                                                  param: param)));
                                },
                                child: customerInfo == null
                                    ? SizedBox()
                                    : Text(
                                        Strings.edit,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 14.0),
                                      ),
                              ),
                            )
                          ],
                        )),
                    customerInfo == null
                        ? SizedBox()
                        : Container(
                            width: double.infinity,
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 0.6),
                                      )),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    Strings.name,
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    "*",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                ],
                                              )),
                                          Container(
                                            constraints: BoxConstraints(
                                                minWidth: 100, maxWidth: 210),
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: InkWell(
                                              onTap: () {},
                                              child: Text(
                                                customerInfo?.fullName ?? '',
                                                textAlign: TextAlign.right,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  customerInfo == null
                                      ? SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.6))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    child: Text(
                                                      Strings.phone,
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    )),
                                                Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 100,
                                                      maxWidth: 210),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      customerInfo?.phone ?? '',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  customerInfo == null
                                      ? SizedBox()
                                      : (customerInfo?.type ==
                                              Strings.key_personal
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.6))),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Text(
                                                          Strings.identity,
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                        )),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 210),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Text(
                                                          customerInfo
                                                                  .identity ??
                                                              '',
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.6))),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                                Strings
                                                                    .tax_code,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0)),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            Text(
                                                              "*",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )
                                                          ],
                                                        )),
                                                    // child: Text(
                                                    //     Strings.tax_code, style: TextStyle(fontSize: 16.0),)),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 210),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Text(
                                                          customerInfo
                                                                  .identity ??
                                                              '',
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                  customerInfo == null
                                      ? SizedBox()
                                      : (customerInfo?.type ==
                                              Strings.key_personal
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.6))),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Text(
                                                            Strings.brithday,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.0))),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 210),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Text(
                                                          customerInfo.birthday !=
                                                                  null
                                                              ? '${DateTime.parse('${customerInfo.birthday}').day}/${DateTime.parse('${customerInfo.birthday}').month}/${DateTime.parse('${customerInfo.birthday}').year}'
//                                                          new DateFormat
//                                                                      .yMd()
//                                                                  .format(DateTime.parse(
//                                                                      customerInfo
//                                                                          .birthday))
                                                              : "---",
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox()),
                                  customerInfo == null
                                      ? SizedBox()
                                      : (customerInfo?.type ==
                                              Strings.key_personal
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 20, 20, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0.6))),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Text(
                                                            Strings.gender,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.0))),
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 210),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Text(
                                                          customerInfo.gender ==
                                                                  Strings
                                                                      .key_male
                                                              ? Strings.male
                                                              : (customerInfo
                                                                          .gender ==
                                                                      Strings
                                                                          .key_female
                                                                  ? Strings
                                                                      .female
                                                                  : Strings
                                                                      .other),
                                                          style: TextStyle(
                                                              fontSize: 16.0),
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox()),
                                  customerInfo == null
                                      ? SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: Container(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(Strings.address,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    16.0)),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        customerInfo?.type ==
                                                                Strings
                                                                    .key_personal
                                                            ? Text(
                                                                "*",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    )),
                                                Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 100,
                                                      maxWidth: 210),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      customerInfo.address ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                      textAlign:
                                                          TextAlign.right,
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
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: customerInfo == null
            ? SizedBox()
            : BottomAppBar(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Expanded(
                        //   child: Container(
                        //     decoration: new BoxDecoration(
                        //         shape: BoxShape.rectangle,
                        //         color: Colors.white,
                        //         border: Border.all(color: Colors.amber[700]),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(4.0))),
                        //     child: FlatButton(
                        //       textColor: Colors.white,
                        //       child: Text(
                        //         Strings.save_temporary,
                        //         style: TextStyle(
                        //             fontSize: 20, color: Colors.amber[700]),
                        //       ),
                        //       onPressed: () {},
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 30.0,
                        // ),
                        Expanded(
                          child: Container(
                            decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.amber[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: FlatButton(
                              textColor: Colors.white,
                              child: Text(
                                Strings.next,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              onPressed: () {
                                if (widget.dataIocOffline != null) {
                                  widget.dataIocOffline.customerId =
                                      customerInfo.id;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarInfoPage(
                                          data: widget.dataIocOffline,
                                          // profileId: mapNewProfileData.key
                                        ),
                                      ));
                                } else {
                                  final mapNewProfileData =
                                      controller.createNewProfileData();
                                  mapNewProfileData.value.customerId =
                                      customerInfo.id;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CarInfoPage(
                                          data: mapNewProfileData.value,
                                          profileId: mapNewProfileData.key),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
