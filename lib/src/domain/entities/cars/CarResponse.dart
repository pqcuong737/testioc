class CarResponse {
  int statusCode;
  Result result;
  Error error;

  CarResponse({this.statusCode, this.result, this.error});

  CarResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
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
  String name;
  String description;
  String status;
  List<CylinderItem> cylinders;

  Items({this.id, this.name, this.description, this.status});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    if (json['cylinders'] != null) {
      cylinders = new List<CylinderItem>();
      json['cylinders'].forEach((v) {
        cylinders.add(new CylinderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.cylinders != null) {
      data['cylinders'] = this.cylinders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CylinderItem {
  int id;
  String name;
  String description;
  String status;

  CylinderItem({this.id, this.name, this.description, this.status});

  CylinderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data[description] = this.description;
    data['status'] = this.status;
    return data;
  }
}

class Error {
  Error();

  Error.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
