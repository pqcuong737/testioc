import 'package:dio/dio.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileDetailReponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/APIProvider.dart';

class ProfileRepository {
  APIProvider _apiProvider = APIProvider();
  Future<ProfileResponse> getAllProfiles(Map objectSearch) {
    return _apiProvider.getAllProfiles(objectSearch);
  }

  ///Create profile
  Future<CreateProfileResponse> createProfileRepository(
      List<FormData> objectCreateProfile,
      List<String> listImagesExtendID) async {
    return _apiProvider.createProfile(objectCreateProfile, listImagesExtendID);
  }

  Future<CreateProfileResponse> updateProfileImage(
      FormData objectCreateProfile) async {
    return _apiProvider.updateProfile(objectCreateProfile);
  }

  Future<CreateProfileResponse> createAndUpdateProfileRepository(
      List<FormData> objectCreateProfile, List<String> listImagesExtendID) {
    return _apiProvider.createAndUpdateProfileRepository(
        objectCreateProfile, listImagesExtendID);
  }

  Future<CreateProfileResponse> updateProfileVideo(
      FormData objectCreateProfile) async {
    return _apiProvider.updateProfile(objectCreateProfile);
  }

  //! GET DOC BY ID
  Future<ProfileDetailResponse> getProfileRepository(int idDoc) async {
    return _apiProvider.getDocById(idDoc);
  }
}
