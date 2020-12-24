import 'package:mobile/src/app/pages/car_info/step_1/car_info_presenter.dart';
import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/domain/usecases/profile/create_profile.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';

class CarImagePresenter extends BaseCarPresenter {
  final CreateProfileUseCase useCase;

  CarImagePresenter(profileRepo) : useCase = CreateProfileUseCase(profileRepo);

  void createProfile(DataProfile object) {
    useCase.execute(CreateProfileUseCaseObserver(this), object);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    useCase.dispose();
  }
}

class CreateProfileUseCaseObserver
    extends Observer<SwapperCreateProfileResponse> {
  BaseCarPresenter _presenter;

  CreateProfileUseCaseObserver(this._presenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
    if (_presenter.createProfilesOnComplete != null) {
      LoggerUtil().logger.e('Create profile completed');
      _presenter.createProfilesOnComplete();
    }
  }

  @override
  void onError(e) {
    // TODO: implement onError
    if (_presenter.createProfilesOnError != null) {
      LoggerUtil().logger.e('error message create profile $e');
      _presenter.createProfilesOnError();
    }
  }

  @override
  void onNext(SwapperCreateProfileResponse response) {
    // TODO: implement onNext
    if (_presenter.createProfilesOnNext != null) {
      final createProfileResponse = response.createProfileResponse;
      LoggerUtil().logger.e('Create profile onNext $createProfileResponse');
      _presenter.createProfilesOnNext(createProfileResponse);
    }
  }
}
