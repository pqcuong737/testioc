import 'package:mobile/src/app/pages/setting/setting_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';

class SettingController extends Controller {

  final SettingPresenter settingPresenter;
  // Presenter should always be initialized this way
  SettingController(usersRepo)
      : settingPresenter = SettingPresenter(),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    settingPresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }
}
