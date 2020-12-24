import 'package:mobile/src/domain/entities/BaseResponse.dart';
import 'package:mobile/src/domain/entities/login/ChangePassResponse.dart';
import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/utility/APIProvider.dart';

import '../users_repository.dart';

class LoginRepository extends UsersRepository{

  APIProvider _apiProvider = APIProvider();

  Future<LoginResponse> authenticateUser(String userID, String password) {
      return _apiProvider.authenticateUser(userID, password);
  }

  @override
  Future<UserInfor> getUserInfor(String uid) {
    return _apiProvider.getUserInfor(uid);
  }


  @override
  Future<ChangePassResponse> forgotPassword(String email) {
    return _apiProvider.forgotPassword(email);
  }
}