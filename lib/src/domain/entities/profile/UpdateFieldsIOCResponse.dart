import 'package:mobile/src/domain/entities/BaseResponse.dart';

import 'ProfileResponse.dart';

class UpdateFieldsIOCResponse extends BaseResponse {
  Status status;
  Items result;
  Error error;
  String id;

  UpdateFieldsIOCResponse({this.result, this.error});

  UpdateFieldsIOCResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    result = json['result'] != null ? new Items.fromJson(json['result']) : null;

    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
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
