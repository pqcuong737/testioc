

import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/repositories/base_reposiroty.dart';
import 'package:mobile/src/utility/APIProvider.dart';

class UserProfileRepository extends BaseRepository {

  APIProvider _apiProvider = APIProvider();

  Future<ChangePassResponse> changePassword(String currentPass, String newPass, String confirmNewPass){
    return _apiProvider.changePassword(currentPass, newPass, confirmNewPass);
  }


}