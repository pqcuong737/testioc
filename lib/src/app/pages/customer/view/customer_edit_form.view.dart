import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/app/pages/customer/view/customer_detail.view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/customer/CustomerResponseById.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

class CustomerEditFrom extends View {
  CustomerResposeById customer;
  final param;
  CustomerEditFrom({this.customer, this.param});
  @override
  _CustomerEditFromSate createState() => _CustomerEditFromSate();
}

class _CustomerEditFromSate
    extends ViewState<CustomerEditFrom, CustomerController> {
  _CustomerEditFromSate() : super(CustomerController(CustomerRespository()));
  final _formKey = new GlobalKey<FormState>();
  Size _size;
  var options;
  var gender = Strings.key_male;
  var brithday;
  bool flagCheckClickButton = false;
  bool isOnline = true;
  var job = '';
  var address = '';
  Map<String, dynamic> objectCreateCustomer = new Map();

  _handleChangeOption(value) {
    setState(() {
      options = value;
    });
    objectCreateCustomer.clear();
    objectCreateCustomer['type'] = value;
    objectCreateCustomer['gender'] =
        widget.customer.result.gender ?? Strings.key_male;
  }

  _handleChangeGender(value) {
    setState(() {
      gender = value;
    });
    objectCreateCustomer['gender'] = value;
  }

  @override
  void initState() {
    // TODO: implement initState
    options = widget.customer?.result?.type ?? Strings.key_personal;
    gender = widget.customer?.result?.gender ?? Strings.key_male;
    controller.jobController.text = widget.customer?.result?.job ?? '';
    controller.addressController.text =  widget.customer?.result?.address ?? '';
    if (widget?.customer?.result?.birthday != null) {
      brithday = widget.customer.result.birthday;
    }
//    brithday = widget.customer.result.birthday
    Utils.isInternetConnected().then((internet) {
      _onConnectivityListener(internet);
    });
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi)
        _onConnectivityListener(true);
      else
        _onConnectivityListener(false);
      LoggerUtil().logger.d("Connectivity: " + result.toString());
    });
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => handleShowMessage(context, controller, widget.param));
  }

  void _onConnectivityListener(bool value) {
    setState(() {
      isOnline = value;
    });
  }

  @override
  Widget buildPage() {
    flagCheckClickButton ? initState() : null;
    _size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          Strings.edit_customer,
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          left: true,
          right: true,
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (isOnline == false)
                    ? WidgetUitlites.offlineView(context)
                    : SizedBox(),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(Strings.type_code,
                                  style: TextStyle(fontSize: 16.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Radio(
                                            autofocus: true,
                                            value: Strings.key_personal,
                                            groupValue: options,
                                            activeColor: Colors.blue,
                                            onChanged: (value) =>
                                                _handleChangeOption(value)),
                                        Text(Strings.personal,
                                            style: TextStyle(fontSize: 16.0)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Radio(
                                            value: Strings.key_company,
                                            groupValue: options,
                                            activeColor: Colors.blue,
                                            onChanged: (value) =>
                                                _handleChangeOption(value)),
                                        Text(Strings.company,
                                            style: TextStyle(fontSize: 16.0)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: options == Strings.key_personal
                                    ? _formPersonal(
                                        context, widget.customer.result)
                                    : _formCompanty(
                                        context, widget.customer.result),
                              ),
                            ],
                          )),
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
            width: _size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text(
                      Strings.reset,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState.reset();
                      objectCreateCustomer.clear();
                      setState(() {
                        brithday = widget.customer.result.birthday;
                        options = widget.customer.result.type;
                        gender =
                            widget.customer.result.gender ?? Strings.key_male;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      Strings.save,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (isOnline == false) return null;
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        flagCheckClickButton = true;
                        objectCreateCustomer['id'] =
                            widget.customer?.result?.id;
                        objectCreateCustomer['job'] = controller.jobController.text ?? '';
                        objectCreateCustomer['address'] = controller.addressController.text ?? '';
                        print("--------->$objectCreateCustomer");
                        controller.functionUpdateCustomerController(
                            objectCreateCustomer);
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    ));
  }

  Widget _formPersonal(BuildContext context, customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.name,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
//          controller: _fullName,
          onChanged: (String value) {
            objectCreateCustomer['fullName'] = value;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_name,
          ),
          initialValue: customer?.fullName ?? '',
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_name;
            }
            return null;
          },
          // onSaved: (val) => setState(() => val),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.identity,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
          ],
        ),
        TextFormField(
//          controller: _identity,
          onChanged: (String value) {
            objectCreateCustomer['identity'] = value;
          },
          initialValue: customer?.identity ?? '',
          decoration: const InputDecoration(
            hintText: Strings.hint_text_identity,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Strings.brithday,
          style: TextStyle(fontSize: 16.0),
        ),
        TextFormField(
          onTap: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(1900, 1, 1),
                maxTime: DateTime.now().toUtc(),
                onChanged: (date) {}, onConfirm: (date) {
              setState(() {
                brithday = date;
              });
              objectCreateCustomer['birthday'] = date.toIso8601String();
            }, currentTime: DateTime.now().toUtc(), locale: LocaleType.vi);
          },
          decoration: InputDecoration(
              hintText: brithday != null
                  ? '${DateTime.parse('$brithday').day}/${DateTime.parse('$brithday').month}/${DateTime.parse('$brithday').year}'
                  : Strings.hint_text_brithday),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.phone,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['phone'] = value;
          },
          initialValue: customer?.phone ?? '',
          validator: (value) {
            if (!value.isEmpty && value.length > 11) {
              return Strings.validate_phone;
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_phone,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Email',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
          ],
        ),
        TextFormField(
//          controller: _email,
          onChanged: (String value) {
            objectCreateCustomer['email'] = value;
          },
          initialValue: customer?.email ?? '',
          validator: (value) {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (!value.isEmpty && !regex.hasMatch(value)) {
              return Strings.empty_email;
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_email,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Strings.gender,
          style: TextStyle(fontSize: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Radio(
                      autofocus: true,
                      value: Strings.key_male,
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) => _handleChangeGender(value)),
                  Text(
                    Strings.male,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Radio(
                      value: Strings.key_female,
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) => _handleChangeGender(value)),
                  Text(Strings.female, style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Radio(
                      value: Strings.key_other,
                      groupValue: gender,
                      activeColor: Colors.blue,
                      onChanged: (value) => _handleChangeGender(value)),
                  Text(
                    Strings.other,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.address,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
//          controller: _address,
          onChanged: (String value) {
            objectCreateCustomer['address'] = value;
          },
          controller: controller.addressController,

//          controller: TextEditingController(
//              text: customer?.address ?? ''),
//          initialValue: customer?.address ?? '',
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_address;
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_address,
          ),
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: 20,
        ),
        Text(Strings.job, style: TextStyle(fontSize: 16.0)),
        TextFormField(
//          controller: _career,
          onChanged: (String value) {
            objectCreateCustomer['job'] = value;
          },
          controller: controller.jobController,
//          controller: TextEditingController(
//              text: customer?.job ?? ''),
//          initialValue: customer?.job ?? '',
          decoration: const InputDecoration(
            hintText: Strings.hint_text_job,
          ),
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: 20,
        ),
        Text(Strings.note, style: TextStyle(fontSize: 16.0)),
        TextFormField(
//          controller: _note,
          onChanged: (String value) {
            objectCreateCustomer['note'] = value;
          },
          initialValue: customer?.note ?? '',
          decoration: const InputDecoration(hintText: Strings.hint_text_note),
          validator: (value) {
//            objectCreateCustomer['note'] = _note.text;
            return null;
          },
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  Widget _formCompanty(BuildContext context, customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.name_company,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['fullName'] = value;
          },
          initialValue: customer?.fullName ?? '',
          decoration: const InputDecoration(
            hintText: Strings.hint_text_name_company,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_name;
            }
            return null;
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.tax_code,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['identity'] = value;
          },
          initialValue: customer?.identity ?? '',
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_tax_code;
            }
            return null;
          },
          decoration:
              const InputDecoration(hintText: Strings.hint_text_tax_code),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.phone,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['phone'] = value;
          },
          initialValue: customer?.phone ?? '',
          validator: (value) {
            if (!value.isEmpty && value.length > 11) {
              return Strings.validate_phone;
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_phone,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Email',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['email'] = value;
          },
          initialValue: customer?.email,
          validator: (value) {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (!value.isEmpty && !regex.hasMatch(value)) {
              return Strings.empty_email;
            }
//            objectCreateCustomer['email'] = _email.text;
            return null;
          },
          // controller: formController,
          decoration: const InputDecoration(
            hintText: Strings.hint_text_email,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.address,
              style: TextStyle(fontSize: 16.0),
            ),
//            SizedBox(
//              width: 1.0,
//            ),
//            Text(
//              '*',
//              style: TextStyle(color: Colors.red),
//            )
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['address'] = value;
          },
          controller: controller.addressController,
//          controller: TextEditingController(
//              text: customer?.address ?? ''),
//          initialValue: customer?.address ?? '',
//          validator: (value) {
//            if (value.isEmpty) {
//              return Strings.empty_address;
//            }
//            return null;
//          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_address,
          ),
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: 20,
        ),
        Text(Strings.note, style: TextStyle(fontSize: 16.0)),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['note'] = value;
          },
          initialValue: customer?.note ?? '',
          validator: (value) {
            return null;
          },
          decoration: const InputDecoration(hintText: Strings.hint_text_note),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  handleShowMessage(
      BuildContext context, CustomerController controller, String param) async {
    final result = controller.customerUpdateReponse;
    if (flagCheckClickButton == true) {
      if (result?.statusCode == 200) {
        flagCheckClickButton = false;
        Fluttertoast.showToast(
          msg: Strings.update_success_customer,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerDetail(
                param: widget.param, idCustomer: widget.customer.result.id),
          ),
        );
      } else {
        flagCheckClickButton = false;
        Fluttertoast.showToast(
          msg: result?.error?.message != null ? Utils.mapKeyToMessageErr(result.error.message) :
              Strings.update_fail,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}

class CustomerEditKeys {
  static final riKey = const Key('__UPDATE_CUSTOMER__');
}
