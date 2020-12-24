import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

import 'car_image_controller.dart';

class CarImagePage extends View {
  CarProfileData data;
  String profileId;
  final isUpdate;
  CarImagePage({
    Key key,
    this.data,
    this.profileId,
    this.isUpdate,
  }) : super(key: key);

  @override
  _CarImagePageState createState() => // inject dependencies inwards
      _CarImagePageState();
}

class _CarImagePageState extends ViewState<CarImagePage, CarImageController> {
  _CarImagePageState() : super(CarImageController(ProfileRepository()));

  bool isOnline = true;
  bool isUserOwner = true;

  @override
  void initState() {
    super.initState();
    controller.context = context;
    controller.profileId = widget.profileId;
    controller.loadData(widget.data);
    controller.carImagePresenter.navigateBackToHome = () {
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
            appBar: WidgetUitlites.buildAppBar(context, Strings.car_images, '4',
                cb: () {
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
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (isOnline == false)
                            ? WidgetUitlites.offlineView(context)
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                          child: Text(
                            Strings.car_images_description,
                            style: Theme.of(context)
                                .textTheme
                                .subhead
                                .copyWith(color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        _buildSectionTitle(Strings.car_images_front_left,
                            isMandatory: true),
                        _buildCameraWidget(controller.imageFrontLeftPath),
                        _buildSectionTitle(Strings.car_images_front_right,
                            isMandatory: true),
                        _buildCameraWidget(controller.imageFrontRightPath),
                        _buildSectionTitle(Strings.car_images_back_left,
                            isMandatory: true),
                        _buildCameraWidget(controller.imageRearLeftPath),
                        _buildSectionTitle(Strings.car_images_back_right,
                            isMandatory: true),
                        _buildCameraWidget(controller.imageRearRightPath),

                        ///
                        _buildSectionTitle(Strings.car_images_registered,
                            isMandatory: true),
                        _buildCameraWidget(controller.imageChassisPath),

                        ///
                        _buildSectionTitle(Strings.car_windshield,
                            isMandatory: true),
                        _buildCameraWidget(controller.imgWindshield),

                        ///
                        _buildSectionTitle(Strings.car_images_others),
                        _buildCameraWidget(controller.imageOptionPath,
                            isMultiFiles: true),
                        _buildSectionTitle(Strings.car_videos),
                        _buildCameraWidget(controller.videoPath,
                            isVideo: true,
                            videoThumbnail: controller.videoThumbnail),
//                        _buildSectionTitle(Strings.car_images_others),
//                        _buildCameraWidget(controller.imageOptionPath,
//                            isMultiFiles: true),
                        WidgetUitlites.buildFooter(context, () {
                          controller.updateData(widget.data);
                          if (isOnline) {
                            widget.data.status = Strings.STATUS_DRAFT;
                            controller.sendProfileRequest(widget.data,
                                widget.data.listImagesExtendID, false);
                          } else {
                            LocalStorageService.saveProfileData(
                                widget.data, widget.profileId);
                            navigateBackToHome();
                          }
                        }, () {
                          bool isMandatoryField =
                              checkFieldsMandatory(widget.data);
                          if (isMandatoryField) {
                            if (controller.validation()) {
                              controller.updateData(widget.data);
                              if (isOnline) {
                                widget.data.status = Strings.STATUS_COMPLETED;
                                controller.sendProfileRequest(widget.data,
                                    widget.data.listImagesExtendID, true);
                              } else {
                                DialogUtilities.showSimpleDialog(
                                    context,
                                    'Lỗi',
                                    'Vui lòng kiểm tra hết nối mạng!',
                                    'Ok',
                                    null);
                              }
                            } else {
                              DialogUtilities.showSimpleDialog(
                                  context,
                                  'Lỗi',
                                  Strings.car_images_error,
                                  Strings.try_again,
                                  null);
                            }
                          }
                        }, widget.isUpdate, Constant.flag_step_completed,
                            isUserOwner),
                      ]),
                )),
              );
            })));
  }

  Widget _buildSectionTitle(String title, {isMandatory = false}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: title,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.black)),
              TextSpan(
                  text: isMandatory ? ' *' : '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            ],
          ),
        ));
  }

  Widget _buildCameraWidget(ValueNotifier<List<String>> imagePath,
      {bool isVideo = false,
      bool isMultiFiles = false,
      ValueNotifier<String> videoThumbnail}) {
    final itemSize = MediaQuery.of(context).size.width * 0.35;
    final maxSize = 5;
    int numberOfImages = imagePath.value.length;
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: imagePath.value.isEmpty,
              child: DottedBorder(
                color: Colors.grey,
                borderType: BorderType.RRect,
                radius: Radius.circular(0),
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        navigateToCameraCapture(context, '', imagePath.value,
                            isVideo, videoThumbnail);
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              isVideo
                                  ? ImagePath.ic_video
                                  : ImagePath.ic_camera,
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              isVideo
                                  ? Strings.car_images_video
                                  : Strings.car_images_capture,
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ),
            Visibility(
                visible: imagePath.value.isNotEmpty,
                child: Container(
                  width: double.infinity,
                  height: itemSize,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: isMultiFiles
                          ? (numberOfImages == maxSize
                              ? numberOfImages
                              : (numberOfImages + 1))
                          : 1,
                      itemBuilder: (context, index) {
                        return _buildItemImages(index, isMultiFiles, itemSize,
                            imagePath.value, isVideo, videoThumbnail);
                      }),
                ))
          ],
        ));
  }

  Widget _buildItemImages(
      int index,
      bool isMultiFiles,
      double itemSize,
      List<String> filePaths,
      bool isVideo,
      ValueNotifier<String> videoThumbnail) {
    final isLast = (index == filePaths.length);
    if (isMultiFiles && isLast) {
      return Container(
          width: itemSize,
          child: Card(
            color: Colors.black,
            child: Container(
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  iconSize: 30,
                  onPressed: () {
                    //Add new Image
                    navigateToCameraCapture(
                        context, '', filePaths, isVideo, videoThumbnail);
                  },
                ),
              ),
            ),
          ));
    } else {
      final filePath = filePaths[index];
      return Container(
        width: itemSize,
        child: Card(
          color: Colors.black,
          child: Container(
              child: Stack(
            children: <Widget>[
              Center(
                child: (!filePath.contains('http'))
                    ? Image.file(
                        File(isVideo ? videoThumbnail.value : filePath))
                    : Image.network(isVideo ? videoThumbnail.value : filePath,
                        width: itemSize, height: itemSize, fit: BoxFit.cover),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 3, 0),
                    width: 33,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      iconSize: 14,
                      onPressed: () {
                        //delete Image
                        setState(() {
                          filePaths.remove(filePath);
                        });
                      },
                    ),
                  ),
                  InkWell(
                    //Edit Image
                    onTap: () {
                      navigateToCameraCapture(
                          context, filePath, filePaths, isVideo, videoThumbnail,
                          isEdit: true, isPreview: true);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        isVideo ? Strings.change_video : Strings.change_image,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: isVideo,
                child: Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )),
        ),
      );
    }
  }

  void navigateToCameraCapture(
      BuildContext context,
      String filePath,
      List<String> filePaths,
      bool isVideo,
      ValueNotifier<String> videoThumbnail,
      {isEdit = false,
      isPreview = false}) async {
    final result = await NavigatorUtilities.push(
        context, controller.getNextPage(isVideo, isPreview, filePath));
    String newFilePath = result;
    if (result == 'delete') {
      setState(() {
        filePaths.remove(filePath);
      });
      return;
    }
    if (isVideo) {
      List<String> resultList = result.split('andVideoThumbnail');
      newFilePath = resultList.first;
      videoThumbnail.value = resultList[1];
    }
    if (newFilePath != null && newFilePath.isNotEmpty) {
      final index = filePaths.indexOf(filePath);
      if (isEdit) filePaths.remove(filePath);
      if (filePath.isEmpty)
        filePaths.add(newFilePath);
      else
        filePaths.insert(index, newFilePath);
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

  bool checkFieldsMandatory(CarProfileData data) {
    bool isValid = true;
    StringBuffer text = new StringBuffer();
    if (data.licensePlates == null || data.licensePlates.isEmpty) {
      isValid = false;
      text.write("Vui lòng nhập biển số xe");
    }
    if (data.chassisNumber == null || data.chassisNumber.isEmpty) {
      isValid = false;
      text.write("\nVui lòng nhập số khung xe");
    }
    if (data.contractNumber == null || data.contractNumber.isEmpty) {
      isValid = false;
      text.write("\nVui lòng nhập số hợp đồng");
    }
    if (data.printeMattersNumber == null || data.printeMattersNumber.isEmpty) {
      isValid = false;
      text.write("\nVui lòng nhập số ấn chỉ");
    }
    if (!isValid) {
      DialogUtilities.showSimpleDialog(
          context,
          Strings.missing_mandatory_fileds,
          text.toString(),
          Strings.OK_TEXT,
          null);
    } else {
      LoggerUtil().logger.d("Enough Mandatory fields");
    }
    return isValid;
  }
}
