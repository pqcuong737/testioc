
import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/repositories/login/login_repository.dart';

class GetUserInfoUseCase extends UseCase<GetUserInforCaseResponse, GetUserInforUseCaseParam>{
  final LoginRepository loginRepository;
  GetUserInfoUseCase(this.loginRepository);

  @override
  Future<Stream<GetUserInforCaseResponse>> buildUseCaseStream(
      GetUserInforUseCaseParam params) async {
    final StreamController<GetUserInforCaseResponse> controller = StreamController();
    try{
      //get Login Response
      UserInfor userInfor = await loginRepository.getUserInfor(params.userID);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetUserInforCaseResponse(userInfor));
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
class GetUserInforUseCaseParam {
  final String userID;
  GetUserInforUseCaseParam(this.userID);
}


/// Wrapping response inside an object makes it easier to change later
class GetUserInforCaseResponse {
  final UserInfor userInfor;
  GetUserInforCaseResponse(this.userInfor);
}