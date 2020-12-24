

import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/clean_arch/presenter.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/usecases/login/forgot_password_usecase.dart';
import 'package:mobile/src/domain/usecases/login/get_user_infor_usecase.dart';
import 'package:mobile/src/domain/usecases/login/login_user_usecase.dart';

class LoginScreenPresenter extends Presenter{

  Function getLoginOnComplete;
  Function getLoginOnError;
  Function getLoginOnNext;

  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function forgotPasswordOnNext;
  Function forgotPasswordOnComplete;
  Function forgotPasswordOnError;

  final LoginUserUseCase loginUserUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  LoginScreenPresenter(loginRepo) :
        loginUserUseCase = LoginUserUseCase(loginRepo),
        getUserInfoUseCase = GetUserInfoUseCase(loginRepo),
        forgotPasswordUseCase = ForgotPasswordUseCase(loginRepo);

  LoginResponse authenticateUser(String userId, String password){
    loginUserUseCase.execute(GetLoginUseCaseObserver(this), GetUserLoginUseCaseParam(userId, password));
  }

  void getUserInfor(String userId){
    getUserInfoUseCase.execute(GetUseInforCaseObserver(this), GetUserInforUseCaseParam(userId));
  }

  void forgotPassword(email){
    forgotPasswordUseCase.execute(ForgotPasswordUseCaseObserver(this), ForgotPasswordUseCaseParam(email));
  }

  @override
  void dispose() {
    loginUserUseCase.dispose();
  }

}

class GetLoginUseCaseObserver extends Observer<GetUserLoginCaseResponse>{
  LoginScreenPresenter loginPresenter;
  GetLoginUseCaseObserver(this.loginPresenter);
  @override
  void onComplete() {
    if(loginPresenter.getLoginOnComplete != null)
      loginPresenter.getLoginOnComplete();

  }

  @override
  void onError(e) {
    if(loginPresenter?.getLoginOnError != null)
      loginPresenter?.getLoginOnError(e);
  }

  @override
  void onNext(response) {
    if(loginPresenter.getLoginOnNext != null)
      loginPresenter.getLoginOnNext(response.loginResponse);

  }

}

class GetUseInforCaseObserver extends Observer<GetUserInforCaseResponse>{
  LoginScreenPresenter loginPresenter;
  GetUseInforCaseObserver(this.loginPresenter);
  @override
  void onComplete() {
    if(loginPresenter.getUserOnComplete != null)
      loginPresenter.getUserOnComplete();

  }

  @override
  void onError(e) {
    if(loginPresenter.getUserOnError != null)
      loginPresenter.getUserOnError();


  }

  @override
  void onNext(response) {
    if(loginPresenter.getUserOnNext != null)
      loginPresenter.getUserOnNext(response.userInfor);

  }
}

class ForgotPasswordUseCaseObserver extends Observer<ForgotPasswordUseCaseResponse>{
  LoginScreenPresenter loginPresenter;

  ForgotPasswordUseCaseObserver(this.loginPresenter);

  @override
  void onComplete() {
    if(loginPresenter.forgotPasswordOnComplete != null){
      loginPresenter.forgotPasswordOnComplete();
    }
  }

  @override
  void onError(e) {
    if(loginPresenter.forgotPasswordOnError != null){
      loginPresenter.forgotPasswordOnError(e);
    }
  }

  @override
  void onNext(response) {
    if(loginPresenter.forgotPasswordOnNext != null){
      loginPresenter.forgotPasswordOnNext(response.changePassResponse);
    }
  }

}