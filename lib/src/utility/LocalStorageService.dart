import 'dart:convert';

import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart'
    as Profile;
import 'package:mobile/src/utility/APIProvider.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _sharedPreferences;
  static const TOKEN_KEY = "TOKEN_KEY";
  static const TOKEN_EXPIRY_DATE = "TOKEN_EXPIRY_DATE";
  static const REFRESH_TOKEN_EXPIRY_DATE = "REFRESH_TOKEN_EXPIRY_DATE";
//  static const USER_NAME = "USER_NAME";
//  static const PASSWORD = "PASSWORD";
  static const FRESH_TOKEN = "FRESH_TOKEN";
  static const SAVE_PAGE = "SAVE_PAGE";

  ///User Infor
  static const USER_ID = "USER_ID";
  static const USERINFOR = "USERINFOR";
  static const USER_FULL_NAME = "USER_FULL_NAME";
  static const USER_EMAIL = "USER_EMAIL";
  static const USER_STATUS = "USER_STATUS";
  static const USER_ROLE = "USER_ROLE";
  static const USER_PHONE = "USER_PHONE";
  static const USER_AVATAR = "USER_AVATER";
  static const USER_GROUP = "USER_GROUP";
  static const SET_REMEMBER = "SET_REMEMBER";
  static const SET_LOGIN = "SET_LOGIN";

  ///Profile
  static const PROFILE_COUNT = "PROFILE_COUNT";
  static const SHOW_ITEMS = "SHOW_ITEMS";
  static const SET_LOCATION_LONG = "GET_LOCATION_LONG";
  static const SET_LOCATION_LASS = "GET_GET_LOCATION_LASS";

  ///Customer
  static const CUSTOMER_TYPE = "CUSTOMER_TYPE";
  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static void saveToken(String token) {
    _sharedPreferences.setString(TOKEN_KEY, token);
    APIProvider().accessToken = token;
  }

  static Future<String> getToken() async {
    if (APIProvider().accessToken != null && APIProvider().accessToken.isEmpty) {
      String token = await _sharedPreferences.getString(TOKEN_KEY);
      APIProvider().accessToken = token;
      return token;
    }
    return APIProvider().accessToken;
  }

  static void saveRefreshToken(String token) {
    _sharedPreferences.setString(FRESH_TOKEN, token);
    APIProvider().accessToken = token;
  }

  static Future<String> getRefreshToken() async {
    if (APIProvider().accessToken.isEmpty)
      return _sharedPreferences.getString(FRESH_TOKEN);
    return APIProvider().accessToken;
  }

  static void saveString(String key, String value) {
    _sharedPreferences.setString(key, value);
  }

  static Future<String> getString(String key) async {
    return _sharedPreferences.getString(key);
  }

  static void saveInt(String key, int value) {
    _sharedPreferences.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    return _sharedPreferences.getInt(key);
  }

  ///Save limit to show items load more
  static void saveLimitItems(int value) {
    _sharedPreferences.setInt(SHOW_ITEMS, value);
  }

  static Future<int> getLimitItems() async {
    return _sharedPreferences.getInt(SHOW_ITEMS);
  }

  ///Save page to show items load more items
  static void savePageList(int value) {
    _sharedPreferences.setInt(SAVE_PAGE, value);
  }

  static Future<int> getPageList() async {
    return _sharedPreferences.getInt(SAVE_PAGE);
  }

  ///Save type customer to check when create fail
  static void saveTypeCustomer(String value) {
    _sharedPreferences.setString(CUSTOMER_TYPE, value);
  }

  static Future<String> getTypeCustomer() async {
    return _sharedPreferences.getString(CUSTOMER_TYPE);
  }

  ///SAVE REMEMBER
  static void saveRememberMe(bool value) {
    _sharedPreferences.setBool(SET_REMEMBER, value);
  }

  static Future<bool> getFlagRememberMe() async {
    return _sharedPreferences.getBool(SET_REMEMBER);
  }

  ///SAVE LOGIN
  static void saveLogin(String value) {
    _sharedPreferences.setString(SET_LOGIN, value);
  }

  ///SAVE LOCATION LONG
  static void saveLocationLong(String value) {
    _sharedPreferences.setString(SET_LOCATION_LONG, value);
  }

  static Future<String> getLocationLong() async {
    _sharedPreferences.getString(SET_LOCATION_LONG);
  }

  ///SAVE LOCATION LASS
  static void saveLocationLass(String value) {
    _sharedPreferences.setString(SET_LOCATION_LASS, value);
  }

  static Future<String> getLocationLass() async {
    _sharedPreferences.getString(SET_LOCATION_LASS);
  }

  static Future<String> getLogin() async {
    return _sharedPreferences.getString(SET_LOGIN);
  }

  static void saveUserInfor(UserInfor userInfor) {
    /*_sharedPreferences.setInt(USER_ID, userInfor.result.id);
    _sharedPreferences.setString(USER_FULL_NAME, userInfor.result.fullName);
    _sharedPreferences.setString(USER_EMAIL, userInfor.result.email);
    _sharedPreferences.setString(USER_STATUS, userInfor.result.status);
    _sharedPreferences.setString(USER_PHONE, userInfor.result.phone);
    _sharedPreferences.setString(USER_ROLE, userInfor.result.role);
    _sharedPreferences.setString(USER_AVATAR, userInfor.result.avatarUrl);
    _sharedPreferences.setString(USER_GROUP, userInfor.result.userGroups.toString());*/
    _sharedPreferences.setString(USERINFOR, jsonEncode(userInfor));
  }

  static Future<UserInfor> getUserInfor() async {
    /*UserInfor userInfor = new UserInfor();
    userInfor.result = new Result();
    userInfor.result.id = _sharedPreferences.get(USER_ID);
    userInfor.result.fullName = _sharedPreferences.get(USER_FULL_NAME);
    userInfor.result.email = _sharedPreferences.get(USER_EMAIL);
    userInfor.result.status = _sharedPreferences.get(USER_STATUS);
    userInfor.result.phone = _sharedPreferences.get(USER_PHONE);
    userInfor.result.role = _sharedPreferences.get(USER_ROLE);
    userInfor.result.avatarUrl = _sharedPreferences.get(USER_AVATAR);*/
//    userInfor.result.userGroups = _sharedPreferences.get(USER_GROUP);
    var data = _sharedPreferences.getString(USERINFOR);
    if (data == null) return null;
    final Map<String, dynamic> rawData = json.decode(data);
    final newData = UserInfor.fromJson(rawData);
    return newData;
  }

  static Future<void> saveProfileData(
      Profile.CarProfileData profileData, String profileId) async {
    final existedData = _sharedPreferences.getString(profileId);
    if (profileData.latitude == null && profileData.longitude == null) {
      if ((profileData.imgCarFrontPositionRight != null &&
          profileData.imgCarFrontPositionRight.contains('images-')) ||
          (profileData.imgCarFrontPositionLeft != null &&
              profileData.imgCarFrontPositionLeft.contains('images-')) ||
          (profileData.imgCarRearPositionRight != null &&
              profileData.imgCarRearPositionRight.contains('images-')) ||
          (profileData.imgCarRearPositionLeft != null &&
              profileData.imgCarRearPositionLeft.contains('images-')) ||
          (profileData.imgChassis != null &&
              profileData.imgChassis.contains('images-')) ||
          (profileData.imgWindshield != null &&
              profileData.imgWindshield.contains('images-'))) {
        final location = await Utils.getLocation();
        profileData.latitude = '${location.key}';
        profileData.longitude = '${location.value}';
      }
    } else {
      // Location equal default db response
    }
    if (existedData == null) addProfileCount();
    _sharedPreferences.setString(profileId, jsonEncode(profileData));
  }

  static void deleteProfileData(String profileId) {
    _sharedPreferences.remove(profileId);
  }

  static Future<Profile.CarProfileData> getProfileData(String profileId) async {
    final data = _sharedPreferences.getString(profileId);
    if (data == null) return null;
    final Map<String, dynamic> rawData = json.decode(data);
    final newData = Profile.CarProfileData();
    newData.updateData(rawData);
    return newData;
  }

  static int addProfileCount() {
    _sharedPreferences.setInt(PROFILE_COUNT, getProfileCount() + 1);
  }

  static int getProfileCount() {
    return _sharedPreferences.getInt(PROFILE_COUNT) == null
        ? 0
        : _sharedPreferences.getInt(PROFILE_COUNT);
  }
}
