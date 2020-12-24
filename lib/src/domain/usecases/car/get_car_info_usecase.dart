
import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/cars/TypeCarResponse.dart';
import 'package:mobile/src/domain/repositories/cars/car_repository.dart';

class GetTypeCarInfoUseCase extends UseCase<GetTypeCarInforCaseResponse, String>{
  final CarRepository carRepository;
  GetTypeCarInfoUseCase(this.carRepository);

  @override
  Future<Stream<GetTypeCarInforCaseResponse>> buildUseCaseStream(String param) async {
    final StreamController<GetTypeCarInforCaseResponse> controller = StreamController();
    try{
      //get Login Response
      TypeCarResponse carResponse = await carRepository.getAllCarTypes();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetTypeCarInforCaseResponse(carResponse));
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

/// Wrapping response inside an object makes it easier to change later
class GetTypeCarInforCaseResponse {
  final TypeCarResponse carResponse;
  GetTypeCarInforCaseResponse(this.carResponse);
}