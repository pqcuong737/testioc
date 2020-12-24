import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/app/pages/setting/setting_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/data/repositoty/data_users_repository.dart';

class SettingPage extends View {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => // inject dependencies inwards
      _SettingPageState();
}

class _SettingPageState extends ViewState<SettingPage, SettingController> {
  _SettingPageState() : super(SettingController(DataUsersRepository()));

  Size _size;
  double _headerHeight = 0;

  @override
  Widget buildPage() {
    _size = MediaQuery.of(context).size;
    _headerHeight = _size.height * .22;

    return Scaffold(
        backgroundColor: Colors.grey[100],
        key: globalKey,
        body: _buildSettingPage());
  }

  Widget _buildSettingPage() {
    return Container(
      width: double.infinity,
      height: _size.height * .9,
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Setting",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center),
          ]),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}
