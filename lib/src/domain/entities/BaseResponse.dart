abstract class BaseResponse {
  int statusCode;
  Status status;
  Error error;

}

class Status {
  int statusCode;
  String timestamp;
  String path;

  Status({this.statusCode, this.timestamp, this.path});

  Status.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['timestamp'] = this.timestamp;
    data['path'] = this.path;
    return data;
  }
}

class Error {
  String message;

  Error({this.message});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}