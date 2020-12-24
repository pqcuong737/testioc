import 'package:mobile/src/domain/entities/BaseResponse.dart';

class ProfileResponse extends BaseResponse {
  Result result;
  int statusCode;
  Status status;
  Error error;

  ProfileResponse({this.result, this.statusCode, this.status});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String licensePlates;
  String chassisNumber;
  String vehicleNumber;
  String printeMattersNumber;
  String contractNumber;
  String effectiveDate;
  int priceCar;
  int manufacturingYear;
  int usedYear;
  bool vehicleStatusIsNormal;
  String vehicleStatus;
  bool isScratched;
  String scratches;
  bool extraAccessories;
  String upgradeCar;
  String note;
  String cylinder;
  String imgCarFrontPositionRight;
  String imgCarFrontPositionLeft;
  String imgCarRearPositionRight;
  String imgCarRearPositionLeft;
  String imgChassis;
  String imgWindshield;
  String video;
  String status;
  String createdAt;
  String updatedAt;
  String approvedDate;
  String latitude;
  String longitude;
  bool isDeleted;
  bool isOnline;
  Customer customer;
  CreatedBy createdBy;
  List<ImageExtends> imageExtends;
  CarCategory carCategory;
  int createdById;

  Items(
      {this.id,
      this.licensePlates,
      this.chassisNumber,
      this.vehicleNumber,
      this.printeMattersNumber,
      this.contractNumber,
      this.effectiveDate,
      this.priceCar,
      this.manufacturingYear,
      this.usedYear,
      this.vehicleStatusIsNormal,
      this.vehicleStatus,
      this.isScratched,
      this.scratches,
      this.extraAccessories,
      this.upgradeCar,
      this.note,
      this.cylinder,
      this.imgCarFrontPositionRight,
      this.imgCarFrontPositionLeft,
      this.imgCarRearPositionRight,
      this.imgCarRearPositionLeft,
      this.imgChassis,
      this.video,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.approvedDate,
      this.latitude,
      this.longitude,
      this.isDeleted,
      this.isOnline,
      this.customer,
      this.createdBy,
      this.imageExtends,
      this.carCategory,
      this.imgWindshield,
      this.createdById});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    licensePlates = json['licensePlates'];
    chassisNumber = json['chassisNumber'];
    vehicleNumber = json['vehicleNumber'];
    printeMattersNumber = json['printeMattersNumber'];
    contractNumber = json['contractNumber'];
    effectiveDate = json['effectiveDate'];
    priceCar = json['priceCar'];
    manufacturingYear = json['manufacturingYear'];
    usedYear = json['usedYear'];
    vehicleStatusIsNormal = json['vehicleStatusIsNormal'];
    vehicleStatus = json['vehicleStatus'];
    isScratched = json['isScratched'];
    scratches = json['scratches'];
    extraAccessories = json['extraAccessories'];
    upgradeCar = json['upgradeCar'];
    note = json['note'];
    cylinder = json['cylinder'];
    imgCarFrontPositionRight = json['img_car_front_position_right'];
    imgCarFrontPositionLeft = json['img_car_front_position_left'];
    imgCarRearPositionRight = json['img_car_rear_position_right'];
    imgCarRearPositionLeft = json['img_car_rear_position_left'];
    imgChassis = json['img_chassis'];
    imgWindshield = json['img_windshield'];
    video = json['video'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    approvedDate = json['approvedDate'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDeleted = json['isDeleted'];
    isOnline = true;
    createdById = json['createdById'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
    if (json['image_extends'] != null) {
      imageExtends = new List<ImageExtends>();
      json['image_extends'].forEach((v) {
        imageExtends.add(new ImageExtends.fromJson(v));
      });
    }
    ;
    carCategory = json['carCategory'] != null
        ? new CarCategory.fromJson(json['carCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['licensePlates'] = this.licensePlates;
    data['chassisNumber'] = this.chassisNumber;
    data['vehicleNumber'] = this.vehicleNumber;
    data['printeMattersNumber'] = this.printeMattersNumber;
    data['contractNumber'] = this.contractNumber;
    data['effectiveDate'] = this.effectiveDate;
    data['priceCar'] = this.priceCar;
    data['manufacturingYear'] = this.manufacturingYear;
    data['usedYear'] = this.usedYear;
    data['vehicleStatusIsNormal'] = this.vehicleStatusIsNormal;
    data['vehicleStatus'] = this.vehicleStatus;
    data['isScratched'] = this.isScratched;
    data['scratches'] = this.scratches;
    data['extraAccessories'] = this.extraAccessories;
    data['upgradeCar'] = this.upgradeCar;
    data['note'] = this.note;
    data['cylinder'] = this.cylinder;
    data['img_car_front_position_right'] = this.imgCarFrontPositionRight;
    data['img_car_front_position_left'] = this.imgCarFrontPositionLeft;
    data['img_car_rear_position_right'] = this.imgCarRearPositionRight;
    data['img_car_rear_position_left'] = this.imgCarRearPositionLeft;
    data['img_chassis'] = this.imgChassis;
    data['img_windshield'] = this.imgWindshield;
    data['video'] = this.video;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['approvedDate'] = this.approvedDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isDeleted'] = this.isDeleted;
    data['isOnline'] = this.isOnline;
    data['createdById'] = this.createdById;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    if (this.imageExtends != null) {
      data['image_extends'] = this.imageExtends.map((v) => v.toJson()).toList();
    }
    if (this.carCategory != null) {
      data['carCategory'] = this.carCategory.toJson();
    }
    return data;
  }
}

class Customer {
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
  String birthday;

  Customer(
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
      this.birthday});

  Customer.fromJson(Map<String, dynamic> json) {
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
    data['website'] = this.website;
    data['birthday'] = this.birthday;
    return data;
  }
}

class CreatedBy {
  int id;
  String email;
  String password;
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
  String avatarUrl;

  CreatedBy(
      {this.id,
      this.email,
      this.password,
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
      this.avatarUrl});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
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
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
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
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}

class ImageExtends {
  int id;
  String url;
  String createdAt;
  String updateAt;

  ImageExtends({this.id, this.url, this.createdAt, this.updateAt});

  ImageExtends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    createdAt = json['createdAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}

class CarProfileData {
  String idOffline;
  int id;
  int customerId;
  String licensePlates;
  String chassisNumber;
  String vehicleNumber;
  String printeMattersNumber;
  String contractNumber;
  String effectiveDate;
  int priceCar;
  int manufacturingYear;
  int usedYear;
  String vehicleStatus;
  bool vehicleStatusIsNormal;
  String scratches;
  bool isScratched;
  bool extraAccessories;
  String upgradeCar;
  String note;
  String typeCar;
  String cylinder;
  int categoryId;
  String car;
  String imgCarFrontPositionRight;
  String imgCarFrontPositionLeft;
  String imgCarRearPositionRight;
  String imgCarRearPositionLeft;
  String imgWindshield;
  String imgChassis;
  int createdById;
  String video;
  String videoThumbnail;
  String status;
  List<String> imageOptions;
  List<String> listImagesExtendID;
  bool isOnline;
  String latitude;
  String longitude;

  CarProfileData(
      {this.licensePlates,
      this.id,
      this.customerId,
      this.categoryId,
      this.status,
      this.chassisNumber,
      this.vehicleNumber,
      this.printeMattersNumber,
      this.contractNumber,
      this.effectiveDate,
      this.priceCar,
      this.manufacturingYear,
      this.usedYear,
      this.vehicleStatus,
      this.scratches,
      this.upgradeCar,
      this.note,
      this.typeCar,
      this.cylinder,
      this.car,
      this.imgCarFrontPositionRight,
      this.imgCarFrontPositionLeft,
      this.imgCarRearPositionRight,
      this.imgCarRearPositionLeft,
      this.imgChassis,
      this.video,
      this.videoThumbnail,
      this.isOnline,
      this.imgWindshield,
      this.createdById,
      this.longitude,
      this.latitude, this.idOffline});

  CarProfileData updateData(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    customerId = json['customerId'];
    categoryId = json['categoryId'];
    licensePlates = json['licensePlates'];
    chassisNumber = json['chassisNumber'];
    vehicleNumber = json['vehicleNumber'];
    printeMattersNumber = json['printeMattersNumber'];
    contractNumber = json['contractNumber'];
    effectiveDate = json['effectiveDate'];
    priceCar = json['priceCar'];
    manufacturingYear = json['manufacturingYear'];
    usedYear = json['usedYear'];
    vehicleStatus = json['vehicleStatus'];
    vehicleStatusIsNormal = json['vehicleStatusIsNormal'];
    scratches = json['scratches'];
    isScratched = json['isScratched'];
    extraAccessories = json['extraAccessories'];
    upgradeCar = json['upgradeCar'];
    note = json['note'];
    typeCar = json['typeCar'];
    cylinder = json['cylinder'];
    car = json['car'];
    imgCarFrontPositionRight = json['img_car_front_position_right'];
    imgCarFrontPositionLeft = json['img_car_front_position_left'];
    imgCarRearPositionRight = json['img_car_rear_position_right'];
    imgCarRearPositionLeft = json['img_car_rear_position_left'];
    imgWindshield = json['img_windshield'];
    imgChassis = json['img_chassis'];
    video = json['video'];
    videoThumbnail = json['video_thumbnail'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    idOffline = json['idOffline'];
    createdById = json['createdById'];
    if (json['image_extends'] != null) {
      imageOptions = new List<String>();
      json['image_extends'].forEach((v) {
        imageOptions.add(v);
      });
    }
    isOnline = false;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['licensePlates'] = this.licensePlates;
    data['status'] = this.status;
    data['customerId'] = this.customerId;
    data['categoryId'] = this.categoryId;
    data['id'] = this.id;
    data['chassisNumber'] = this.chassisNumber;
    data['vehicleNumber'] = this.vehicleNumber;
    data['printeMattersNumber'] = this.printeMattersNumber;
    data['contractNumber'] = this.contractNumber;
    data['effectiveDate'] = this.effectiveDate;
    data['priceCar'] = this.priceCar;
    data['manufacturingYear'] = this.manufacturingYear;
    data['usedYear'] = this.usedYear;
    data['vehicleStatus'] = this.vehicleStatus;
    data['vehicleStatusIsNormal'] = this.vehicleStatusIsNormal;
    data['scratches'] = this.scratches;
    data['isScratched'] = this.isScratched;
    data['upgradeCar'] = this.upgradeCar;
    data['extraAccessories'] = this.extraAccessories;
    data['note'] = this.note;
    data['typeCar'] = this.typeCar;
    data['cylinder'] = this.cylinder;
    data['car'] = this.car;
    data['img_car_front_position_right'] = this.imgCarFrontPositionRight;
    data['img_car_front_position_left'] = this.imgCarFrontPositionLeft;
    data['img_car_rear_position_right'] = this.imgCarRearPositionRight;
    data['img_car_rear_position_left'] = this.imgCarRearPositionLeft;
    data['img_windshield'] = this.imgWindshield;
    data['img_chassis'] = this.imgChassis;
    data['video'] = this.video;
    data['video_thumbnail'] = this.videoThumbnail;
    data['createdById'] = this.createdById;
    data['latitude']= this.latitude;
    data['longitude'] = this.longitude;
    data['idOffline'] = this.idOffline;
    if (this.imageOptions != null) {
      data['image_extends'] = this.imageOptions.map((v) => v).toList();
    }
    data['isOnline'] = this.isOnline;
    return data;
  }
}

class CarCategory {
  int id;
  String name;
  String description;
  bool active;
  Parent parent;

  CarCategory({this.id, this.name, this.description, this.active, this.parent});

  CarCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['active'] = this.active;
    if (this.parent != null) {
      data['parent'] = this.parent.toJson();
    }
    return data;
  }
}

class Parent {
  int id;
  String name;
  String description;
  bool active;

  Parent({this.id, this.name, this.description, this.active});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['active'] = this.active;
    return data;
  }
}
