import 'package:mobile/src/domain/entities/cars/CarResponse.dart';
import 'package:mobile/src/domain/entities/cars/TypeCarResponse.dart';
import 'package:mobile/src/utility/APIProvider.dart';

class CarRepository {
  APIProvider _apiProvider = APIProvider();
  Future<TypeCarResponse> getAllCarTypes() {
    return _apiProvider.getAllCarTypes();
  }
}