import 'package:flutter/cupertino.dart';
import 'package:load/load.dart';
import 'package:mobile/src/app/pages/user_profile/user_profile_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/BaseResponse.dart';
import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:path/path.dart';

class UserProfileController extends Controller {
  final UserProfilePresenter userProfilePresenter;
  BuildContext context;
  UserInfor _userInfor;
  UserInfor get userInfor => _userInfor;
  bool isChangePassSuccess = false;

  TextEditingController currentPasswordController = new TextEditingController();

  TextEditingController newPasswordController = new TextEditingController();

  TextEditingController confirmNewPasswordController =
      new TextEditingController();

  UserProfileController(userProfileRepo)
      : userProfilePresenter = UserProfilePresenter(userProfileRepo),
        super();

  var formKey = GlobalKey<FormState>();

  void forgotPassword() {
    showLoadingDialog();
    refreshUI();
//    userProfilePresenter.forgotPassword(currentPasswordController.text, newPasswordController.text, confirmNewPasswordController.text);
    userProfilePresenter.forgotPassword(currentPasswordController.text,
        newPasswordController.text, confirmNewPasswordController.text);
  }

  void getUserInfor() async {
    _userInfor = await LocalStorageService.getUserInfor();
    refreshUI();
  }

  @override
  void initListeners() {
    userProfilePresenter.forgotPassOnNext =
        (ChangePassResponse changePassResponse) {
      if (changePassResponse.statusCode == 200) {
        isChangePassSuccess = true;
        refreshUI();
        DialogUtilities.showSimpleDialog(context, Strings.success_text,
            Strings.success_change_pass, Strings.OK_TEXT, null);
      } else {
        DialogUtilities.showSimpleDialog(
            context,
            Strings.error_text,
            Utils.mapKeyToMessageErr(changePassResponse.error.message),
            Strings.OK_TEXT,
            null);
      }
      hideLoadingDialog();
    };

    userProfilePresenter.forgotPassOnComplete = () {
      isChangePassSuccess = true;
      refreshUI();
      hideLoadingDialog();
    };

    userProfilePresenter.forgotPassOnError = () {
      isChangePassSuccess = false;
      refreshUI();
    };
  }
}
