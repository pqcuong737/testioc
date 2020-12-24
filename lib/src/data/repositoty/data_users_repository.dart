import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/entities/user.dart';
import 'package:mobile/src/domain/repositories/users_repository.dart';

class DataUsersRepository extends UsersRepository {
  List<User> users;
  // sigleton
  static DataUsersRepository _instance = DataUsersRepository._internal();
  DataUsersRepository._internal() {
    users = List<User>();
    users.addAll([
      User('test-uid', 'John Smith', 18),
      User('test-uid2', 'John Doe', 22)
    ]);
  }
  factory DataUsersRepository() => _instance;

  @override
  Future<List<User>> getAllUsers() async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data
    return users;
  }

  @override
  Future<User> getUser(String uid) async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data

    return users.firstWhere((user) => user.uid == uid);
  }

  @override
  Future<UserInfor> getUserInfor(String uid) {
    // TODO: implement getUserInfor
    return null;
  }
}