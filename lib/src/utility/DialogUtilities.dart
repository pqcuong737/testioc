import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

import 'Strings.dart';

class DialogUtilities {
  static Future<void> showSimpleDialog(BuildContext context,
      String title,
      String message,
      String okBtnTitle,
      Function callback) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(okBtnTitle),
              onPressed: () {
                if(callback != null) callback();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showSimpleDialog2Button(BuildContext context,
      String title,
      String message,
      String okBtnTitle,
      Function(String str) callback,
      String cancelBtnTitle) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        TextEditingController emailTextController = new TextEditingController();
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: emailTextController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          actions: <Widget>[

            FlatButton(
              child: Text(cancelBtnTitle),
              onPressed: () {
                // callback;
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(okBtnTitle),
              onPressed: () {
                // callback;
                if(emailTextController.text.isNotEmpty) {
                  var email = emailTextController.text;
                  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                  if(emailValid) {
                    callback(emailTextController.text);
                    Navigator.of(context).pop();
                  } else {
                    Utils.showToast(Strings.email_invalid);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}