import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/Strings.dart';

class ShowDialogSearchCustomer extends StatefulWidget {
  Map<String, dynamic> objectSearch;
  CustomerController controller;
  ShowDialogSearchCustomer({Key key, this.objectSearch, this.controller})
      : super(key: key);

  @override
  _ShowDialogSearchCustomerState createState() =>
      _ShowDialogSearchCustomerState();
}

class _ShowDialogSearchCustomerState extends State<ShowDialogSearchCustomer> {
  final GlobalKey<FormState> _formKeyDialog = new GlobalKey<FormState>();
  var statusCustomer;
  var typeCustomer;
  var gender;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.objectSearch['status'] != null) {
      statusCustomer = widget.objectSearch['status'];
    }
    if (widget.objectSearch["gender"] != null) {
      gender = widget.objectSearch['gender'];
    }
    if (widget.objectSearch['type'] != null) {
      typeCustomer = widget.objectSearch['type'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: 300.0,
          height: 600.0,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  Strings.advanced_search,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  width: 300.0,
                  height: 460.0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 5),
                    child: Form(
                        key: _formKeyDialog,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //! Type
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                Strings.type_customer,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        new Radio(
                                          value: Constant.TYPE_CUSOTMER_COMPANY,
                                          groupValue: typeCustomer,
                                          activeColor: Colors.blue,
                                          onChanged: (value) =>
                                              handleRadioValueChangeTypeCustomer(
                                                  value),
                                        ),
                                        new Text(
                                          Strings.company,
                                          style: new TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        new Radio(
                                          value:
                                              Constant.TYPE_CUSTOMER_PERSONAL,
                                          groupValue: typeCustomer,
                                          activeColor: Colors.blue,
                                          onChanged: (value) =>
                                              handleRadioValueChangeTypeCustomer(
                                                  value),
                                        ),
                                        new Text(
                                          Strings.personal,
                                          style: new TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //! Gender
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                Strings.gender,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.MALE,
                                        groupValue: gender,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChangeGender(value),
                                      ),
                                      new Text(
                                        Strings.male,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.FEMALE,
                                        groupValue: gender,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChangeGender(value),
                                      ),
                                      new Text(
                                        Strings.female,
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.OTHER,
                                        groupValue: gender,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChangeGender(value),
                                      ),
                                      new Text(
                                        Strings.other,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              //! Radio button search status
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                Strings.status,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.STATUS_CUSTOMER_NEW,
                                        groupValue: statusCustomer,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.new_customer,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.STATUS_CUSTOMER_ACTIVE,
                                        groupValue: statusCustomer,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.active_customer,
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.STATUS_CUSTOMER_LOCK,
                                        groupValue: statusCustomer,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.lock_customer,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ])),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  //? Action delete dialog and clear data search
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        statusCustomer = '';
                        typeCustomer = '';
                        gender = '';
                      });
                      _formKeyDialog.currentState.reset();
                      widget.objectSearch.clear();
                      widget.controller
                          .getAllCustomer(widget.objectSearch, false);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.reset,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  //? Search data
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      widget.controller
                          .getAllCustomer(widget.objectSearch, false);
                      print("-------xxxxxx---------${widget.objectSearch}");
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.search,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Change Value status
  void handleRadioValueChange(value) {
    setState(() {
      statusCustomer = value;
    });
    widget.objectSearch['status'] = value;
  }

  /// Change Value Gender
  void handleRadioValueChangeGender(valueGender) {
    setState(() {
      gender = valueGender;
    });
    widget.objectSearch['gender'] = valueGender;
  }

  void handleRadioValueChangeTypeCustomer(valueTypeCustomer) {
    setState(() {
      typeCustomer = valueTypeCustomer;
    });
    widget.objectSearch["type"] = valueTypeCustomer;
  }
}
