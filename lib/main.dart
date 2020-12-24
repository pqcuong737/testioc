import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:mobile/src/MyRouter.dart';
import 'package:mobile/src/app/pages/splash/splash_view.dart';
import 'package:mobile/src/domain/entities/cars/CarInfo.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';

void main() {
  MyRouter.setupRouter();
  runApp(LoadingProvider(child: MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static CarInfo carInfo = CarInfo();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
//     progressSubject.listen((event) {
// //      print("------> $event"); // t
//     });
    super.initState();
  }

  final key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LoggerUtil().debugModeOn();
    LocalStorageService.getInstance();
    return MaterialApp(
      navigatorKey: key,
      initialRoute: '/',
      onGenerateRoute: MyRouter.router.generator,
      title: '',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
