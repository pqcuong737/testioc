import 'package:flutter/cupertino.dart';
import 'package:load/load.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/usecases/profile/create_profile.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/Utils.dart';

import 'car_status_presenter.dart';

class CarStatusController extends Controller {
  final CarStatusPresenter carStatusPresenter;
  BuildContext context;
  final List<String> carStatusList = <String>[
    'Hư hỏng nhẹ',
    'Có trầy xướt',
    'Như mới',
    'Hoạt động bình thường'
  ];
  final TextEditingController carStatusController = new TextEditingController();
  final ValueNotifier isOnCarStatus = ValueNotifier<bool>(false);
  final TextEditingController carScratchController =
      new TextEditingController();
  final ValueNotifier isOnCarScratch = ValueNotifier<bool>(false);
  final TextEditingController carUpgradeController =
      new TextEditingController();
  final ValueNotifier isExtraAccessories = ValueNotifier<bool>(false);
  final TextEditingController otherNoteController = new TextEditingController();

  CarStatusController(profileRepo)
      : carStatusPresenter = CarStatusPresenter(profileRepo),
        super();

  void updateData(CarProfileData data) {
    data.vehicleStatus = carStatusController.text;
    data.vehicleStatusIsNormal = isOnCarStatus.value;
    data.extraAccessories = isExtraAccessories.value;
    data.upgradeCar = carUpgradeController.text;
    data.scratches = carScratchController.text;
    data.isScratched = isOnCarScratch.value;
    data.note = otherNoteController.text;
  }

  void loadData(CarProfileData data) {
    carStatusController.text = data.vehicleStatus;
    isOnCarStatus.value =
        (data.vehicleStatus == null || data.vehicleStatus.isEmpty)
            ? false
            : true;
    isExtraAccessories.value =
        (data.upgradeCar == null || data.upgradeCar.isEmpty) ? false : true;
    isOnCarScratch.value =
        (data.scratches == null || data.scratches.isEmpty) ? false : true;
    carScratchController.text = data.scratches;
    otherNoteController.text = data.note;
    carUpgradeController.text = data.upgradeCar;
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    carStatusPresenter.createProfilesOnError = () {
      hideLoadingDialog();
    };

    carStatusPresenter.createProfilesOnComplete = () {
      hideLoadingDialog();
    };

    carStatusPresenter.createProfilesOnNext = (CreateProfileResponse response) {
      hideLoadingDialog();
      if (response.statusCode == 200)
        DialogUtilities.showSimpleDialog(
            context, 'Thông báo', 'Lưu tạm hồ sơ thành công', 'Ok', () {
          carStatusPresenter.navigateBackToHome();
        });
      else
        DialogUtilities.showSimpleDialog(
            context,
            'Lỗi',
            'code: ${response.statusCode} + message:  ${response.errorDocument != null ? (response.errorDocument.errorDocument != null ? response.errorDocument.errorDocument[0].error : response.errorDocument.message) : ''} ',
            'Ok',
            null);
    };
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    carStatusPresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }

  Future<void> sendProfileRequest(CarProfileData data) async {
    showLoadingDialog();
    final request = await Utils.generateCarRequest(data, false);
    DataProfile dataProfile = new DataProfile(request, null);
    carStatusPresenter.createProfile(dataProfile);
  }
}
