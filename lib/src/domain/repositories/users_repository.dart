import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';

import '../entities/user.dart';

abstract class UsersRepository {
  Future<UserInfor> getUserInfor(String uid);
}
