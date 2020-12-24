import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/repositories/user_profile/user_profile_repository.dart';

class ForGotPasswordUseCase
    extends UseCase<ForGotPasswordUseCaseResponse, ForGotPasswordUseCaseParam> {
  final UserProfileRepository _profileRepository;

  ForGotPasswordUseCase(this._profileRepository);

  @override
  Future<Stream<ForGotPasswordUseCaseResponse>> buildUseCaseStream(ForGotPasswordUseCaseParam params) async{
    final StreamController<ForGotPasswordUseCaseResponse> controller =
    StreamController();

    try {
      //get Login Response
      ChangePassResponse changePassResponse = await _profileRepository.changePassword(
          params.currentPass, params.newPass, params.confirmNewpass);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(ForGotPasswordUseCaseResponse(changePassResponse));
//      logger.finest('GetUserLoginCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.e('ForGotPasswordUseCaseResponse unsuccessful, ${e.toString()}');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }

}

/// Wrapping params inside an object makes it easier to change later
class ForGotPasswordUseCaseParam {
  final String currentPass;
  final String newPass;
  final String confirmNewpass;

  ForGotPasswordUseCaseParam(
      this.currentPass, this.newPass, this.confirmNewpass);
}

/// Wrapping response inside an object makes it easier to change later
class ForGotPasswordUseCaseResponse {
  final ChangePassResponse changePassResponse;

  ForGotPasswordUseCaseResponse(this.changePassResponse);
}
