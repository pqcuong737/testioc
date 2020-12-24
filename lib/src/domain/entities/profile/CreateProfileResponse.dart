import 'package:mobile/src/domain/entities/BaseResponse.dart';

import 'ProfileResponse.dart';

class CreateProfileResponse extends BaseResponse {
  Status status;
  Items result;
  ErrorDocument errorDocument;
  String id;

  CreateProfileResponse({this.result, this.errorDocument});

  CreateProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    result = json['result'] != null ? new Items.fromJson(json['result']) : null;

    errorDocument = json['error'] != null
        ? new ErrorDocument.fromJson(json['error'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.status != null) data['status'] = this.status.toJson();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class ErrorDocument {
  List<MessageDocument> errorDocument;
  String message;

  ErrorDocument.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      if (json['message'].toString().contains("constraints")) {
        errorDocument = new List<MessageDocument>();
        json['message'].forEach((v) {
          errorDocument.add(new MessageDocument.fromJson(v));
        });
      } else {
        message = json['message'];
      }
    }
  }
}

class MessageDocument {
  String property;
  Constraints constraints;
  String error;

  MessageDocument({this.property, this.constraints, this.error});

  MessageDocument.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    error = json['error'];
    constraints = json['constraints'] != null
        ? new Constraints.fromJson(json['constraints'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['error'] = this.error;
    if (this.constraints != null) {
      data['constraints'] = this.constraints.toJson();
    }
    return data;
  }
}

class Constraints {
  String isNotEmpty;

  Constraints({this.isNotEmpty});

  Constraints.fromJson(Map<String, dynamic> json) {
    isNotEmpty = json['isNotEmpty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isNotEmpty'] = this.isNotEmpty;
    return data;
  }
}
