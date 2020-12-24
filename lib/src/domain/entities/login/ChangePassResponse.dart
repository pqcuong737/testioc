import 'package:mobile/src/domain/entities/BaseResponse.dart';

class ChangePassResponse extends BaseResponse {
  Result result;
  int statusCode;
  Status status;
  Error error;


  ChangePassResponse({this.result, this.statusCode, this.status, this.error});

  ChangePassResponse.fromJson(Map<String, dynamic> json) {
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
        this.avatarUrl});

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
    return data;
  }
}
