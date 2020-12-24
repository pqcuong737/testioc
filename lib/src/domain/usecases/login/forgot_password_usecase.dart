
import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/BaseResponse.dart';
import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/repositories/login/login_repository.dart';
import 'package:mobile/src/domain/usecases/customer/get_all_customer.dart';

class ForgotPasswordUseCase extends UseCase<ForgotPasswordUseCaseResponse, ForgotPasswordUseCaseParam>{
  final LoginRepository loginRepository;
  ForgotPasswordUseCase(this.loginRepository);

  @override
  Future<Stream<ForgotPasswordUseCaseResponse>> buildUseCaseStream(ForgotPasswordUseCaseParam params) async{
    final StreamController<ForgotPasswordUseCaseResponse> controller = StreamController();
    try{
      //get Login Response
      ChangePassResponse changePassResponse = await loginRepository.forgotPassword(params.email);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(ForgotPasswordUseCaseResponse(changePassResponse));
//      logger.finest('GetUserLoginCaseResponse successful.');
      controller.close();
    }catch(e){
      logger.e('ForgotPasswordUseCaseResponse unsuccessful, ${e.toString()}');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }

}


/// Wrapping params inside an object makes it easier to change later
class ForgotPasswordUseCaseParam {
  final String email;
  ForgotPasswordUseCaseParam(this.email);
}


/// Wrapping response inside an object makes it easier to change later
class ForgotPasswordUseCaseResponse {
  final ChangePassResponse changePassResponse;
  ForgotPasswordUseCaseResponse(this.changePassResponse);
}