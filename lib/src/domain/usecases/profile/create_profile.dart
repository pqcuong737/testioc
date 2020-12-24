import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/profile/CreateProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/Strings.dart';

class CreateProfileUseCase
    extends UseCase<SwapperCreateProfileResponse, DataProfile> {
  final ProfileRepository profileRespository;

  ///Constructer
  CreateProfileUseCase(this.profileRespository);

  @override
  Future<Stream<SwapperCreateProfileResponse>> buildUseCaseStream(
      DataProfile data) async {
    final StreamController<SwapperCreateProfileResponse> controller =
        StreamController();
    try {
      final fields = data.objectProfile[0].fields;
      String status;
      for (int i = 0; i < fields.length; i++) {
        final map = fields[i];
        if (map.key == 'status') status = map.value;
      }

      CreateProfileResponse createProfileResponse;
      if (status == Strings.STATUS_COMPLETED) {
        createProfileResponse =
            await profileRespository.createAndUpdateProfileRepository(
                data.objectProfile, data.listImagesExtendID);
      } else {
        createProfileResponse =
            await profileRespository.createProfileRepository(
                data.objectProfile, data.listImagesExtendID);
      }

      /*if (data.objectProfile.length > 2 &&
          data.objectProfile[2] != null &&
          data.objectProfile[2].files != null &&
          data.objectProfile[2].files.length > 0) {
        data.objectProfile[2].fields
            .add(new MapEntry("id", createProfileResponse.id.toString()));
        profileRespository.updateProfileVideo(data.objectProfile[2]);
      }
      if (data.objectProfile.length > 1 &&
          data.objectProfile[1] != null &&
          data.objectProfile[1].files != null &&
          data.objectProfile[1].files.length > 0) {
        data.objectProfile[1].fields
            .add(new MapEntry("id", createProfileResponse.id.toString()));
        profileRespository.updateProfileImage(data.objectProfile[1]);
      }*/

      controller.add(SwapperCreateProfileResponse(createProfileResponse));
      controller.close();
      /*CreateProfileResponse createProfileResponse = await profileRespository.createProfileRepository(data.objectProfile[0]);
      if (createProfileResponse.statusCode == 200) {
        final fields = data.objectProfile[0].fields;
        String status;
        for (int i = 0; i < fields.length; i++) {
          final map = fields[i];
          if (map.key == 'status') status = map.value;
        }
        if (status == Strings.STATUS_COMPLETED) {
          CreateProfileResponse createProfileResponseupdate =
              await profileRespository.convertProfileStatus2Complete(
                  createProfileResponse.result.id.toString());
          controller
              .add(SwapperCreateProfileResponse(createProfileResponseupdate));
          controller.close();
        } else {
          controller.add(SwapperCreateProfileResponse(createProfileResponse));
          controller.close();
        }
      } else {
        controller.add(SwapperCreateProfileResponse(createProfileResponse));
        controller.close();
      }*/
    } catch (e) {
      logger.e('Create profile unsuccessful');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class DataProfile {
  final List<FormData> objectProfile;
  final List<String> listImagesExtendID;
  DataProfile(this.objectProfile, this.listImagesExtendID);
}

class SwapperCreateProfileResponse {
  final CreateProfileResponse createProfileResponse;
  SwapperCreateProfileResponse(this.createProfileResponse);
}
