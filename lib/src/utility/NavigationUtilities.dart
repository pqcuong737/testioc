import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorUtilities {
  static void pushAndRemoveUntil(BuildContext context, StatefulWidget screen) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        screen), (Route<dynamic> route) => false);
  }

  static Future<String> push(BuildContext context, StatefulWidget screen) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => screen,
    ));
  }
}