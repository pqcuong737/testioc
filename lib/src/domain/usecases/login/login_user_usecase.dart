
import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/repositories/login/login_repository.dart';

class LoginUserUseCase extends UseCase<GetUserLoginCaseResponse, GetUserLoginUseCaseParam>{
  final LoginRepository loginRepository;
  LoginUserUseCase(this.loginRepository);

  @override
  Future<Stream<GetUserLoginCaseResponse>> buildUseCaseStream(
      GetUserLoginUseCaseParam params) async {
    final StreamController<GetUserLoginCaseResponse> controller = StreamController();
    try{
      //get Login Response
      LoginResponse loginResponse = await loginRepository.authenticateUser(params.userID, params.password);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetUserLoginCaseResponse(loginResponse));
//      logger.finest('GetUserLoginCaseResponse successful.');
      controller.close();
    }catch(e){
      logger.e('GetUserLoginCaseResponse unsuccessful, ${e.toString()}');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}


/// Wrapping params inside an object makes it easier to change later
class GetUserLoginUseCaseParam {
  final String userID;
  final String password;
  GetUserLoginUseCaseParam(this.userID, this.password);
}


/// Wrapping response inside an object makes it easier to change later
class GetUserLoginCaseResponse {
  final LoginResponse loginResponse;
  GetUserLoginCaseResponse(this.loginResponse);
}