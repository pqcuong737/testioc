import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnicalPage extends StatefulWidget {
  @override
  _TechnicalPageState createState() => _TechnicalPageState();
}

class _TechnicalPageState extends State<TechnicalPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primaryColor: Colors.grey[150]),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[600],
            leading: IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.keyboard_backspace),
                color: Colors.white,
                onPressed: () => Navigator.pop(context)),
            title: Text(
              Strings.tech,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: SafeArea(
                top: true,
                left: true,
                bottom: true,
                right: true,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        ImagePath.img_setting,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        Strings.title_tech,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[300]))),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        Strings.description_tech,
                        style: TextStyle(fontSize: 16.0, height: 1.65),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            Strings.name_company_support,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      showInfoSupport(context, "Email:",
                          Strings.email_company_support, true, false),
                      SizedBox(
                        height: 18.0,
                      ),
                      showInfoSupport(context, "Hotline:",
                          Strings.hotline_company_support, false, false),
                      SizedBox(
                        height: 18.0,
                      ),
                      showInfoSupport(context, "Website",
                          Strings.website_company_support, false, true),
                      SizedBox(
                        height: 35.0,
                      ),
                      Text(
                        Strings.title_support_user,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18.0
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[300]))),
                      ),
                      SizedBox(
                          height: 18.0
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            Strings.name_company_support_user,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 18.0
                      ),
                  showInfoSupport(context, "Địa chỉ",
                      Strings.address_company_support_user, false, false),
                      SizedBox(
                          height: 18.0
                      ),
                      showInfoSupport(context, "Điện thoại",
                          Strings.phone_support_user, false, false),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget showInfoSupport(BuildContext context, String lable, String text,
      bool isColor, bool isLink) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          lable,
          style: TextStyle(color: Colors.grey, fontSize: 16.0),
        ),
        isLink
            ? RichText(
                text: TextSpan(
                text: text,
                style: TextStyle(color: Colors.blue, fontSize: 16.0, decoration: TextDecoration.underline),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () async {
                   await launch(text);
                  },
              ))
            : Container(
              width: 220.0,
              child: Text(
                  text,
                  style: TextStyle(
                      color: isColor ? Colors.blue : Colors.black,
                      fontSize: 16.0,),
                      textAlign:
                  TextAlign.right,
                ),
            ),
      ],
    );
  }
}
