import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';

class GetAllProfilesUseCase extends UseCase<GetAllProfilesResponse, Params> {
  final ProfileRepository profileRepository;

  GetAllProfilesUseCase(this.profileRepository);

  @override
  Future<Stream<GetAllProfilesResponse>> buildUseCaseStream(
      Params params) async {
    final StreamController<GetAllProfilesResponse> controller =
        StreamController();
    try {
      ProfileResponse profileResponse =
          await profileRepository.getAllProfiles(params.objectSearch);
      controller.add(GetAllProfilesResponse(profileResponse));
      controller.close();
    } catch (e) {
      logger.e("Get all profile error at usecase: $e");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class Params {
  final Map objectSearch;

  Params(this.objectSearch);
}

class GetAllProfilesResponse {
  final ProfileResponse profileResponse;

  GetAllProfilesResponse(this.profileResponse);
}
