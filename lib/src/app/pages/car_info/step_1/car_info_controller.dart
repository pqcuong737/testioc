import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:load/load.dart';
import 'package:mobile/main.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/cars/TypeCarResponse.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/DateUtilities.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/Utils.dart';

class CarInfoController extends Controller {
  final CarInfoPresenter carInfoPresenter;
  BuildContext context;
  TextEditingController carNumberController = new TextEditingController();
  TextEditingController carNumberChassisController =
      new TextEditingController();
  TextEditingController carNumberEngineController = new TextEditingController();
  TextEditingController carContractNumberController =
      new TextEditingController();
  TextEditingController carPaidNumberController = new TextEditingController();
  TextEditingController carAppliedDayController = new TextEditingController();
  MoneyMaskedTextController carPrizeController = new MoneyMaskedTextController(
      initialValue: 0,
      thousandSeparator: ',',
      decimalSeparator: '',
      precision: 0,
      rightSymbol: '');

  TextEditingController carBrandController = new TextEditingController();
  ValueNotifier<List<String>> carBrandList =
      ValueNotifier<List<String>>(<String>[]);
  TextEditingController carLineController = new TextEditingController();
  ValueNotifier<List<String>> carLineList =
      ValueNotifier<List<String>>(<String>[]);

  TextEditingController carCylinderController = new TextEditingController();

  TextEditingController carYearManufactureController =
      new TextEditingController();
  ValueNotifier<List<String>> carYearManufactureList =
      ValueNotifier<List<String>>(<String>[]);
  TextEditingController carYearOfUseController = new TextEditingController();
  ValueNotifier<List<String>> carYearOfUseList =
      ValueNotifier<List<String>>(<String>[]);
  var formKey = GlobalKey<FormState>();

  // Presenter should always be initialized this way
  CarInfoController(carInfoRepo, profileRepo)
      : carInfoPresenter = CarInfoPresenter(carInfoRepo, profileRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    if (MyApp.carInfo.mapCarLine.isNotEmpty)
      carBrandList.value =
          MyApp.carInfo.mapCarLine.keys.map((v) => v.name).toList();
    carInfoPresenter.getTypeCarInfo = (TypeCarResponse response) {
      final listCar = List<String>();
      for (var item in response.result.items) {
        listCar.add(item.name);
        MyApp.carInfo.mapCarLine[item] = item.cars;
      }
      carBrandList.value = listCar;
    };

    carBrandController.addListener(() {
      final selectedValue = carBrandController.text;
      final selectedCar = MyApp.carInfo.mapCarLine.keys
          .firstWhere((v) => v.name == selectedValue);
      carLineList.value =
          MyApp.carInfo.mapCarLine[selectedCar].map((v) => v.name).toList();
    });

    carInfoPresenter.createProfilesOnError = () {
      hideLoadingDialog();
    };
    carInfoPresenter.createProfilesOnComplete = () {
      hideLoadingDialog();
    };

    carInfoPresenter.createProfilesOnNext = (CreateProfileResponse response) {
      hideLoadingDialog();
      if (response.statusCode == 200)
        DialogUtilities.showSimpleDialog(
            context, 'Thông báo', 'Lưu tạm hồ sơ thành công', 'Ok', () {
          carInfoPresenter.navigateBackToHome();
        });
      else {
        DialogUtilities.showSimpleDialog(
            context,
            'Lỗi',
            'code: ${response.statusCode} + message:  ${response.errorDocument != null ? (response.errorDocument.errorDocument != null ? response.errorDocument.errorDocument[0].error : response.errorDocument.message) : ''} ',
            'Ok',
            null);
      }
    };

    final currentYear = int.parse(DateUtilities.formatYear(new DateTime.now()));
    for (int i = currentYear - 10; i <= currentYear; i++) {
      carYearManufactureList.value.add(i.toString());
    }
    for (int i = 1; i <= 15; i++) {
      carYearOfUseList.value.add(i.toString());
    }
  }

  void updateData(CarProfileData data) {
    data.licensePlates = carNumberController.text;
    data.chassisNumber = carNumberChassisController.text;
    data.vehicleNumber = carNumberEngineController.text;
    data.printeMattersNumber = carPaidNumberController.text;
    data.contractNumber = carContractNumberController.text;
    data.effectiveDate = carAppliedDayController.text;
    data.priceCar = carPrizeController.text.isEmpty
        ? null
        : carPrizeController.numberValue.toInt();
    data.manufacturingYear = carYearManufactureController.text == null
        ? 0
        : int.parse(carYearManufactureController.text);
    data.usedYear = carYearOfUseController.text.isEmpty
        ? null
        : int.parse(carYearOfUseController.text);
    data.typeCar = carBrandController.text;
    data.car = carLineController.text;
    data.cylinder = carCylinderController.text;
    data.categoryId = getCategoryId();
  }

  void loadData(CarProfileData data) {
    carNumberController.text = data.licensePlates;
    carNumberChassisController.text = data.chassisNumber;
    carNumberEngineController.text = data.vehicleNumber;
    carPaidNumberController.text = data.printeMattersNumber;
    carContractNumberController.text = data.contractNumber;
    String effectiveData = data.effectiveDate != null
        ? data.effectiveDate
//        DateUtilities.effectiveDate(DateTime.parse(data.effectiveDate))
        : '';
    carAppliedDayController.text = effectiveData;
    carPrizeController
        .updateValue(data.priceCar == null ? 0 : data.priceCar.toDouble());
    carYearManufactureController.text =
        data.manufacturingYear != null ? '${data.manufacturingYear}' : '0';
    carYearOfUseController.text =
        data.usedYear == null ? '' : data.usedYear.toString();
    carBrandController.text = data.typeCar;
    carLineController.text = data.car;
    carCylinderController.text = data.cylinder;
  }

  MapEntry<String, CarProfileData> createNewProfileData() {
    final profileNumber = LocalStorageService.getProfileCount();
    return MapEntry('PROFILE_$profileNumber', CarProfileData());
  }

  int getCategoryId() {
    final selectedCarValue = carBrandController.text;
    final selectedTypeCarValue = carLineController.text;
    if (selectedCarValue.isEmpty || selectedTypeCarValue.isEmpty) return null;
    final selectedCar = MyApp.carInfo.mapCarLine.keys
        .firstWhere((v) => v.name == selectedCarValue);
    final listTypeCar = MyApp.carInfo.mapCarLine[selectedCar];
    final carId =
        listTypeCar.firstWhere((car) => car.name == selectedTypeCarValue).id;
    return carId;
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    carInfoPresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }

  Future<void> sendProfileRequest(CarProfileData data) async {
    showLoadingDialog();
    final request = await Utils.generateCarRequest(data, false);
    LoggerUtil().logger.d("generateCarRequest finished");
    carInfoPresenter.createProfile(request);
  }
}
