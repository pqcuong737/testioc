import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/clean_arch/presenter.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/usecases/user_profile/forgot_password_usecase.dart';

class UserProfilePresenter extends Presenter {
  Function forgotPassOnComplete;
  Function forgotPassOnError;
  Function forgotPassOnNext;

  final ForGotPasswordUseCase forGotPasswordUseCase;

  UserProfilePresenter(userProfileRepo)
      : forGotPasswordUseCase = ForGotPasswordUseCase(userProfileRepo);

  @override
  void dispose() {
    forGotPasswordUseCase.dispose();
  }

  void forgotPassword(
      String currentPass, String newPass, String confirmNewPass) {
    forGotPasswordUseCase.execute(UserProfileObserver(this),
        ForGotPasswordUseCaseParam(currentPass, newPass, confirmNewPass));
  }
}

class UserProfileObserver extends Observer<ForGotPasswordUseCaseResponse> {
  UserProfilePresenter userProfilePresenter;

  UserProfileObserver(this.userProfilePresenter);

  @override
  void onComplete() {
    if (userProfilePresenter.forgotPassOnComplete != null) {
      userProfilePresenter.forgotPassOnComplete();
    }
  }

  @override
  void onError(e) {
    if (userProfilePresenter.forgotPassOnError != null) {
      userProfilePresenter.forgotPassOnError();
    }
  }

  @override
  void onNext(ForGotPasswordUseCaseResponse response) {
    if (userProfilePresenter.forgotPassOnNext != null) {
      userProfilePresenter.forgotPassOnNext(response.changePassResponse);
    }
  }
}
