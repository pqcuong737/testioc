import 'package:mobile/src/app/pages/car_info/step_1/car_info_presenter.dart';
import 'package:mobile/src/app/pages/car_info/step_3/car_image_presenter.dart';
import 'package:mobile/src/domain/usecases/profile/create_profile.dart';

class HomePresenter extends BaseCarPresenter {
  final CreateProfileUseCase profileUseCase;
  HomePresenter(profileRepo)
      : profileUseCase = CreateProfileUseCase(profileRepo);

  void createProfile(DataProfile dataProfile) {
    profileUseCase.execute(CreateProfileUseCaseObserver(this), dataProfile);
  }

  @override
  void dispose() {
    profileUseCase.dispose();
  }
}
