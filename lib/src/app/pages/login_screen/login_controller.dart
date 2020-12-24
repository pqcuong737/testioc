import 'package:flutter/cupertino.dart';
import 'package:load/load.dart';
import 'package:mobile/src/app/pages/login_screen/login_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';

class LoginScreenController extends Controller {
  final LoginScreenPresenter loginPresenter;
  LoginResponse _loginResponse;
  LoginResponse get loginResponse => _loginResponse;

  String userName;
  String password;

  UserInfor _userInfor;
  UserInfor get userInfor => _userInfor;

  ChangePassResponse _changePassResponse;
  ChangePassResponse get changePassResponse => _changePassResponse;

  //TODO Create text editing
  TextEditingController myEmailListener = new TextEditingController();
  TextEditingController myPasswordListener = new TextEditingController();

  // Presenter should always be initialized this way
  LoginScreenController(usersRepo)
      : loginPresenter = LoginScreenPresenter(usersRepo),
        super();

  @override
  void initListeners() {
    loginPresenter.getLoginOnComplete = () {};

    loginPresenter.getLoginOnError = () {
      _loginResponse = null;
    };

    loginPresenter.getLoginOnNext = (LoginResponse loginResponse) {
      if (loginResponse.statusCode == 200) {
        LocalStorageService.saveToken(loginResponse?.result?.accessToken ?? '');
        LocalStorageService.saveInt(LocalStorageService.TOKEN_EXPIRY_DATE,
            loginResponse.result.expiresIn);
//        LocalStorageService.saveString(
//            LocalStorageService.USER_NAME, this.userName);
        LocalStorageService.saveString(
            LocalStorageService.FRESH_TOKEN, loginResponse.result.refreshToken);
//        LocalStorageService.saveString(
//            LocalStorageService.PASSWORD, this.password);
        _loginResponse = loginResponse;
        loginPresenter.getUserInfor("");
      } else {
        _loginResponse = loginResponse;
        refreshUI();
      }
    };

    loginPresenter.getUserOnNext = (UserInfor userInfor) {
      _userInfor = userInfor;
      LocalStorageService.saveUserInfor(userInfor);
      refreshUI();
    };

    loginPresenter.forgotPasswordOnNext =
        (ChangePassResponse changePassResponse) {
      if (changePassResponse.statusCode == 200) {
      } else {}
      this._changePassResponse = changePassResponse;
      hideLoadingDialog();
      refreshUI();
    };

    loginPresenter.forgotPasswordOnError = () {};
  }

  LoginResponse userAuthenticate(String userId, String password) {
    this.userName = userId;
    this.password = password;
    _loginResponse = loginPresenter.authenticateUser(userId, password);
  }

  void forgotPassword(String email) {
    loginPresenter.forgotPassword(email);
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    loginPresenter.dispose();
  }
}
