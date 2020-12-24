import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/clean_arch/presenter.dart';
import 'package:mobile/src/domain/entities/profile/ProfileDetailReponse.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/usecases/profile/get_all_pofile.dart';
import 'package:mobile/src/domain/usecases/profile/get_profile_by_id.dart';

class ProfilePresenter extends Presenter {
  //! GET LIST DOC IOC
  Function getProfilesOnComplete;
  Function getProfilesOnError;
  Function getProfilesOnNext;

  //! GET DOC IOC
  Function getIocOncomplete;
  Function getIocOnError;
  Function getIocOnNext;

  //? USE CASE
  final GetAllProfilesUseCase getAllProfilesUseCase;
  final GetIocByIdUseCase getIocByIdUseCase;

  ProfilePresenter(profileRepo)
      : getAllProfilesUseCase = GetAllProfilesUseCase(profileRepo),
        getIocByIdUseCase = GetIocByIdUseCase(profileRepo);

  ///Excute Usecase
  ProfileResponse getAllProfiles(Map objectSearch) {
    getAllProfilesUseCase.execute(
        GetAllProfilesUseCaseObserver(this), Params(objectSearch));
  }

  ProfileDetailResponse getProfileByIdPresenter(int idDoc) {
    getIocByIdUseCase.execute(GetProFileUseCaseObserver(this), IdDoc(idDoc));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getAllProfilesUseCase.dispose();
  }
}

//! Get all profile
class GetAllProfilesUseCaseObserver extends Observer<GetAllProfilesResponse> {
  ProfilePresenter profilePresenter;

  GetAllProfilesUseCaseObserver(this.profilePresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
    if (profilePresenter.getProfilesOnComplete != null) {
      profilePresenter.getProfilesOnComplete();
    }
  }

  @override
  void onNext(GetAllProfilesResponse response) {
    // TODO: implement onNext
    if (profilePresenter.getProfilesOnComplete != null) {
      profilePresenter.getProfilesOnNext(response.profileResponse);
    }
  }

  @override
  void onError(e) {
    // TODO: implement onError
    if (profilePresenter.getProfilesOnError != null) {
      profilePresenter.getProfilesOnError();
    }
  }
}

//! Get Profile by id
class GetProFileUseCaseObserver extends Observer<ResponseIocByIdSwap> {
  ProfilePresenter profilePresenter;

  GetProFileUseCaseObserver(this.profilePresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
    if (profilePresenter.getIocOncomplete != null) {
      profilePresenter.getIocOncomplete();
    }
  }

  @override
  void onNext(ResponseIocByIdSwap response) {
    // TODO: implement onNext
    if (profilePresenter.getIocOnNext != null) {
      profilePresenter.getIocOnNext(response.profileDetailResponse);
    }
  }

  @override
  void onError(e) {
    // TODO: implement onError
    if (profilePresenter.getIocOnError != null) {
      profilePresenter.getIocOnError();
    }
  }
}
