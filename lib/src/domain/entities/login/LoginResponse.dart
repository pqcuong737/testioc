import 'package:mobile/src/domain/entities/BaseResponse.dart';

class LoginResponse extends BaseResponse {
  Status status;
  Result result;
  Error error;

  LoginResponse({this.status, this.result, this.error});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  int expiresIn;
  String accessToken;
  String refreshToken;
  int refreshExpiresIn;

  Result(
      {this.expiresIn,
      this.accessToken,
      this.refreshToken,
      this.refreshExpiresIn});

  Result.fromJson(Map<String, dynamic> json) {
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    refreshExpiresIn = json['refresh_expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['refresh_expires_in'] = this.refreshExpiresIn;
    return data;
  }
}
