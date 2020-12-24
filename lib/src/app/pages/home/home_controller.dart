import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:mobile/src/app/pages/home/home_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/menu_home.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/usecases/profile/create_profile.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends Controller {
  List<MenuEntity> get dataSet => _dataSet;
  final _dataSet = [
    MenuEntity(Strings.profile, ImagePath.ic_item_profile),
    MenuEntity(Strings.customer, ImagePath.ic_item_customer),
//    MenuEntity(Strings.car_category, ImagePath.ic_item_category),
    MenuEntity(Strings.guide_line, ImagePath.ic_item_guide),
    MenuEntity(Strings.tech, ImagePath.img_tech)
  ];
  bool isOnline = true;
  final HomePresenter homePresenter;
  String selectedProfileId;
  // Presenter should always be initialized this way
  HomeController(profileRepo)
      : homePresenter = HomePresenter(profileRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {
    homePresenter.createProfilesOnError = () {};

    homePresenter.createProfilesOnComplete = () {};

    homePresenter.createProfilesOnNext =
        (CreateProfileResponse response) async {
      if (response.statusCode == 200) {
        await LocalStorageService.deleteProfileData(selectedProfileId);
        sendProfileRequest();
      }
    };
  }

  Future<MapEntry<String, CarProfileData>> loadProfileData(
      String profileId) async {
    final profileData = await LocalStorageService.getProfileData(profileId);
    return MapEntry(profileId, profileData);
  }

  MapEntry<String, CarProfileData> createNewProfileData() {
    final profileNumber = LocalStorageService.getProfileCount();
    return MapEntry('PROFILE_$profileNumber', CarProfileData());
  }

  void tagOnMenu(int index) {
    final selectedMenuItem = _dataSet[index];
    DialogUtilities.showSimpleDialog(
        getContext(), "Tag on Icon", selectedMenuItem.title, "Ok", () {});
  }

  Future<void> sendProfileRequest() async {
    final profileData = await getDraftProfileData();
    if (profileData == null) return;
    final request = await Utils.generateCarRequest(profileData, false);
    DataProfile dataProfile = new DataProfile(request, null);
    homePresenter.createProfile(dataProfile);
  }

  Future<CarProfileData> getDraftProfileData() async {
    final profileCount = LocalStorageService.getProfileCount();
    for (int profileNumber = 0; profileNumber < profileCount; profileNumber++) {
      selectedProfileId = 'PROFILE_$profileNumber';
      final localProfile =
          await LocalStorageService.getProfileData(selectedProfileId);
      if (localProfile != null) {
        return localProfile;
      }
    }
    return null;
  }

  void handleConnectionStatusChanged() {
    sendProfileRequest();
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    try {
      var location = Permission.location;
      Location locationService = new Location();
      bool isServiceEnable = await locationService.serviceEnabled();
      if (isServiceEnable) {
        if (await location.isGranted == false) {
          location.request();
        }
      } else {
        bool isServiceEnable = await locationService.requestService();
        if (isServiceEnable == false) {
          DialogUtilities.showSimpleDialog(context, 'Lưu ý',
              'Vui lòng bật chức năng định vị để tiếp tục sử dụng!', 'Ok', () {
            requestLocationPermission(context);
          });
        } else {
          requestLocationPermission(context);
        }
      }
    } catch (e) {
      DialogUtilities.showSimpleDialog(context, 'Lưu ý',
          'Vui lòng bật chức năng định vị để tiếp tục sử dụng!', 'Ok', () {
        requestLocationPermission(context);
      });
    }
  }

  genderRoleString(String role) {
    switch (role) {
      case Constant.admin:
        return Strings.admin;
        break;
      case Constant.agency:
        return Strings.agency;
        break;
      case Constant.business_staff:
        return Strings.business_staff;
        break;
      case Constant.director:
        return Strings.director;
        break;
      case Constant.officer:
        return Strings.officer;
        break;
      default:
        return "---";
    }
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.dispose();
  }
}
