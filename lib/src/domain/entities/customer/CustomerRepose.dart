import 'package:mobile/src/domain/entities/BaseResponse.dart';

class CustomerRespose extends BaseResponse {
  Result result;
  int statusCode;
  Status status;
  Error error;

  CustomerRespose({this.result, this.statusCode, this.status, this.error});

  CustomerRespose.fromJson(Map<String, dynamic> json) {
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
  List<Items> items;
  int total;

  Result({this.items, this.total});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Items {
  int id;
  String status;
  String createdAt;
  String fullName;
  String type;
  String gender;
  String address;
  String identity;
  Owner owner;
  Owner createdBy;
  bool canRead;
  bool canWrite;

  Items(
      {this.id,
      this.status,
      this.createdAt,
      this.fullName,
      this.type,
      this.gender,
      this.address,
      this.identity,
      this.owner,
      this.createdBy,
      this.canWrite,
        this.canRead,
      });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['createdAt'];
    fullName = json['fullName'];
    type = json['type'];
    gender = json['gender'];
    address = json['address'];
    identity = json['identity'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    canRead = json['canRead'];
    canWrite = json['canWrite'];
    createdBy = json['createdBy'] != null
        ? new Owner.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['fullName'] = this.fullName;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['identity'] = this.identity;
    data['canWrite'] = this.canWrite;
    data['canRead'] = this.canRead;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    return data;
  }
}

class Owner {
  int id;
  String role;
  String fullName;

  Owner({this.id, this.role, this.fullName});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['fullName'] = this.fullName;
    return data;
  }
}
