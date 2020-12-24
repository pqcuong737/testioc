import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:load/load.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/usecases/profile/create_profile.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/MediaController/CameraCapture.dart';
import 'package:mobile/src/utility/MediaController/CameraQuickPreview.dart';
import 'package:mobile/src/utility/MediaController/VideoCapture.dart';
import 'package:mobile/src/utility/MediaController/VideoQuickPreview.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

import 'car_image_presenter.dart';

class CarImageController extends Controller {
  final CarImagePresenter carImagePresenter;
  BuildContext context;
  CarProfileData data;
  CarImageController(profileRepo)
      : carImagePresenter = CarImagePresenter(profileRepo),
        super();
  ValueNotifier<List<String>> imageFrontLeftPath =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<List<String>> imageFrontRightPath =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<List<String>> imageRearRightPath =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<List<String>> imageRearLeftPath =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<List<String>> imageChassisPath =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<List<String>> imgWindshield =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<List<String>> videoPath =
      new ValueNotifier<List<String>>(<String>[]);
  ValueNotifier<String> videoThumbnail = new ValueNotifier<String>('');
  ValueNotifier<List<String>> imageOptionPath =
      new ValueNotifier<List<String>>(<String>[]);
  String profileId;

  @override
  // this is called automatically by the parent class
  void initListeners() {
    carImagePresenter.createProfilesOnError = () {
      hideLoadingDialog();
    };

    carImagePresenter.createProfilesOnComplete = () {
      hideLoadingDialog();
    };

    carImagePresenter.createProfilesOnNext = (CreateProfileResponse response) {
      hideLoadingDialog();
      if (response == null) return;
      if (response.id != null) this.data.id = int.parse(response.id);
      if (response?.statusCode == 200) {
        LocalStorageService.deleteProfileData(profileId);
        if (response.result.status.contains(Strings.STATUS_COMPLETED)) {
          DialogUtilities.showSimpleDialog(
              context, 'Thông báo', 'Tạo hồ sơ thành công', 'Ok', () {
            carImagePresenter.navigateBackToHome();
          });
        } else {
          DialogUtilities.showSimpleDialog(
              context, 'Thông báo', 'Lưu tạm hồ sơ thành công', 'Ok', () {
            carImagePresenter.navigateBackToHome();
          });
        }
      } else
        DialogUtilities.showSimpleDialog(
            context,
            'Lỗi',
            'code: ${response.statusCode} + message:  ${response.errorDocument != null ? (response.errorDocument.errorDocument != null ? response.errorDocument.errorDocument[0].error : Utils.mapKeyToMessageErr(response.errorDocument.message)) : ''} ',
            'Ok',
            null);
    };
  }

  bool validation() {
    if (imageFrontRightPath.value.length > 0 &&
        imageFrontLeftPath.value.length > 0 &&
        imageRearLeftPath.value.length > 0 &&
        imageRearRightPath.value.length > 0 &&
        imageChassisPath.value.length > 0 &&
        imgWindshield.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> sendProfileRequest(CarProfileData data,
      List<String> listImagesExtendID, bool isCompleteIOC) async {
    showLoadingDialog();
    final request = await Utils.generateCarRequest(data, isCompleteIOC);
    DataProfile dataProfile = new DataProfile(request, listImagesExtendID);
    carImagePresenter.createProfile(dataProfile);
  }

  void updateData(CarProfileData data) {
    if (imageChassisPath.value.length > 0)
      data.imgChassis = imageChassisPath.value[0];
    if (imageFrontLeftPath.value.length > 0)
      data.imgCarFrontPositionLeft = imageFrontLeftPath.value[0];
    if (imageFrontRightPath.value.length > 0)
      data.imgCarFrontPositionRight = imageFrontRightPath.value[0];
    if (imageRearRightPath.value.length > 0)
      data.imgCarRearPositionRight = imageRearRightPath.value[0];
    if (imageRearLeftPath.value.length > 0)
      data.imgCarRearPositionLeft = imageRearLeftPath.value[0];
    if (imgWindshield.value.length > 0)
      data.imgWindshield = imgWindshield.value[0];
    if (videoPath.value.length > 0) data.video = videoPath.value[0];
    if (imageOptionPath.value.length > 0)
      data.imageOptions = imageOptionPath.value;
    data.videoThumbnail = videoThumbnail.value;
  }

  void loadData(CarProfileData data) {
    this.data = data;
    if (data.imgCarRearPositionLeft != null)
      imageRearLeftPath.value = <String>[data.imgCarRearPositionLeft];
    if (data.imgCarRearPositionRight != null)
      imageRearRightPath.value = <String>[data.imgCarRearPositionRight];
    if (data.imgCarFrontPositionRight != null)
      imageFrontRightPath.value = <String>[data.imgCarFrontPositionRight];
    if (data.imgCarFrontPositionLeft != null)
      imageFrontLeftPath.value = <String>[data.imgCarFrontPositionLeft];
    if (data.imgChassis != null)
      imageChassisPath.value = <String>[data.imgChassis];
    if (data.imgWindshield != null)
      imgWindshield.value = <String>[data.imgWindshield];
    if (data.video != null) videoPath.value = <String>[data.video];
    if (data.videoThumbnail != null) videoThumbnail.value = data.videoThumbnail;
    if (data.imageOptions != null) imageOptionPath.value = data.imageOptions;
  }

  StatefulWidget getNextPage(bool isVideo, bool isPreview, String filePath) {
    final file = new File(filePath);
    if (isVideo) {
      if (isPreview)
        return VideoQuickPreview(file);
      else
        return VideoCapture();
    } else {
      if (isPreview)
        return ImagePreview(file);
      else
        return CameraCapture();
    }
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    carImagePresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }
}
