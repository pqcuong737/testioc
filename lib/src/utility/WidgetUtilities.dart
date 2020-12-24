import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mobile/src/utility/APIProvider.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/DateUtilities.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';


import 'Strings.dart';

class WidgetUitlites {
  static Widget buildEditText(BuildContext context, String label, String hint,
      TextEditingController controller,
      {bool isNumberInput = false, bool isMandatory = false}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: label,
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(color: Colors.black)),
                  TextSpan(
                      text: isMandatory ? ' *' : '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
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
              keyboardType:
                  isNumberInput ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.black),
            ),
          ],
        ));
  }

  static AppBar buildAppBar(
      BuildContext context, String title, String currentStep,
      {Function cb}) {
    return AppBar(
      backgroundColor: Colors.blue[600],
      leading: IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.keyboard_backspace),
          color: Colors.white,
          onPressed: () {
            if (cb != null)
              cb();
            else
              Navigator.pop(context);
          }),
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 25.0)),
              ),
            ),
            Container(
              child: Text('Bước $currentStep/4',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildMoneyEditText(BuildContext context, String label,
      String hint, MoneyMaskedTextController controller,
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
                  TextSpan(
                      text: label,
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(color: Colors.black)),
                  TextSpan(
                      text: isMandatory ? ' *' : '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.grey),
              ),
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  static Widget buildFooter(
      BuildContext context,
      Function clickSave,
      Function clickNext,
      String isUpdate,
      String isComplete,
      bool isUserOwner) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //TODO if in case update
          isUpdate == Constant.flag_update_ioc
              ? Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Text(Strings.save_temporary,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: Colors.grey)),
                    ),
                  ),
                )
              : Expanded(
                  child: InkWell(
                    onTap: clickSave,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent)),
                      child: Text(Strings.save_temporary,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
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
            child: InkWell(
              onTap:  clickNext,
              child: Container(
                //TODO if not owner and update ioc and at step done => color is grey
                color: Colors.orangeAccent,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    isComplete == Constant.flag_step_completed
                        ? Strings.done
                        : Strings.next,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
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

  static Widget buildDropdown(BuildContext context, String label,
      ValueNotifier<List<String>> data, TextEditingController controller) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              builder:
                  (BuildContext context, TextEditingValue value, Widget child) {
                return TextFormField(
                  controller: controller,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black),
                );
              },
              valueListenable: controller,
            ),
            ValueListenableBuilder(
              builder:
                  (BuildContext context, List<String> value, Widget child) {
                return Container(
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
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          items: value
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                  upStringName(value),
                                  style: Theme.of(context)
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
                );
              },
              valueListenable: data,
            )
          ],
        ));
  }

  static upStringName(value) {
    return '${value.toString()[0].toUpperCase() + value.toString().substring(1)}';
  }
  static Widget buildCalendarPicker(BuildContext context, String label,
      TextEditingController controller, String dateFormat) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder(
              builder:
                  (BuildContext context, TextEditingValue value, Widget child) {
                return TextFormField(
                  controller: controller,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black),
                  ),
                  style: Theme.of(context)
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
                          String text;
                          DatePicker.showDatePicker(context, onConfirm: (date) {
                            LoggerUtil()
                                .logger
                                .d("showDatePicker: " + date.toString());
                            text =
                                DateUtilities.dateWithFormat(date, dateFormat);
                            LoggerUtil().logger.d("showDatePicker: " + text);
                            DatePicker.showTimePicker(context,
                                showTitleActions: true,
                                onConfirm: (date) {
                              text = text +
                                  " " +
                                  DateUtilities.effectiveDateTime(date);
                              controller.text = text;
                            },
                                currentTime: DateTime(0, 0, 0, 0, 0),
                                locale: LocaleType.vi);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.vi);
                        },
                        child: Text(
                          '',
                        )),
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

  static Widget offlineView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.0,
      color: Colors.black87,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              ImagePath.ic_wifi,
              width: 20.0,
              height: 20.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              Strings.text_offline,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  static var mapProcess = {};
  static Widget processBarWidget(BuildContext context) {
    return StreamBuilder(
      stream: progressSubject,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            mapProcess = {};
          } else {
            mapProcess = {...mapProcess, ...snapshot.data};
          }
          for (var entry in mapProcess.entries) {
            if (entry.value == 100) {
              mapProcess.remove(entry.key);
            }
            return entry.value == 100
                ? SizedBox()
                : (entry.value != null
                    ? Text(
                        "Đang upload video. Vui lòng đừng tắt mạng: ${entry.value}%",
                        style: TextStyle(color: Colors.blue),
                      )
                    : '');
          }
        }
        if (snapshot.hasError) {
          return Column(children: <Widget>[
            Icon(Icons.bug_report),
            Text("${snapshot.error}")
          ]);
        }
        return SizedBox();
      },
    );
  }
}
