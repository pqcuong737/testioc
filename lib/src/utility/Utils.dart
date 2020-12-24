import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/Strings.dart';

import 'LocalStorageService.dart';
import 'LoggerUtil.dart';

class Utils {
  static Future<bool> checkRefreshTokenValid() async {
    String token = await LocalStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      int expiryIn = await LocalStorageService.getInt(
          LocalStorageService.REFRESH_TOKEN_EXPIRY_DATE);
      int currentTime = new DateTime.now().millisecondsSinceEpoch;
      LoggerUtil().logger.d("expiryIn: " +
          expiryIn.toString() +
          " ----  currentTime: " +
          currentTime.toString());
      if (expiryIn != 0 && currentTime > expiryIn) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  static Future<bool> checkTokenValid() async {
    String token = await LocalStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      int expiryIn = await LocalStorageService.getInt(
          LocalStorageService.TOKEN_EXPIRY_DATE);
      int currentTime = new DateTime.now().millisecondsSinceEpoch;
      LoggerUtil().logger.d("expiryIn: " +
          expiryIn.toString() +
          " ----  currentTime: " +
          currentTime.toString());
      if ((expiryIn == null) || (expiryIn != 0 && currentTime > expiryIn)) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  static Future<bool> isInternetConnected() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none)
        return false;
      else
        return true;
    } catch (error) {
      return false;
    }
  }

  //Return <latitude, longitude>
  static Future<MapEntry<double, double>> getLocation() async {
    try {
      Position currentPos = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (currentPos == null)
        currentPos = await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      if (currentPos != null)
        return MapEntry(currentPos.latitude != null ? currentPos.latitude : 0.0,
            currentPos.longitude != null ? currentPos.longitude : 0.0);
      else
        return null;
    } catch (error) {
      //No location permission granted
      return null;
    }
  }

  static Future<Map<String, dynamic>> updateCarRequestData(
      Map<String, dynamic> addedData, bool isCompleteIOC) async {
    addedData.remove('video_thumbnail');
    addedData.remove('video');
    addedData.remove('image_extends');
    addedData.remove('isOnline');
    //replace brandName and TypeCar with categoryId
    addedData.remove('car');
    addedData.remove('typeCar');
    if (addedData['latitude'] == null && addedData['longitude'] == null) {
      if ((addedData['img_car_front_position_right'] != null &&
              addedData['img_car_front_position_right'].contains('images-')) ||
          (addedData['img_car_front_position_left'] != null &&
              addedData['img_car_front_position_left'].contains('images-')) ||
          (addedData['img_car_rear_position_right'] != null &&
              addedData['img_car_rear_position_right'].contains('images-')) ||
          (addedData['img_car_rear_position_left'] != null &&
              addedData['img_car_rear_position_left'].contains('images-')) ||
          (addedData['img_chassis'] != null &&
              addedData['img_chassis'].contains('images-')) ||
          (addedData['img_windshield'] != null &&
              addedData['img_windshield'].contains('images-'))) {
        final location = await getLocation();
        addedData['latitude'] = location.key;
        addedData['longitude'] = location.value;
      }
    } else {
      //user location in db
//      addedData.remove("latitude");
//      addedData.remove('longitude');
    }
    addedData.remove('img_car_front_position_right');
    addedData.remove('img_car_front_position_left');
    addedData.remove('img_car_rear_position_right');
    addedData.remove('img_car_rear_position_left');
    addedData.remove('img_chassis');
    addedData.remove("img_windshield");
    //set latitude, longitude
//    if (isCompleteIOC) {
//      final location = await getLocation();
//      addedData['latitude'] = location.key;
//      addedData['longitude'] = location.value;
//    }
    return addedData;
  }

  static Future<List<FormData>> generateCarRequest(
      CarProfileData profileData, bool isCompleteIOC) async {
    int customerId = profileData.customerId;
    Map<String, dynamic> map = new Map();
    map['customerId'] = customerId;
    map['documentId'] = profileData?.id;

    //Map to remove file
    final addedData =
        await updateCarRequestData(profileData.toJson(), isCompleteIOC);

    //create list mapdata;
    List<FormData> listFormData = new List();

    //add data text to form data
    FormData data1 = FormData.fromMap(addedData);
    listFormData.add(data1);

    //create form data img
    FormData formDataImage = FormData.fromMap(map);

    listFormData.add(formDataImage);

    if (profileData.imgChassis != null &&
        profileData.imgChassis.contains('images-'))
      formDataImage.files.add(MapEntry(
          "img_chassis",
          await MultipartFile.fromFile(profileData.imgChassis,
              filename: "img_chassis.png",
              contentType: MediaType('image', 'png'))));
    if (profileData.imgCarFrontPositionLeft != null &&
        profileData.imgCarFrontPositionLeft.contains('images-'))
      formDataImage.files.add(MapEntry(
          "img_car_front_position_left",
          await MultipartFile.fromFile(profileData.imgCarFrontPositionLeft,
              filename: "img_car_front_position_left.png",
              contentType: MediaType('image', 'png'))));
    if (profileData.imgCarFrontPositionRight != null &&
        profileData.imgCarFrontPositionRight.contains('images-'))
      formDataImage.files.add(MapEntry(
          "img_car_front_position_right",
          await MultipartFile.fromFile(profileData.imgCarFrontPositionRight,
              filename: "img_car_front_position_right.png",
              contentType: MediaType('image', 'png'))));
    if (profileData.imgCarRearPositionRight != null &&
        profileData.imgCarRearPositionRight.contains('images-'))
      formDataImage.files.add(MapEntry(
          "img_car_rear_position_right",
          await MultipartFile.fromFile(profileData.imgCarRearPositionRight,
              filename: "img_car_rear_position_right.png",
              contentType: MediaType('image', 'png'))));
    if (profileData.imgCarRearPositionLeft != null &&
        profileData.imgCarRearPositionLeft.contains('images-'))
      formDataImage.files.add(MapEntry(
          "img_car_rear_position_left",
          await MultipartFile.fromFile(profileData.imgCarRearPositionLeft,
              filename: "img_car_rear_position_left.png",
              contentType: MediaType('image', 'png'))));
    if (profileData.imgWindshield != null &&
        profileData.imgWindshield.contains('images-'))
      formDataImage.files.add(MapEntry(
          "img_windshield",
          await MultipartFile.fromFile(profileData.imgWindshield,
              filename: "img_windshield.png",
              contentType: MediaType('image', 'png'))));

    FormData formDataVideo = FormData.fromMap(map);
    listFormData.add(formDataVideo);
    if (profileData.video != null && profileData.video.contains('videos-'))
      formDataVideo.files.add(MapEntry(
          "video",
          MultipartFile.fromFileSync(profileData.video,
              filename: "video.mp4", contentType: MediaType('video', 'mp4'))));

    FormData formDataExtendImage = new FormData();
    listFormData.add(formDataExtendImage);
    if (profileData.imageOptions != null) {
      for (var i = 0; i < profileData.imageOptions.length; i++) {
        if (profileData.imageOptions[i].contains('images-')) {
          // images- to identify the image taken from device, not a url
          formDataExtendImage.fields
              .add(MapEntry(i.toString(), profileData.imageOptions[i]));
          formDataExtendImage.files.add(MapEntry(
              "image",
              await MultipartFile.fromFile(profileData.imageOptions[i],
                  filename: 'image_extends$i.png',
                  contentType: MediaType('image', 'png'))));
        } else {
          //not a local image that need to upload
        }
      }
    }

    StringBuffer stringBuffer = new StringBuffer("");
    addedData.forEach((k, v) => stringBuffer.write('${k}: ${v} \n'));
    LoggerUtil().logger.d("FormData =" + stringBuffer.toString());
    return listFormData;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  static Future<bool> isUserCanAction(int createdById) async {
    UserInfor userStored = await LocalStorageService.getUserInfor();
    if (createdById == userStored?.result?.id) {
      return true;
    } else
      return false;
  }

  static mapKeyToMessageErr(key) {
    switch (key) {
      case "CUSTOMER_NOT_FOUND":
        return Strings.CUSTOMER_NOT_FOUND;
        break;
      case "CUSTOMER_NOT_ACTIVE":
        return Strings.CUSTOMER_NOT_ACTIVE;
        break;
      case "CATEGORY_NOT_ACTIVE":
        return Strings.CATEGORY_NOT_ACTIVE;
        break;
      case "CATEGORY_NOT_FOUND":
        return Strings.CATEGORY_NOT_FOUND;
        break;
      case "DUPLICATE_FIELD_LICENSE_PLATES":
        return Strings.DUPLICATE_FIELD_LICENSE_PLATES;
        break;
      case "DUPLICATE_FIELD_CONTRACT_NUMBER":
        return Strings.DUPLICATE_FIELD_CONTRACT_NUMBER;
        break;
      case "DOCUMENT_NOT_FOUND":
        return Strings.DOCUMENT_NOT_FOUND;
        break;
      case "CANNOT_CHANGE_DOCUMENT_APPROVED":
        return Strings.CANNOT_CHANGE_DOCUMENT_APPROVED;
        break;
      case "ONLY_OWNER":
        return Strings.ONLY_OWNER;
        break;
      case "NOT_OWNER_OF_DOCUMENT":
        return Strings.NOT_OWNER_OF_DOCUMENT;
        break;
      case "ONLY_ADMIN_ALLOW":
        return Strings.ONLY_ADMIN_ALLOW;
        break;
      case "NOT_EDIT_APPROVED_DOCUMENT":
        return Strings.NOT_EDIT_APPROVED_DOCUMENT;
        break;
      case "NOT_EDIT_APPROVED_DOCUMENT":
        return Strings.NOT_EDIT_APPROVED_DOCUMENT;
        break;
      case "PERMISION_DENIED":
        return Strings.PERMISION_DENIED;
        break;
      case "NOT_SUPPORT_TYPE":
        return Strings.NOT_SUPPORT_TYPE;
        break;
      case "DUPLICATE_CUSTOMER_IDENTITY":
        return Strings.DUPLICATE_CUSTOMER_IDENTITY;
        break;
      case "NOT_OWN_OF_CUSTOMER":
        return Strings.NOT_OWN_OF_CUSTOMER;
        break;
      case "EMAIL_EXISTED":
        return Strings.EMAIL_EXISTED;
        break;
      case "CONFIRM_PASSWORD_NOT_MATCH":
        return Strings.CONFIRM_PASSWORD_NOT_MATCH;
        break;
      case "INVALID_PASSWORD":
        return Strings.INVALID_PASSWORD;
        break;
      case "NOT_ALLOW_UPDATE_TO_NEW":
        return Strings.NOT_ALLOW_UPDATE_TO_NEW;
        break;
      case "SAME_STATUS":
        return Strings.SAME_STATUS;
        break;

      case "INVALID_TOKEN":
        return Strings.INVALID_TOKEN;
        break;
      case "ACCOUNT_LOCKED":
        return Strings.ACCOUNT_LOCKED;
        break;
      case "INVALID_PARAMETER":
        return Strings.INVALID_PARAMETER;
        break;
      case "EMAIL_ALREADY_EXIST":
        return Strings.EMAIL_ALREADY_EXIST;
        break;
      case "PASSWORD_NOT_MATCH":
        return Strings.PASSWORD_NOT_MATCH;
        break;
      case "EMAIL_NOT_FOUND":
        return Strings.EMAIL_NOT_FOUND;
        break;
      case "USER_VERIFIED_OR_LOCKED":
        return Strings.USER_VERIFIED_OR_LOCKED;
        break;
      case "ACCOUNT_VERIFIED":
        return Strings.ACCOUNT_VERIFIED;
        break;
      case "USER_LOCKED":
        return Strings.USER_LOCKED;
        break;
      case "INVIALID_CREDENTIALS":
        return Strings.INVIALID_CREDENTIALS;
        break;
      case "USER_NOT_ACTIVE":
        return Strings.USER_NOT_ACTIVE;
        break;
      case "USER_NOT_FOUND":
        return Strings.USER_NOT_FOUND;
        break;
      default:
        return key;
        break;
    }
  }
}
