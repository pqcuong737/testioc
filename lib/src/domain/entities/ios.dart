class IosDevice {
  String name;
  bool isPhysicalDevice;
  String identifierForVendor;
  String model;
  String localizedModel;
  String systemVersion;
  String systemName;
  String machine;
  String release;

  IosDevice(
      {this.name,
        this.isPhysicalDevice,
        this.identifierForVendor,
        this.model,
        this.localizedModel,
        this.systemVersion,
        this.systemName,
        this.machine,
        this.release});

  Map toJson() => {
    "name": name,
    "isPhysicalDevice": isPhysicalDevice,
    "identifierForVendor": identifierForVendor,
    "model": model,
    "localizedModel": localizedModel,
    "systemVersion": systemVersion,
    "systemName": systemName,
    "machine": machine,
    "release": release
  };
}