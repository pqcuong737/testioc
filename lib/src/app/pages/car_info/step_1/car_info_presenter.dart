import 'package:dio/dio.dart';
import 'package:mobile/src/app/pages/car_info/step_3/car_image_presenter.dart';
import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/clean_arch/presenter.dart';
import 'package:mobile/src/domain/usecases/car/get_car_info_usecase.dart';
import 'package:mobile/src/domain/usecases/profile/create_profile.dart';

class CarInfoPresenter extends BaseCarPresenter {
  Function getTypeCarInfoError;
  Function getTypeCarInfo;

  final GetTypeCarInfoUseCase getTypeCarInfoUseCase;
  final CreateProfileUseCase profileUseCase;
  CarInfoPresenter(carRepo, profileRepo)
      : getTypeCarInfoUseCase = GetTypeCarInfoUseCase(carRepo),
        profileUseCase = CreateProfileUseCase(profileRepo);

  void getTypeCarData() {
    getTypeCarInfoUseCase.execute(
      GetTypeCarUseCaseObserver(this),
    );
  }

  void createProfile(List<FormData> object) {
    DataProfile dataProfile = new DataProfile(object, null);
    profileUseCase.execute(CreateProfileUseCaseObserver(this), dataProfile);
  }

  @override
  void dispose() {
    getTypeCarInfoUseCase.dispose();
    profileUseCase.dispose();
  }
}

abstract class BaseCarPresenter extends Presenter {
  Function createProfilesOnComplete;
  Function createProfilesOnError;
  Function createProfilesOnNext;
  Function navigateBackToHome;
}

class GetTypeCarUseCaseObserver extends Observer<GetTypeCarInforCaseResponse> {
  CarInfoPresenter _presenter;

  GetTypeCarUseCaseObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    if (_presenter.getTypeCarInfoError != null) {
      _presenter.getTypeCarInfoError();
    }
  }

  @override
  void onNext(GetTypeCarInforCaseResponse response) {
    if (_presenter.getTypeCarInfo != null) {
      _presenter.getTypeCarInfo(response.carResponse);
    }
  }
}
