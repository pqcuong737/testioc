import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:mobile/src/app/pages/splash/splash_view.dart';
import 'package:mobile/src/domain/entities/android.dart';
import 'package:mobile/src/domain/entities/cars/TypeCarResponse.dart';
import 'package:mobile/src/domain/entities/customer/CreateCustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerRepose.dart';
import 'package:mobile/src/domain/entities/customer/CustomerResponseById.dart';
import 'package:mobile/src/domain/entities/customer/UpdateCustomer.dart';
import 'package:mobile/src/domain/entities/ios.dart';
import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileDetailReponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:rxdart/subjects.dart';

import 'LocalStorageService.dart';
import 'NavigationUtilities.dart';

final _progressStream = PublishSubject<dynamic>();

Stream<dynamic> get progressSubject => _progressStream.stream;

Sink<dynamic> get progressSubjectAdd => _progressStream.sink;

class APIProvider {
  static const int REFRESH_TOKEN_EXPIRED = 203;
  String accessToken = "";
  bool isRefreshTokenFail = false;
  BuildContext mContext;
  Dio _dio;
  static final APIProvider _singleton = APIProvider._internal();

  factory APIProvider() {
//    if (_singleton.mContext == null) _singleton.mContext = context;
    return _singleton;
  }

  APIProvider._internal() {
    BaseOptions options = new BaseOptions(
//       baseUrl: "https://api-bvhcm.digitechglobalco.com/",
      // baseUrl: "https://api-bvhcm.vndigitech.com/",
//      baseUrl: "http://192.168.100.18:13000/",
      baseUrl: "https://api-bvhcm-uat.vndigitech.com/",
      connectTimeout: 60 * 1000, // 60 seconds
      receiveTimeout: 60 * 1000, // 60 seconds
    );
    _dio = Dio(options);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      final device = await getInfoDevice();
      if (device != null) {
        options.headers["InfoDevice"] = device;
      }
      bool checkTokenValid = await Utils.checkTokenValid();
      String path = options.path;
      if (!checkTokenValid &&
          (!path.contains("auth/login") &&
              !path.contains("auth/reset-password")) &&
          !path.contains("auth/refresh")) {
        String refreshToken = await LocalStorageService.getRefreshToken();
        LoginResponse loginResponse = await handleRefreshToken(refreshToken);
        if (loginResponse.statusCode == 200) {
          String accessToken = loginResponse.result.accessToken;
          saveLoginInformation(loginResponse);
          options.headers["Authorization"] = "Bearer " + accessToken;
        }
      } else {
        String token = await LocalStorageService.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer " + token;
        }
      }
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer
          .write("--> ${options.method} ${options.baseUrl} ${options.path})");
      options.headers.forEach((key, value) {
        stringBuffer.write("key:" + value + "\n");
      });
      LoggerUtil().logger.d("Header: " + stringBuffer.toString());
      LoggerUtil().logger.d("Content Data: ${options.data.toString()}");
      LoggerUtil()
          .logger
          .d("Query Data: ${options.queryParameters.toString()}");
      return options;
    }, onResponse: (Response response) {
      LoggerUtil().logger.d(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      /*if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        LoggerUtil().logger.d(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {*/
      LoggerUtil().logger.d(response.data);
//    }
      LoggerUtil().logger.d("<-- END HTTP");

      return response;
    }, onError: (DioError error) {
      LoggerUtil().logger.e("<-- Error -->, ${error.error}, ${error.message}");
      return error;
    }));
  }
  /*APIProvider() {
    BaseOptions options = new BaseOptions(
      // baseUrl: "https://api-bvhcm.digitechglobalco.com/",
      baseUrl: "https://api-bvhcm.vndigitech.com/",
//      baseUrl: "http://192.168.100.18:13000/",
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    _dio = Dio(options);
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
//      options.headers["accept"] = "application/json";
//      options.headers["Content-Type"] = "application/json";
      bool checkTokenValid = await Utils.checkTokenValid();
      String path = options.path;
      if (!checkTokenValid &&
          (!path.contains("auth/login") &&
              !path.contains("auth/reset-password")) &&
          !path.contains("auth/refresh")) {
        String refreshToken = await LocalStorageService.getString(
            LocalStorageService.FRESH_TOKEN);
        LoginResponse loginResponse = await handleRefreshToken(refreshToken);
        String accessToken = loginResponse.result.accessToken;
        LocalStorageService.saveString(LocalStorageService.FRESH_TOKEN,
            loginResponse.result.refresh_token);
        await LocalStorageService.saveToken(accessToken);
        options.headers["Authorization"] = "Bearer " + accessToken;
      } else {
        String token = await LocalStorageService.getToken();
        options.headers["Authorization"] = "Bearer " + token;
      }
      final device = await getInfoDevice();
      if (device != null) {
        options.headers["InfoDevice"] = device;
      }
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer
          .write("--> ${options.method} ${options.baseUrl} ${options.path})");
      options.headers.forEach((key, value) {
        stringBuffer.write("key:" + value + "\n");
      });
      LoggerUtil().logger.d("Header: " + stringBuffer.toString());
      LoggerUtil().logger.d("Content Data: ${options.data.toString()}");
      LoggerUtil()
          .logger
          .d("Query Data: ${options.queryParameters.toString()}");
      return options;
    }, onResponse: (Response response) {
      LoggerUtil().logger.d(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      */ /*if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        LoggerUtil().logger.d(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {*/ /*
      LoggerUtil().logger.d(response.data);
//    }
      LoggerUtil().logger.d("<-- END HTTP");

      return response;
    }, onError: (DioError error) {
      LoggerUtil().logger.e("<-- Error -->, ${error.error}, ${error.message}");
      return error;
    }));
  }*/

  Future getInfoDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      AndroidDevice android = new AndroidDevice(
        release: androidInfo.version.release ?? '',
        baseOS: androidInfo.version.baseOS ?? '',
        model: androidInfo.model ?? '',
        isPhysicalDevice: androidInfo.isPhysicalDevice,
        androidId: androidInfo.androidId ?? '',
        device: androidInfo.device ?? '',
        display: androidInfo.display ?? '',
        fingerprint: androidInfo.display ?? '',
        id: androidInfo.id ?? '',
        manufacturer: androidInfo.manufacturer ?? '',
        product: androidInfo.product ?? '',
        board: androidInfo.board ?? '',
        bootloader: androidInfo.bootloader ?? '',
        brand: androidInfo.brand ?? '',
        codename: androidInfo.version.codename ?? '',
        hardware: androidInfo.hardware ?? '',
      );
      String jsonTagsAndroid = jsonEncode(android);
      print(jsonTagsAndroid);
      return jsonTagsAndroid ?? null;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      IosDevice ios = new IosDevice(
          name: iosInfo.name ?? '',
          identifierForVendor: iosInfo.identifierForVendor ?? '',
          isPhysicalDevice: iosInfo.isPhysicalDevice,
          localizedModel: iosInfo.localizedModel ?? '',
          model: iosInfo.model ?? '',
          systemName: iosInfo.systemName ?? '',
          machine: iosInfo.utsname.machine ?? '',
          release: iosInfo.utsname.release ?? '',
          systemVersion: iosInfo.systemVersion ?? '');
      String jsonTagsIos = jsonEncode(ios);
      print(jsonTagsIos);
      return jsonTagsIos ?? null;
    }
  }

  /*Future<LoginResponse> handleLoginAgain() async {
    LoggerUtil().logger.i("Re-authenticate");
    //login again
    String userName =
        await LocalStorageService.getString(LocalStorageService.USER_NAME);
    String password =
        await LocalStorageService.getString(LocalStorageService.PASSWORD);
    LoginResponse loginResponse = await authenticateUser(userName, password);
    if (loginResponse != null) {
      LocalStorageService.saveToken(loginResponse.result.accessToken);
      LocalStorageService.saveInt(
          LocalStorageService.EXPIRY_DATE, loginResponse.result.expiresIn);
    }
    return loginResponse;
  }*/

  Future<LoginResponse> handleRefreshToken(String refresh_token) async {
    LoggerUtil().logger.i("handleRefreshToken");
    try {
      Response response = await _dio
          .post("auth/refresh", data: {'refresh_token': refresh_token});
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      if (loginResponse.statusCode != 200) {
        isRefreshTokenFail = true;
        loginResponse.statusCode = REFRESH_TOKEN_EXPIRED;
        accessToken = "";
        if (mContext != null) {
          progressSubjectAdd.add(true);
          NavigatorUtilities.pushAndRemoveUntil(mContext, SplashScreen());
        }
      }
      return loginResponse;
    } on DioError catch (e) {
      LoggerUtil().logger.e("Exception occured: $e");
      return LoginResponse.fromJson(e.response.data);
    }
  }

  Future<LoginResponse> authenticateUser(String userID, String password) async {
    try {
      Response response = await _dio
          .post("auth/login", data: {'email': userID, "password": password});
      return LoginResponse.fromJson(response?.data);
    } on DioError catch (e) {
      LoggerUtil().logger.e("Exception occured: $e");
      return LoginResponse.fromJson(e.response?.data);
    }
  }

  Future<UserInfor> getUserInfor(String userID) async {
    try {
      Response response = await _dio.get("user/me");
      return UserInfor.fromJson(response.data);
    } catch (error, stacktrace) {
      LoggerUtil().logger.e(
          "Exception get all customer occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  //! CUSTOMER
  Future<CustomerRespose> getAllCustomer(Map object) async {
    try {
      if (object['isLoadMore'] != true && await Utils.isInternetConnected()) {
        showLoadingDialog();
      }
      object.remove('isLoadMore');
      Response response = await _dio.get("customer", queryParameters: object);
      hideLoadingDialog();
      return CustomerRespose.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
      return CustomerRespose.fromJson((error.response.data));
    }
  }

  Future<CreateCustomerResponse> createCustomer(
      Map objectCreateCustomer) async {
    try {
      showLoadingDialog(tapDismiss: false);
      Response response =
          await _dio.post('customer', data: objectCreateCustomer);
      hideLoadingDialog();
      return CreateCustomerResponse.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
      return CreateCustomerResponse.fromJson(error.response.data);
    }
  }

  Future<CustomerUpdateReponse> updateCustomer(Map objectCreateCustomer) async {
    try {
      final id = objectCreateCustomer['id'];
      showLoadingDialog();
      objectCreateCustomer.remove('id');
      Response response =
          await _dio.put('customer/${id}', data: objectCreateCustomer);
      hideLoadingDialog();
      return CustomerUpdateReponse.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
      return CustomerUpdateReponse.fromJson(error.response.data);
    }
  }

  Future<CustomerResposeById> getCustomerById(int idCustomer) async {
    try {
      showLoadingDialog();
      Response response = await _dio.get("customer/$idCustomer");
      hideLoadingDialog();
      return CustomerResposeById.fromJson(response.data);
    } catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  //! END CUSTOMER

  Future<ChangePassResponse> changePassword(
      String currentPass, String newPass, String confirmNewPass) async {
    try {
      Response response = await _dio.put("user/password", data: {
        'currentPassword': currentPass,
        'newPassword': newPass,
        'confirmNewPassword': confirmNewPass
      });
      return ChangePassResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      final dioError = error as DioError;
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
      return ChangePassResponse.fromJson(dioError.response.data);
    }
  }

  Future<ChangePassResponse> forgotPassword(String email) async {
    try {
      Response response = await _dio
          .get("auth/reset-password", queryParameters: {"email": email});
      return ChangePassResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      final dioError = error as DioError;
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
      return ChangePassResponse.fromJson(dioError.response.data);
    }
  }

  //! PROFILE
  Future<ProfileResponse> getAllProfiles(Map objectSearch) async {
    try {
      if (objectSearch['isLoadMore'] != true &&
          await Utils.isInternetConnected()) {
        showLoadingDialog();
//        showCustomLoadingWidget(StreamBuilder(
//          stream: progressSubject,
//          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//            return Text("${snapshot.data}");
//          },
//        ));
      }
      objectSearch.remove("isLoadMore");
      Response response =
          await _dio.get("document", queryParameters: objectSearch);
      hideLoadingDialog();
      return ProfileResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Get all profile error: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ProfileDetailResponse> getDocById(int idDoc) async {
    try {
      showLoadingDialog();
//      showCustomLoadingWidget(StreamBuilder(
//        stream: progressSubject,
//        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//          return Text("${snapshot.data}");
//        },
//      ));
      Response response = await _dio.get("document/$idDoc");
      hideLoadingDialog();
      return ProfileDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Get all profile error: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CreateProfileResponse> createProfile(
      List<FormData> objectCreateProfile,
      List<String> listImagesExtendID) async {
    try {
      final fields = objectCreateProfile[0].fields;
      String idValue = "-1";
      String customerID = "-1";
      for (int i = 0; i < fields.length; i++) {
        final map = fields[i];
        if (map.key == 'id') idValue = map.value;
        if (map.key == 'customerId') customerID = map.value;
      }

//      if(objectCreateProfile[1]?.files.length > 0 && objectCreateProfile[0]?.fields) {
//
//      }

      String documentID;
      Response responseTemp;
      responseTemp = await _dio.post('document', data: objectCreateProfile[0]);
      CreateProfileResponse temp =
          CreateProfileResponse.fromJson(responseTemp.data);
      if (temp.status.statusCode != 200) {
        return temp;
      }
      documentID = temp.result.id.toString();

      var image1;
      var image2;
      var image3;
      var image4;
      var image5;
      var image6;
      if (objectCreateProfile.length > 1 &&
          objectCreateProfile[1] != null &&
          objectCreateProfile[1].files != null &&
          objectCreateProfile[1].files.length > 0) {
        if (idValue == "-1") {
          objectCreateProfile[1].fields.add(new MapEntry("id", documentID));
        } else {
          objectCreateProfile[1].fields.add(new MapEntry("id", idValue));
        }
        final files = objectCreateProfile[1].files;
        Map<String, dynamic> map = new Map();
        if (customerID != "-1") map['customerId'] = customerID;
        if (idValue == "-1")
          map['id'] = documentID;
        else
          map['id'] = idValue;
        for (int i = 0; i < files.length; i++) {
          FormData formData = FormData.fromMap(map);
          formData.files.add(files[i]);
          if (i == 0) {
            image1 = updateProfile(formData);
          } else if (i == 1) {
            image2 = updateProfile(formData);
          } else if (i == 2) {
            image3 = updateProfile(formData);
          } else if (i == 3) {
            image4 = updateProfile(formData);
          } else if (i == 4) {
            image5 = updateProfile(formData);
          } else if (i == 5) {
            image6 = updateProfile(formData);
          }
        }
      }
      /**
       * Update fields first
       */
      if (idValue == "-1") {
        await responseTemp;
      }
//      if (video != null) await video;
      if (image1 != null) await image1;
      if (image2 != null) await image2;
      if (image3 != null) await image3;
      if (image4 != null) await image4;
      if (image5 != null) await image5;
      if (image6 != null) await image6;

      /**
       * Image Extends in Background
       */
      if (objectCreateProfile.length > 3 &&
          objectCreateProfile[3] != null &&
          objectCreateProfile[3].files != null &&
          objectCreateProfile[3].files.length > 0) {
        if (idValue == "-1") {
          objectCreateProfile[3].fields.add(new MapEntry("id", documentID));
        } else {
          objectCreateProfile[3].fields.add(new MapEntry("id", idValue));
        }
        updateImgOptions(
            objectCreateProfile[3], listImagesExtendID, documentID, customerID);
      }

      /**
       * Upload video  in Background
       */
      if (objectCreateProfile.length > 2 &&
          objectCreateProfile[2] != null &&
          objectCreateProfile[2].files != null &&
          objectCreateProfile[2].files.length > 0) {
        if (idValue == "-1") {
          objectCreateProfile[2].fields.add(new MapEntry("id", documentID));
        } else {
          objectCreateProfile[2].fields.add(new MapEntry("id", idValue));
        }
        updateProfile(objectCreateProfile[2]);
      }

      return temp;
    } catch (error, stacktrace) {
      try {
        final dioError = error as DioError;
        LoggerUtil()
            .logger
            .e("Exception occured: $error stackTrace: $stacktrace");
        return CreateProfileResponse.fromJson(dioError.response.data);
      } catch (error) {
        return null;
      }
    }
  }

  void updateImgOptions(
      FormData objectCreateProfile,
      List<String> listImagesExtendID,
      String documentID,
      String customerID) async {
    try {
//      objectCreateProfile.fields
//          .removeWhere((element) => element.key != "documentId");

//      FormData newValue = new FormData();
//      objectCreateProfile.fields.forEach((element) {
//        newValue.fields.add(element);
//      });
      List<int> listIndex = [];
      objectCreateProfile.fields.forEach((element) {
        if (element.key != 'id') listIndex.add(int.parse(element.key));
      });

      final length = objectCreateProfile.files.length;
      for (int i = 0; i < length; i++) {
//        newValue.files.add(objectCreateProfile.files[i]);
        FormData formData = new FormData();
        String url;
        formData.files.add(objectCreateProfile.files[i]);
        formData.fields.clear();
        if (customerID != '-1') {
          formData.fields.add(MapEntry('customerId', customerID));
        } else {
          // this IOC dont have customer assigned yet
        }
        if (listImagesExtendID != null &&
            listImagesExtendID.length > i &&
            listIndex.length > i &&
            listIndex[i] < listImagesExtendID.length) {
          String imageExtendID = listImagesExtendID[listIndex[i]];
          url = 'image_extend/$imageExtendID';
          _dio.put(url, data: formData);
        } else {
          url = 'image_extend';
          formData.fields.add(MapEntry('documentId', documentID));
          _dio.post(url, data: formData);
        }
      }
    } catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<CreateProfileResponse> updateProfile(
      FormData objectCreateProfile) async {
    try {
      Response response;
      var percent;
      var percentWrap;
      var rng = new Random();
      var idUploadProcess = rng.nextInt(1000);
      objectCreateProfile.fields
          .removeWhere((element) => element.key == "documentId");
//      Map<String, int> objProcess = {"id" : idUploadProcess, "value" : 0};
      Map<String, int> objProcess = {"$idUploadProcess": 0};
      if (objectCreateProfile?.files != null &&
          objectCreateProfile.files.length > 0 &&
          objectCreateProfile.files[0].key == "video") {
        response = await _dio.post('document',
            data: objectCreateProfile,
            onSendProgress: (count, total) => {
                  percent = (count / total * 100),
                  percentWrap = num.parse(percent.toStringAsFixed(0)),
                  objProcess["$idUploadProcess"] = percentWrap,
                  _progressStream.add(objProcess)
                  // bloc.addPercentStream(percentWrap)
                });
      } else {
        response = await _dio.post('document', data: objectCreateProfile);
      }
      LoggerUtil().logger.i("Success updateProfile");

      return CreateProfileResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      try {
        final dioError = error as DioError;
        LoggerUtil()
            .logger
            .e("Exception occured: $error stackTrace: $stacktrace");
        return CreateProfileResponse.fromJson(dioError.response.data);
      } catch (error) {
        return null;
      }
    }
  }

  Future<CreateProfileResponse> createAndUpdateProfileRepository(
      List<FormData> objectCreateProfile,
      List<String> listImagesExtendID) async {
    try {
      final fields = objectCreateProfile[0].fields;
      String idValue = "-1";
      String customerID = "-1";
      for (int i = 0; i < fields.length; i++) {
        final map = fields[i];
        if (map.key == 'id') idValue = map.value;
        if (map.key == 'customerId') customerID = map.value;
      }

      String documentID;
      Response responseTemp;
      responseTemp = await _dio.post('document', data: objectCreateProfile[0]);
      CreateProfileResponse temp =
          CreateProfileResponse.fromJson(responseTemp.data);
      if (temp.status.statusCode != 200) {
        return temp;
      }
      documentID = temp.result.id.toString();

      var image1;
      var image2;
      var image3;
      var image4;
      var image5;
      var image6;
      if (objectCreateProfile.length > 1 &&
          objectCreateProfile[1] != null &&
          objectCreateProfile[1].files != null &&
          objectCreateProfile[1].files.length > 0) {
        if (idValue == "-1") {
          objectCreateProfile[1].fields.add(new MapEntry("id", documentID));
        } else {
          objectCreateProfile[1].fields.add(new MapEntry("id", idValue));
        }
        final files = objectCreateProfile[1].files;
        Map<String, dynamic> map = new Map();
        if (customerID != "-1") map['customerId'] = customerID;
        if (idValue == "-1")
          map['id'] = documentID;
        else
          map['id'] = idValue;
        for (int i = 0; i < files.length; i++) {
          FormData formData = FormData.fromMap(map);
          formData.files.add(files[i]);
          if (i == 0) {
            image1 = updateProfile(formData);
          } else if (i == 1) {
            image2 = updateProfile(formData);
          } else if (i == 2) {
            image3 = updateProfile(formData);
          } else if (i == 3) {
            image4 = updateProfile(formData);
          } else if (i == 4) {
            image5 = updateProfile(formData);
          } else if (i == 5) {
            image6 = updateProfile(formData);
          }
        }
      }
      /**
       * Wait for update fields first

       */
      if (idValue == "-1") {
        await responseTemp;
      }

      if (image1 != null) await image1;
      if (image2 != null) await image2;
      if (image3 != null) await image3;
      if (image4 != null) await image4;
      if (image5 != null) await image5;
      if (image6 != null) await image6;

      /**
       * Image Extends in Background
       */
      if (objectCreateProfile.length > 3 &&
          objectCreateProfile[3] != null &&
          objectCreateProfile[3].files != null &&
          objectCreateProfile[3].files.length > 0) {
        if (idValue == "-1") {
          objectCreateProfile[3].fields.add(new MapEntry("id", documentID));
        } else {
          objectCreateProfile[3].fields.add(new MapEntry("id", idValue));
        }
        updateImgOptions(
            objectCreateProfile[3], listImagesExtendID, documentID, customerID);
      }

      /**
       * Upload video  in Background
       */
      if (objectCreateProfile.length > 2 &&
          objectCreateProfile[2] != null &&
          objectCreateProfile[2].files != null &&
          objectCreateProfile[2].files.length > 0) {
        if (idValue == "-1") {
          objectCreateProfile[2].fields.add(new MapEntry("id", documentID));
        } else {
          objectCreateProfile[2].fields.add(new MapEntry("id", idValue));
        }
        updateProfile(objectCreateProfile[2]);
      }

      /**
       * Update status of IOC
       */
      String url = 'document/' + documentID + '/status';
      Response response = await _dio.put(url, data: {'status': 'COMPLETED'});
      LoggerUtil().logger.i("Success updateProfile");
      CreateProfileResponse createProfileResponse =
          CreateProfileResponse.fromJson(response.data);
      createProfileResponse.id = documentID;
//      print('complete() executed in ${stopwatch.elapsed}');
      return createProfileResponse;
    } catch (error, stacktrace) {
      try {
        final dioError = error as DioError;
        LoggerUtil()
            .logger
            .e("Exception occured: $error stackTrace: $stacktrace");
        return CreateProfileResponse.fromJson(dioError.response.data);
      } catch (error) {
        return null;
      }
    }
  }

  //! END DOCUMENT

  Future<TypeCarResponse> getAllCarTypes() async {
    try {
      Response response =
          await _dio.get("type-car", queryParameters: {'limit': 50});
      return TypeCarResponse.fromJson(
        response.data,
      );
    } catch (error, stacktrace) {
      LoggerUtil()
          .logger
          .e("Get all car types error: $error stackTrace: $stacktrace");
      return null;
    }
  }

  void saveLoginInformation(LoginResponse loginResponse) {
    LocalStorageService.saveToken(accessToken);
    LocalStorageService.saveInt(
        LocalStorageService.TOKEN_EXPIRY_DATE, loginResponse.result.expiresIn);

    LocalStorageService.saveRefreshToken(loginResponse.result.refreshToken);
    LocalStorageService.saveInt(LocalStorageService.REFRESH_TOKEN_EXPIRY_DATE,
        loginResponse.result.refreshExpiresIn);
  }
}

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options) {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer
        .write("--> ${options.method} ${options.baseUrl} ${options.path})");
    stringBuffer.write("\nContent type: ${options.contentType}");
    stringBuffer.write("\nContent Header: ${options.headers}");
    stringBuffer.write("\nContent Data: ${options.data.toString()}");
    stringBuffer.write("\nContent QueryParam: ${options.queryParameters}");
    LoggerUtil().logger.d(stringBuffer.toString());
//    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    LoggerUtil().logger.d(
        "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
    String responseAsString = response.data.toString();
    /*if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        LoggerUtil().logger.d(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {*/
    LoggerUtil().logger.d(response.data);
//    }
    LoggerUtil().logger.d("<-- END HTTP");

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    LoggerUtil().logger.e("<-- Error -->, ${err.error}, ${err.message}");
    return super.onError(err);
  }
}
