
import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/profile/ProfileDetailReponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';

class GetIocByIdUseCase extends UseCase<ResponseIocByIdSwap, IdDoc> {
  final ProfileRepository profileRepository;
  GetIocByIdUseCase(this.profileRepository);

  @override
  Future<Stream<ResponseIocByIdSwap>> buildUseCaseStream(IdDoc idDoc) async {
    final StreamController<ResponseIocByIdSwap> controller = StreamController();
    try {
      ProfileDetailResponse profileDetailResponse  = await profileRepository.getProfileRepository(idDoc.idDoc);
      controller.add(ResponseIocByIdSwap(profileDetailResponse));
      controller.close();
    } catch (e) {
      logger.e("Get Doc by id error at usecase: $e");
      controller.addError(e);
    }
    return controller.stream;
  }
}


class IdDoc {
  int idDoc;

  IdDoc(this.idDoc);
}

class ResponseIocByIdSwap {
  final ProfileDetailResponse profileDetailResponse;

  ResponseIocByIdSwap(this.profileDetailResponse);
}
