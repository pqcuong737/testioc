import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
import 'package:mobile/src/app/pages/customer/view/review_customer_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/customer/customer_repository.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';
import 'package:mobile/src/utility/APIProvider.dart';


class CustomerCreateForm extends View {
  //  CustomerCreateForm({ Key: key }) : super(key: key);
  final String param;

  CustomerCreateForm(this.param);

  @override
  _CustomerCreateState createState() => _CustomerCreateState();
}

class _CustomerCreateState
    extends ViewState<CustomerCreateForm, CustomerController> {
  _CustomerCreateState() : super(CustomerController(CustomerRespository())) {}
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  PageController _pageController;
  CarProfileData dataIocOffline;

  var gender;
  var options;
  var brithday;
  var typeCheck;
  bool flagCheckClickButton = false;
  bool isOnline = true;

  Map<String, dynamic> objectCreateCustomer = new Map();
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    gender = Strings.key_male;
    brithday = null;
    options = typeCheck != null ? typeCheck : Strings.key_personal;
    objectCreateCustomer['gender'] = gender;
    objectCreateCustomer['type'] = options;
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => handleShowMessage(context, controller, widget.param));
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
  }

  void _onConnectivityListener(bool value) {
    setState(() {
      isOnline = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    LocalStorageService.saveTypeCustomer('emty');
  }

  _handleChangeOption(value) {
    setState(() {
      options = value;
    });

    _formKey.currentState.reset();
    objectCreateCustomer.clear();
    objectCreateCustomer['type'] = value;
    brithday = null;
    flagCheckClickButton = false;
    if (options == Strings.key_personal) {
      objectCreateCustomer['gender'] = gender;
    }
    LocalStorageService.saveTypeCustomer(value);
  }

  _handleChangeGender(value) {
    setState(() {
      gender = value;
    });
    objectCreateCustomer['gender'] = value;
  }

  @override
  Widget buildPage() {
    flagCheckClickButton ? initState() : null;
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
              Strings.create_customer,
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
          body: SafeArea(
            bottom: true,
            top: true,
            right: true,
            left: true,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  (isOnline == false)
                      ? WidgetUitlites.offlineView(context)
                      : SizedBox(),
                  WidgetUitlites.processBarWidget(context),
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
                                      ? _formPersonal(context)
                                      : _formCompanty(context),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 40.0),
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.amber[700],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: FlatButton(
                                    textColor: Colors.white,
                                    child: Text(
                                      Strings.DONE,
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (isOnline == false) return null;
                                      final form = _formKey.currentState;
                                      if (form.validate()) {
                                        flagCheckClickButton = true;
                                        LocalStorageService.saveTypeCustomer(
                                            objectCreateCustomer['type']);

                                        typeCheck = await LocalStorageService
                                            .getTypeCustomer();
                                        print(
                                            "Xxxxxxxxxxxxxxx$objectCreateCustomer");
                                        controller
                                            .functionCreateCustomerController(
                                                objectCreateCustomer);
                                      }
                                    },
                                  ),
                                )
                              ],
                            )),
                      )),
                ],
              ),
            ),
          )),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  Widget _formPersonal(BuildContext context) {
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
            // labelText: "Họ và tên",
          ),
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
            // Text(
            //   '*',
            //   style: TextStyle(color: Colors.red),
            // )
          ],
        ),
        TextFormField(
//          controller: _identity,
          onChanged: (String value) {
            objectCreateCustomer['identity'] = value;
          },
//           validator: (value) {
//             if (value.isEmpty) {
//               return Strings.empty_identity;
//             }
// //            objectCreateCustomer['identity'] = _identity.text;
//             return null;
//           },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_identity,
            // labelText: ""
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
          // validator: (value) {
          //   if (brithday != null) {
          //     value = '$brithday';
          //   }
          //   if (value.isEmpty) {
          //     return Strings.empty_brithday;
          //   }
          //   return null;
          // },
          onTap: () {
//            selectDate(context);
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
                  ?
                  // '${DateFormat.yMd().format(DateTime.parse('$brithday'))}'
                  '${DateTime.parse('$brithday').day}/${DateTime.parse('$brithday').month}/${DateTime.parse('$brithday').year}'
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
            // Text(
            //   '*',
            //   style: TextStyle(color: Colors.red),
            // )
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['phone'] = value;
          },
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
            // Text(
            //   '*',
            //   style: TextStyle(color: Colors.red),
            // )
          ],
        ),
        TextFormField(
//          controller: _email,
          onChanged: (String value) {
            objectCreateCustomer['email'] = value;
          },
          onSaved: (String value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (value) {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern);
            if (!value.isEmpty && !regex.hasMatch(value)) {
              return Strings.empty_email;
            }
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
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_address;
            }
//            objectCreateCustomer['address'] = _address.text;
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
//           validator: (value) {
//             if (value.isEmpty) {
//               return Strings.empty_job;
//             }
// //            objectCreateCustomer['career'] = _career.text;
//             return null;
          // },
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

  Widget _formCompanty(BuildContext context) {
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
          decoration: const InputDecoration(
            hintText: Strings.hint_text_name_company,
            // labelText: "Họ và tên",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_name;
            }
//            objectCreateCustomer['fullName'] = _fullName.text;
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
          //  controller: _tax_code,
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_tax_code;
            }
//            objectCreateCustomer['tax_code'] = _tax_code.text;
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
            // Text(
            //   '*',
            //   style: TextStyle(color: Colors.red),
            // )
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['phone'] = value;
          },
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
            // Text(
            //   '*',
            //   style: TextStyle(color: Colors.red),
            // )
          ],
        ),
        TextFormField(
          onChanged: (String value) {
            objectCreateCustomer['email'] = value;
          },
//          controller: _email,
          onSaved: (String value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
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
//          controller: _addresfemales,
          onChanged: (String value) {
            objectCreateCustomer['address'] = value;
          },
//          validator: (value) {
//            if (value.isEmpty) {
//              return Strings.empty_address;
//            }
////            objectCreateCustomer['address'] = _address.text;
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
//          controller: _note,
          validator: (value) {
//            objectCreateCustomer['note'] = _note.text;
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
    final result = controller.createCustomerResponse;
    if (flagCheckClickButton == true) {
      if (result?.statusCode == 200) {
        flagCheckClickButton = false;
        Fluttertoast.showToast(
          msg: Strings.create_succress_customer,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (widget.param == Constant.key_create_when_searching) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReviewCustomerPage(
                    dataIocOffline: dataIocOffline,
                    idCustomer: result.result?.id)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerListPage(param: widget.param),
            ),
          );
        }
      } else {
        flagCheckClickButton = false;
        Fluttertoast.showToast(
          msg: result?.error?.message != null ? Utils.mapKeyToMessageErr(result.error.message) :
              Strings.create_fail,
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
    // setState(() {
    //   isOnline = result;
    // });
  }
}
