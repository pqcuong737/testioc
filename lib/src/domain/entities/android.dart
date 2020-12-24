class AndroidDevice {
  String device;
  String display;
  String fingerprint;
  String board;
  String bootloader;
  String hardware;
  String brand;
  String codename;
  String id;
  String manufacturer;
  String model;
  String product;
  String androidId;
  bool isPhysicalDevice;
  String baseOS;
  String release;

  AndroidDevice(
      {this.device,
        this.display,
        this.fingerprint,
        this.id,
        this.manufacturer,
        this.model,
        this.product,
        this.androidId,
        this.isPhysicalDevice,
        this.baseOS,
        this.release,
        this.codename,
        this.board,
        this.bootloader,
        this.brand,
        this.hardware});

  AndroidDevice.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    display = json['display'];
    fingerprint = json['fingerprint'];
    id = json['id'];
    manufacturer = json['manufacturer'];
    model = json['model'];
    product = json['product'];
    androidId = json['androidId'];
    isPhysicalDevice = json['isPhysicalDevice'];
    baseOS = json['baseOs'];
    release = json['release'];
    codename = json['codename'];
    board = json['board'];
    bootloader = json['bootloader'];
    brand = json['brand'];
    hardware = json['hardware'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device'] = this.device;
    data['display'] = this.display;
    data['fingerprint'] = this.fingerprint;
    data['id'] = this.id;
    data['manufacturer'] = this.manufacturer;
    data['model'] = this.model;
    data['product'] = this.product;
    data['androidId'] = this.androidId;
    data['isPhysicalDevice'] = this.isPhysicalDevice;
    data['release'] = this.release;
    data['baseOs'] = this.baseOS;
    data['codename'] = this.codename;
    data['board'] = this.board;
    data['bootloader'] = this.bootloader;
    data['brand'] = this.brand;
    data['hardware'] = this.hardware;
    return data;
  }
}
