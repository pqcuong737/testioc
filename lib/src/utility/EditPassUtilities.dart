import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/utility/DateUtilities.dart';

import 'Strings.dart';

class EditPassUtilities {
  static Widget buildEditText(
      BuildContext context,
      String label,
      String hint,
      TextEditingController controller,
      {bool isNumberInput = false, bool isMandatory = false}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: label, style: Theme
                      .of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black)),
                  TextSpan(text: isMandatory ? ' *' : '', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty && isMandatory) {
                  return 'Vui lòng điền thông tin bắt buộc';
                }
                return null;
              },
              obscureText: true,
              controller: controller,
              keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                Theme
                    .of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.grey),
              ),
              style: Theme
                  .of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.black),
            ),
          ],
        )
    );
  }

  static AppBar buildAppBar(BuildContext context, String title, String currentStep) {
    return AppBar(
      backgroundColor: Colors.blue[600],
      title: Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.keyboard_backspace),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(title,
                      style:
                      TextStyle(color: Colors.white, fontSize: 25.0)),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(Strings.step,
                      style:
                      TextStyle(fontSize: 16.0, color: Colors.white)),
                  SizedBox(width: 5),
                  Text('$currentStep/4',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget buildMoneyEditText(
      BuildContext context,
      String label,
      String hint,
      MoneyMaskedTextController controller,
      {bool isMandatory = false}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: label, style: Theme
                      .of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black)),
                  TextSpan(text: isMandatory ? ' *' : '', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty && isMandatory) {
                  return 'Vui lòng điền thông tin bắt buộc';
                }
                return null;
              },
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle:
                Theme
                    .of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.grey),
              ),
              style: Theme
                  .of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        )
    );
  }

  static Widget buildFooter(BuildContext context, Function clickSave, Function clickNext) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration:
              BoxDecoration(border: Border.all(color: Colors.orangeAccent)),
              child: InkWell(
                onTap: clickSave,
                child: Text(Strings.save_temporary,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.orangeAccent)),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              color: Colors.orangeAccent,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: clickNext,
                child: Text(Strings.next,
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget buildDropdown(BuildContext context, String label, List<String> data, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              builder: (BuildContext context, TextEditingValue value, Widget child) {
                return TextFormField(
                  controller: controller,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: Theme
                        .of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black),
                  ),
                  style: Theme
                      .of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black),
                );
              },
              valueListenable: controller,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: DropdownButton<String>(
                      iconSize: 0,
                      underline: Container(
                        height: 0,
                        color: Colors.white,
                      ),
                      onChanged: (String newValue) {
                        controller.text = newValue;
                      },
                      items: data.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body2
                                  .copyWith(color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 25.0,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  static Widget buildCalendarPicker(BuildContext context, String label, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              builder: (BuildContext context, TextEditingValue value, Widget child) {
                return TextFormField(
                  controller: controller,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: Theme
                        .of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black),
                  ),
                  style: Theme
                      .of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black),
                );
              },
              valueListenable: controller,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DatePicker.showDatePicker(context,
                              onConfirm: (date) {
                                controller.text = DateUtilities.formatDate(date);
                              }, currentTime: DateTime.now(), locale: LocaleType.vi);
                        },
                        child: Text('',)),
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: 25.0,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
