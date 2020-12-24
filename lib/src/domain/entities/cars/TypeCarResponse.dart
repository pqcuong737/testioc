class TypeCarResponse {
  int statusCode;
  Result result;
  Error error;

  TypeCarResponse({
    this.statusCode, this.result, this.error
  });

  TypeCarResponse.fromJson(Map<String, dynamic> json){
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
  List<CarItem> items;
  int total;

  Result({
    this.items, this.total
  });

  Result.fromJson(Map<String, dynamic> json)

  {
    if (json['items'] != null) {
      items = new List<CarItem>();
      json['items'].forEach((v) {
        items.add(new CarItem.fromJson(v));
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

class CarItem {
  int id;
  String name;
  String description;
  String status;
  List<TypeCarItem> cars;

  CarItem({
    this.id,
    this.name,
    this.description,
    this.status
  });

  CarItem.fromJson(Map<String, dynamic> json)

  {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    if (json['children'] != null) {
      cars = new List<TypeCarItem>();
      json['children'].forEach((v) {
        cars.add(new TypeCarItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.cars != null) {
      data['children'] = this.cars.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypeCarItem {
  int id;
  String name;
  String description;
  String status;

  TypeCarItem({
    this.id,
    this.name,
    this.description,
    this.status
  });

  TypeCarItem.fromJson(Map<String, dynamic> json)

  {
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
