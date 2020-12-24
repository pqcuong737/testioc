import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/app/pages/login_screen/login_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class SplashScreen extends View {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Size _size;
  Timer _timer;

  SplashScreenState() {
    Utils.isInternetConnected().then((isInternetConnection) {
      if (isInternetConnection) {
        _timer = new Timer(const Duration(seconds: 3), () async {
          bool checkTokenValid = await Utils.checkTokenValid();
          if (checkTokenValid) {
            UserInfor userInfor = await LocalStorageService.getUserInfor();
            NavigatorUtilities.pushAndRemoveUntil(context,
                checkTokenValid ? MainHomePage(userInfor) : LoginScreen());
          } else {
            NavigatorUtilities.pushAndRemoveUntil(context, LoginScreen());
          }
        });
      } else {
        LocalStorageService.getUserInfor().then((value) => {
              /*
            24/11/2020 Vietsaclo da sua
            Logic code: value.result co the = null nen khong the .fullName:
            origanal: 
            if (value.result.fullName != null)
                {
                  NavigatorUtilities.pushAndRemoveUntil(
                      context, MainHomePage(value))
                }
            fix:
            if (value == null || value.result == null || value.result.fullName != null)
                {
                  NavigatorUtilities.pushAndRemoveUntil(
                      context, MainHomePage(value))
                }
          */
              if (value == null ||
                  value.result == null ||
                  value.result.fullName != null)
                {
                  NavigatorUtilities.pushAndRemoveUntil(
                      context, MainHomePage(value))
                }
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Image.asset(
                ImagePath.background,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(_size.width / 13, _size.height / 6,
                  _size.width / 13, _size.height / 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  Expanded(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          ImagePath.ic_branding,
                          height: 52,
                          width: 52,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Text(Strings.most_popular_branch,
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        color: Colors.amberAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)))
                      ],
                    ),
                  )),
                  _buildAddress()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _size.width / 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            ImagePath.logo,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
              child: Text(
            Strings.company_name,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            Strings.company_subtitle,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FittedBox(
            child: new Text(
          Strings.company_address,
          style:
              Theme.of(context).textTheme.subhead.copyWith(color: Colors.white),
          maxLines: 1,
        )),
        SizedBox(
          height: 15,
        ),
        Text('028 3824 7575 - 1900 558899',
            style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
        SizedBox(
          height: 30,
        ),
        Text(
          Strings.loading,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Colors.white, fontWeight: FontWeight.w200),
        )
      ],
    );
  }
}
