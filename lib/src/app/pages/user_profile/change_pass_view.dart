import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile/src/app/pages/user_profile/user_profile_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/repositories/user_profile/user_profile_repository.dart';
import 'package:mobile/src/utility/Dimens.dart';
import 'package:mobile/src/utility/EditPassUtilities.dart';
import 'package:mobile/src/utility/FontSize.dart';
import 'package:mobile/src/utility/Strings.dart';

class ChangePassView extends View {
  ChangePassView({Key key}) : super(key: key);

  @override
  ChangePassState createState() => ChangePassState();
}

class ChangePassState extends ViewState<ChangePassView, UserProfileController> {
  ChangePassState() : super(UserProfileController(UserProfileRepository()));

  Size _size;
  bool isCheckLoginButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.context = context;
  }

  @override
  Widget buildPage() {
    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;

    _size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.keyboard_backspace),
                    //Image.asset(ImagePath.ic_back),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                    padding:
                        EdgeInsets.only(left: Dimens.appBarTitleMarginLeft),
                    child: Text(Strings.changePassWordTitle,
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.appBarTitleSize,
                            color: Colors.white)))
              ],
            ),
          ),
        ),
        body: Container(
          child: SafeArea(
              child: SingleChildScrollView(
            child: Container(
              height: _size.height,
              child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      EditPassUtilities.buildEditText(
                          context,
                          Strings.currentPassword,
                          Strings.currentPasswordHint,
                          controller.currentPasswordController,
                          isMandatory: true),
                      EditPassUtilities.buildEditText(
                          context,
                          Strings.newPassword,
                          Strings.newPasswordConfirm,
                          controller.newPasswordController,
                          isMandatory: true),
                      EditPassUtilities.buildEditText(
                          context,
                          Strings.newPasswordConfirm,
                          Strings.newPasswordConfirmHint,
                          controller.confirmNewPasswordController,
                          isMandatory: true),
//                      Expanded(child: Container(height: 00.0,)),
                    ],
                  )),
            ),
          )),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
          width: _size.width,
          decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: FlatButton(
            textColor: Colors.white,
            child: Text(
              Strings.save_text,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              if (controller.formKey.currentState.validate()) {
                isCheckLoginButton = true;
                controller.forgotPassword();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}
