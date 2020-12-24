import 'package:mobile/src/app/pages/profile/profile_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/profile/ProfileDetailReponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart'
    as Profile;

class ProfileController extends Controller {
  final ProfilePresenter profilePresenter;

  ///Create Response
  ProfileResponse _profileResponse;
  ProfileDetailResponse _profileDetailResponse;
  var totalList = [];
  bool checkLoadMore = false;

  ///Get Response
  ProfileResponse get profileResponse => _profileResponse;
  ProfileDetailResponse get profileDetailResponse => _profileDetailResponse;

  ProfileController(profileRepo)
      : profilePresenter = ProfilePresenter(profileRepo),
        super();

  @override
  void initListeners() {
    profilePresenter.getProfilesOnComplete = () {};

    profilePresenter.getProfilesOnError = () {
      _profileResponse = null;
    };

    profilePresenter.getProfilesOnNext = (ProfileResponse profileResponse) {
      _profileResponse = profileResponse;
      refreshUI();
    };

    //! GET DOCUMENT IOC
    profilePresenter.getIocOnNext =
        (ProfileDetailResponse profileDetailResponse) {
      _profileDetailResponse = profileDetailResponse;
      refreshUI();
    };
  }

  final limit = Constant.DEFAULT_LIMIT;
  final page = 1;

  Future<ProfileResponse> getAllProfile(
      objectSearch, bool flagCheckUpdatePage) async {
    objectSearch['page'] = page;
    objectSearch['limit'] = limit;

    //? Check load more for function getAllProfilesPagination()
    checkLoadMore = flagCheckUpdatePage;

    //? Check load more true or false for get list ioc provider api
    objectSearch['isLoadMore'] = flagCheckUpdatePage;

    ///Set limit to show more
    if (flagCheckUpdatePage) {
      final pageStore = await LocalStorageService.getPageList();
      print("---> New page stored $pageStore");
      var newPage = pageStore + page;
      if (newPage == page) {
        newPage = newPage + page;
      }
      LocalStorageService.savePageList(newPage);
      objectSearch['page'] = newPage;
    }
    _profileResponse = profilePresenter.getAllProfiles(objectSearch);
  }

  getAllProfilesPagination() {
    final flagCheckNull =
        profileResponse?.result != null ? profileResponse.result.items : [];
    final oldListProfiles = [...flagCheckNull];
    if (checkLoadMore == false) {
      totalList = flagCheckNull;
    } else {
      for (int i = 0; i < oldListProfiles.length; i++) {
        totalList.add(oldListProfiles[i]);
      }
    }
    if (totalList != null) {
      return totalList;
    } else {
      return [];
    }
  }

  //TODO Get total of profile offline
  Future<int> getTotalProfileOffline() async {
    final total = await LocalStorageService.getProfileCount();
    return total;
  }

  //TODO Get profile data base id
  Future<Profile.CarProfileData> loadProfileOfflineData(
      String profileId) async {
    final profileData = await LocalStorageService.getProfileData(profileId);
    return profileData;
  }


  //TODO Get list profile offline
  Future getListProfileOffile() async {
    List list = [];
    final total = await LocalStorageService.getProfileCount();
    for (var i = 1; i <= total; i++) {
      final profileId = "PROFILE_${i - 1}";
      final profileResponse = await loadProfileOfflineData(profileId);
      if (profileResponse != null) {
        profileResponse.idOffline = profileId;
        list.add(profileResponse);
      }
    }
    return list;
  }

  //TODO GET DOCUMENT BY ID
  Future<void> getDocumentByIdController(int idDoc) {
    _profileDetailResponse = profilePresenter.getProfileByIdPresenter(idDoc);
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void dispose() {
    profilePresenter.dispose();
  }
}
