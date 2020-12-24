import 'package:mobile/src/domain/entities/BaseResponse.dart';

class CustomerUpdateReponse extends BaseResponse{
  Result result;
  int statusCode;
  Status status;
  Error error;

  CustomerUpdateReponse({this.result, this.statusCode, this.status});

  CustomerUpdateReponse.fromJson(Map<String, dynamic> json) {
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
  String status;
  String createdAt;
  String updatedAt;
  String fullName;
  String phone;
  String address;
  String note;
  String type;
  String identity;
  String job;
  String gender;
  String birthday;

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
        this.job,
        this.gender,
        this.birthday});

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
    job = json['job'];
    gender = json['gender'];
    birthday = json['birthday'];
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
    data['job'] = this.job;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    return data;
  }
}

