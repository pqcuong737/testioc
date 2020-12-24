import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/app/pages/user_profile/user_profile_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/repositories/user_profile/user_profile_repository.dart';
import 'package:mobile/src/utility/DateUtilities.dart';
import 'package:mobile/src/utility/Dimens.dart';
import 'package:mobile/src/utility/FontSize.dart';
import 'package:mobile/src/utility/Strings.dart';

class InviDualInforView extends View {
  InviDualInforView({Key key}) : super(key: key);

  @override
  InviDualInforViewState createState() => InviDualInforViewState();
}

class InviDualInforViewState
    extends ViewState<InviDualInforView, UserProfileController> {
  InviDualInforViewState()
      : super(UserProfileController(UserProfileRepository()));

  Map<String, dynamic> objectCreateCustomer = new Map();
  double paddingTop = 8.0;
  var gender;
  var options;
  var brithday;
  var typeCheck;
  bool flagCheckClickButton = false;

  @override
  Widget buildPage() {
    if (controller.userInfor == null) {
      controller.getUserInfor();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons
                        .keyboard_backspace), //Image.asset(ImagePath.ic_back),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                    padding:
                        EdgeInsets.only(left: Dimens.appBarTitleMarginLeft),
                    child: Text(Strings.invidualInfor,
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.appBarTitleSize,
                            color: Colors.white)))
              ],
            ),
          ),
        ),
        body: SafeArea(
          bottom: true,
          top: true,
          right: true,
          left: true,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Form(
//                      key: _formKey,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(child: _formPersonal(context)),
                    ],
                  )),
                )),
          ),
        ),
      ),
    );
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
              '',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
          controller: TextEditingController(
              text: controller.userInfor != null
                  ? controller.userInfor.result.fullName
                  : ""),
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
        Text(
          Strings.brithday,
          style: TextStyle(fontSize: 16.0),
        ),
        TextFormField(
          validator: (value) {
            if (brithday != null) {
              value = '$brithday';
            }
            if (value.isEmpty) {
              return Strings.empty_brithday;
            }
            return null;
          },
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
                  ? '${DateFormat.yMd().format(DateTime.parse('$brithday'))}'
                  : Strings.hint_text_brithday),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Strings.gender,
          style: TextStyle(fontSize: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
              Strings.phone,
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
          controller: TextEditingController(
              text: (controller.userInfor != null &&
                      controller.userInfor.result.phone != null)
                  ? controller.userInfor.result.phone
                  : ""),
          onChanged: (String value) {
            objectCreateCustomer['phone'] = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_phone;
            } else if (value.length > 11) {
              return Strings.validate_phone;
            }
//            objectCreateCustomer['phone'] = _phone.text;
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
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
          controller: TextEditingController(
              text: (controller.userInfor != null &&
                      controller.userInfor.result.email != null)
                  ? controller.userInfor.result.email
                  : ""),
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
            if (!regex.hasMatch(value)) {
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
          height: 100,
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
            Text(
              '*',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
          controller: TextEditingController(
              text: (controller.userInfor != null &&
                      controller.userInfor.result.identity != null)
                  ? controller.userInfor.result.identity
                  : ""),
          onChanged: (String value) {
            objectCreateCustomer['identity'] = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_identity;
            }
//            objectCreateCustomer['identity'] = _identity.text;
            return null;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_identity,
            // labelText: ""
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.date_grant,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              width: 1.0,
            ),
            Text(
              '',
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        TextFormField(
          controller: TextEditingController(
              text: (controller.userInfor != null &&
                      controller.userInfor.result.dateIssue != null)
                  ? DateUtilities.effectiveDate(
                      DateTime.parse(controller.userInfor.result.dateIssue))
                  : ""),
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
            hintText: Strings.hint_text_create_cmnd,
          ),
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: 20,
        ),
        Text(Strings.place_grant, style: TextStyle(fontSize: 16.0)),
        TextFormField(
          controller: TextEditingController(
              text: (controller.userInfor != null &&
                      controller.userInfor.result.placeIssue != null)
                  ? controller.userInfor.result.placeIssue
                  : ""),
          onChanged: (String value) {
            objectCreateCustomer['job'] = value;
          },
          validator: (value) {
            if (value.isEmpty) {
              return Strings.empty_job;
            }
//            objectCreateCustomer['career'] = _career.text;
            return null;
          },
          decoration: const InputDecoration(
            hintText: Strings.hint_text_job,
          ),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  _handleChangeGender(value) {
    setState(() {
      gender = value;
    });
    objectCreateCustomer['gender'] = value;
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}
