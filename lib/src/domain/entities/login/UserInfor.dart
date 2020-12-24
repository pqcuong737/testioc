import 'package:mobile/src/domain/entities/BaseResponse.dart';

class UserInfor extends BaseResponse {
  Result result;
  Error error;
  int statusCode;
  Status status;

  UserInfor({this.result, this.statusCode, this.status});

  UserInfor.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['statusCode'] = this.statusCode;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Result {
  int id;
  String email;
  String password;
  String status;
  String role;
  String lastLogin;
  String createdAt;
  String updatedAt;
  String oauthGoogleId;
  String oauthFacebookId;
  String fullName;
  String description;
  String phone;
  String identity;
  String dateIssue;
  String placeIssue;
  String address;
  bool isDeleted;
  String avatarUrl;
  List<UserGroups> userGroups;

  Result(
      {this.id,
      this.email,
      this.password,
      this.status,
      this.role,
      this.lastLogin,
      this.createdAt,
      this.updatedAt,
      this.oauthGoogleId,
      this.oauthFacebookId,
      this.fullName,
      this.description,
      this.phone,
      this.identity,
      this.dateIssue,
      this.placeIssue,
      this.address,
      this.isDeleted,
      this.avatarUrl,
      this.userGroups});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    role = json['role'];
    lastLogin = json['lastLogin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    oauthGoogleId = json['oauthGoogleId'];
    oauthFacebookId = json['oauthFacebookId'];
    fullName = json['fullName'];
    description = json['description'];
    phone = json['phone'];
    identity = json['identity'];
    dateIssue = json['dateIssue'];
    placeIssue = json['placeIssue'];
    address = json['address'];
    isDeleted = json['isDeleted'];
    avatarUrl = json['avatarUrl'];
    if (json['userGroups'] != null) {
      userGroups = new List<UserGroups>();
      json['userGroups'].forEach((v) {
        userGroups.add(new UserGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['status'] = this.status;
    data['role'] = this.role;
    data['lastLogin'] = this.lastLogin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['oauthGoogleId'] = this.oauthGoogleId;
    data['oauthFacebookId'] = this.oauthFacebookId;
    data['fullName'] = this.fullName;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['identity'] = this.identity;
    data['dateIssue'] = this.dateIssue;
    data['placeIssue'] = this.placeIssue;
    data['address'] = this.address;
    data['isDeleted'] = this.isDeleted;
    data['avatarUrl'] = this.avatarUrl;
    if (this.userGroups != null) {
      data['userGroups'] = this.userGroups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserGroups {
  int id;
  bool isManager;
  String createdAt;
  String updatedAt;
  Group group;

  UserGroups(
      {this.id, this.isManager, this.createdAt, this.updatedAt, this.group});

  UserGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isManager = json['isManager'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isManager'] = this.isManager;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    return data;
  }
}

class Group {
  int id;
  String code;
  String name;
  String address;
  String phone;
  bool active;
  bool isDeleted;
  String createdAt;
  String updatedAt;
  int type;

  Group(
      {this.id,
      this.code,
      this.name,
      this.address,
      this.phone,
      this.active,
      this.isDeleted,
      this.createdAt,
      this.type,
      this.updatedAt});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    active = json['active'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['active'] = this.active;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['type'] = this.type;
    return data;
  }
}
