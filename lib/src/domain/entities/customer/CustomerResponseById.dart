import 'package:mobile/src/domain/entities/BaseResponse.dart';

class CustomerResposeById extends BaseResponse{
  Result result;
  int statusCode;
  Status status;
  Error error;

  CustomerResposeById({this.result, this.statusCode, this.status});

  CustomerResposeById.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
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
  String status;
  String createdAt;
  String updatedAt;
  String fullName;
  String phone;
  String address;
  String note;
  String type;
  String identity;
  String website;
  Owner owner;
  Owner createdBy;
  String birthday;
  String gender;
  String job;

  Result(
      {this.id,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.phone,
      this.address,
      this.note,
      this.type,
      this.identity,
      this.website,
      this.owner,
      this.createdBy,
      this.birthday,
      this.gender,
      this.job,
      });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    fullName = json['fullName'];
    phone = json['phone'];
    address = json['address'];
    note = json['note'];
    type = json['type'];
    identity = json['identity'];
    website = json['website'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    createdBy = json['createdBy'] != null
        ? new Owner.fromJson(json['createdBy'])
        : null;
    birthday = json['birthday'];
    gender = json['gender'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['note'] = this.note;
    data['type'] = this.type;
    data['identity'] = this.identity;
    data['website'] = this.website;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['job'] = this.job;
    return data;
  }
}

class Owner {
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
  String address;
  String avatarUrl;

  Owner(
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
      this.address,
      this.avatarUrl});

  Owner.fromJson(Map<String, dynamic> json) {
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
    address = json['address'];
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
    data['address'] = this.address;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}