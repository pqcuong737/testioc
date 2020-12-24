import 'package:mobile/src/domain/entities/BaseResponse.dart';

class CreateCustomerResponse extends BaseResponse {
  Result result;
  int statusCode;
  Status status;
  Error error;

  CreateCustomerResponse({this.result, this.statusCode, this.status});

  CreateCustomerResponse.fromJson(Map<String, dynamic> json) {
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
  String email;
  String fullName;
  String type;
  String status;
  String gender;
  String phone;
  String address;
  String job;
  String birthday;
  String identity;
  String note;
  int ownerId;
  CreatedBy createdBy;
  CreatedBy owner;
  int id;
  String createdAt;
  String updatedAt;

  Result(
      {this.email,
        this.fullName,
        this.type,
        this.status,
        this.gender,
        this.phone,
        this.address,
        this.job,
        this.birthday,
        this.identity,
        this.note,
        this.ownerId,
        this.createdBy,
        this.owner,
        this.id,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    type = json['type'];
    status = json['status'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    job = json['job'];
    birthday = json['birthday'];
    identity = json['identity'];
    note = json['note'];
    ownerId = json['ownerId'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    owner =
    json['owner'] != null ? new CreatedBy.fromJson(json['owner']) : null;
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['type'] = this.type;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['job'] = this.job;
    data['birthday'] = this.birthday;
    data['identity'] = this.identity;
    data['note'] = this.note;
    data['ownerId'] = this.ownerId;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CreatedBy {
  int id;
  String email;
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

  CreatedBy(
      {this.id,
        this.email,
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

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
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

