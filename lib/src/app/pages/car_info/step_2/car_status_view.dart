import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/app/pages/car_info/step_3/car_image_view.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

import 'car_status_controller.dart';

class CarStatusPage extends View {
  CarProfileData data;
  String profileId;
  final isUpdate;

  CarStatusPage({
    Key key,
    this.data,
    this.profileId,
    this.isUpdate,
  }) : super(key: key);

  @override
  _CarStatusPageState createState() => // inject dependencies inwards
      _CarStatusPageState();
}

class _CarStatusPageState
    extends ViewState<CarStatusPage, CarStatusController> {
  _CarStatusPageState() : super(CarStatusController(ProfileRepository()));

  bool isOnline = true;
  bool isUserOwner = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadData(widget.data);
    controller.context = context;
    controller.carStatusPresenter.navigateBackToHome = () {
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
            appBar: WidgetUitlites.buildAppBar(
                context, Strings.car_status_title, '3', cb: () {
              controller.updateData(widget.data);
              Navigator.pop(context, jsonEncode(widget.data));
            }),
            body: LayoutBuilder(builder: (context, constraints) {
              return new GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                            minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    (isOnline == false)
                                        ? WidgetUitlites.offlineView(context)
                                        : SizedBox(),
                                    _buildSwitchWidget(
                                        Strings.car_status,
                                        Strings.car_status_description,
                                        controller.isOnCarStatus,
                                        controller.carStatusController),
                                    _buildSwitchWidget(
                                        Strings.car_scratch,
                                        Strings.car_scratch_description,
                                        controller.isOnCarScratch,
                                        controller.carScratchController),
                                    _buildSwitchWidget(
                                        Strings.car_added_accessories,
                                        Strings
                                            .car_added_accessories_description,
                                        controller.isExtraAccessories,
                                        controller.carUpgradeController),
                                    WidgetUitlites.buildEditText(
                                        context,
                                        Strings.car_other_noted,
                                        Strings.car_other_noted_hint,
                                        controller.otherNoteController),
                                  ],
                                ),
                              ),
                            ),
                            WidgetUitlites.buildFooter(context, () async {
                              controller.updateData(widget.data);
                              if (isOnline) {
                                widget.data.status = Strings.STATUS_DRAFT;
                                controller.sendProfileRequest(widget.data);
                              } else {
                                LocalStorageService.saveProfileData(
                                    widget.data, widget.profileId);
                                navigateBackToHome();
                              }
                            }, () {
                              controller.updateData(widget.data);
                              NavigatorUtilities.push(
                                  context,
                                  CarImagePage(
                                    data: widget.data,
                                    profileId: widget.profileId,
                                    isUpdate: widget.isUpdate,
                                  ));
                            }, widget.isUpdate, '', isUserOwner),
                          ]),
                        ))),
              );
            })));
  }

  Widget _buildSwitchWidget(String label, String hint, ValueNotifier<bool> isOn,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(label, style: Theme.of(context).textTheme.body1),
              ),
              CustomSwitch(
                activeColor: Colors.blueAccent,
                value: isOn.value,
                onChanged: (bool state) {
                  setState(() {
                    isOn.value = state;
                  });
                },
              ),
            ],
          ),
          Visibility(
              visible: controller != null ? isOn.value : false,
              child: Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    color: Colors.white,
                    child: TextFormField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 2,
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(color: Colors.grey),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .copyWith(color: Colors.black),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Future<void> navigateBackToHome() async {
    final userInfo = await LocalStorageService.getUserInfor();
    NavigatorUtilities.pushAndRemoveUntil(context, MainHomePage(userInfo));
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
    setState(() {
      isOnline = result;
    });
  }
}
