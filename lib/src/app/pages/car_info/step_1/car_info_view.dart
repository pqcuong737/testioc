import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_controller.dart';
import 'package:mobile/src/app/pages/car_info/step_2/car_status_view.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/cars/car_repository.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

class CarInfoPage extends View {
  CarProfileData data;
  String profileId;
  final isUpdate;

  CarInfoPage({Key key, this.data, this.profileId, this.isUpdate})
      : super(key: key);

  @override
  _CarInfoPageState createState() => // inject dependencies inwards
      _CarInfoPageState();
}

class _CarInfoPageState extends ViewState<CarInfoPage, CarInfoController> {
  _CarInfoPageState()
      : super(CarInfoController(CarRepository(), ProfileRepository()));
  bool isOnline = true;
  bool isUserOwner = true;

  @override
  void initState() {
    super.initState();
    controller.context = context;
    controller.carInfoPresenter.getTypeCarData();
    controller.loadData(widget.data);
    controller.carInfoPresenter.navigateBackToHome = () {
      LocalStorageService.deleteProfileData(widget.profileId);
      navigateBackToHome();
    };
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserLocal());
  }

  Future<void> getUserLocal() async {
    final returnIsUserOwner =
        await Utils.isUserCanAction(widget.data.createdById);
    setState(() {
      isUserOwner = returnIsUserOwner;
    });
    isUserOwner = returnIsUserOwner;
  }

  @override
  Widget buildPage() {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primaryColor: Colors.grey[100]),
        home: Scaffold(
          appBar: WidgetUitlites.buildAppBar(context, Strings.car_info, '2'),
          backgroundColor: Colors.grey[100],
          key: globalKey,
          body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                (isOnline == false)
                    ? WidgetUitlites.offlineView(context)
                    : SizedBox(),
                Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      WidgetUitlites.buildEditText(context, Strings.car_number,
                          Strings.car_number, controller.carNumberController,
                          isMandatory: true),
                      WidgetUitlites.buildEditText(
                          context,
                          Strings.car_number_chassis,
                          Strings.car_number_chassis_hint,
                          controller.carNumberChassisController,
                          isMandatory: true),
                      WidgetUitlites.buildEditText(
                          context,
                          Strings.car_number_engine,
                          Strings.car_number_engine_hint,
                          controller.carNumberEngineController),
                      WidgetUitlites.buildEditText(
                          context,
                          Strings.car_contract_number,
                          Strings.car_contract_number_hint,
                          controller.carContractNumberController,
                          isNumberInput: true,
                          isMandatory: true),
                      WidgetUitlites.buildEditText(
                          context,
                          Strings.car_paid_number,
                          Strings.car_paid_number_hint,
                          controller.carPaidNumberController,
                          isNumberInput: true,
                          isMandatory: true),
                      WidgetUitlites.buildCalendarPicker(
                          context,
                          Strings.car_applied_day,
                          controller.carAppliedDayController,
                          'dd/MM/yyyy'),
                      WidgetUitlites.buildDropdown(
                          context,
                          Strings.car_brand,
                          controller.carBrandList,
                          controller.carBrandController),
                      WidgetUitlites.buildDropdown(context, Strings.car_line,
                          controller.carLineList, controller.carLineController),
                      WidgetUitlites.buildEditText(
                          context,
                          Strings.car_capacity,
                          Strings.car_capacity,
                          controller.carCylinderController),
                      WidgetUitlites.buildMoneyEditText(
                          context,
                          Strings.car_value,
                          Strings.car_value,
                          controller.carPrizeController),
//                      WidgetUitlites.buildCalendarPicker(context,
//                          Strings.car_manufactured_year,
//                          controller.carYearManufactureController,
//                          'MM-yyyy'),
                      WidgetUitlites.buildDropdown(
                          context,
                          Strings.car_manufactured_year,
                          controller.carYearManufactureList,
                          controller.carYearManufactureController),
                      WidgetUitlites.buildDropdown(
                          context,
                          Strings.car_year_of_use,
                          controller.carYearOfUseList,
                          controller.carYearOfUseController),
                      WidgetUitlites.buildFooter(context, () async {
                        controller.updateData(widget.data);
                        LoggerUtil().logger.d("updateData finised");
                        if (isOnline) {
                          widget.data.status = Strings.STATUS_DRAFT;
                          controller.sendProfileRequest(widget.data);
                        } else {
                          LocalStorageService.saveProfileData(
                              widget.data, widget.profileId);
                          navigateBackToHome();
                        }
                      }, () async {
                        if (await Utils.isInternetConnected()) {
//                          if (controller.formKey.currentState.validate()) {
                          navigateNext();
//                          }
                        } else {
                          navigateNext();
                        }
                      }, widget.isUpdate, '', isUserOwner)
                    ],
                  ),
                ),
              ],
            )),
          ),
        ));
  }

  Future<void> navigateNext() async {
    controller.updateData(widget.data);
    final profileDataResult = await NavigatorUtilities.push(
        context,
        CarStatusPage(
          data: widget.data,
          profileId: widget.profileId,
          isUpdate: widget.isUpdate,
        ));
    if (profileDataResult != null) {
      widget.data = CarProfileData().updateData(jsonDecode(profileDataResult));
    }
  }

  Future<void> navigateBackToHome() async {
    final userInfo = await LocalStorageService.getUserInfor();
    NavigatorUtilities.pushAndRemoveUntil(context, MainHomePage(userInfo));
  }

  @override
  void onConnectivityListener(bool result) {
    setState(() {
      isOnline = result;
    });
  }
}
